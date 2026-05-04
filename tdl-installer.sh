#!/bin/sh
set -eu

REPO="epicsagas/tools"
BINARY="tdl"
INSTALL_DIR="${TDL_INSTALL_DIR:-/usr/local/bin}"

# Resolve OS
case "$(uname -s)" in
  Darwin) os="darwin" ;;
  Linux)  os="linux"  ;;
  *)
    echo "Unsupported OS: $(uname -s)" >&2
    exit 1
    ;;
esac

# Resolve arch
case "$(uname -m)" in
  arm64|aarch64) arch="arm64" ;;
  x86_64|amd64)  arch="amd64" ;;
  *)
    echo "Unsupported architecture: $(uname -m)" >&2
    exit 1
    ;;
esac

# Fetch latest version tag (tdl-vX.Y.Z)
API_URL="https://api.github.com/repos/${REPO}/releases"
if command -v curl >/dev/null 2>&1; then
  FETCH="curl --proto '=https' --tlsv1.2 -fsSL"
elif command -v wget >/dev/null 2>&1; then
  FETCH="wget -qO-"
else
  echo "curl or wget is required." >&2
  exit 1
fi

LATEST_TAG=$(eval "$FETCH" "$API_URL" \
  | grep '"tag_name"' \
  | grep '"tdl-v' \
  | head -1 \
  | sed 's/.*"tag_name": *"\(tdl-v[^"]*\)".*/\1/')

if [ -z "$LATEST_TAG" ]; then
  echo "Failed to determine the latest tdl release." >&2
  exit 1
fi

VERSION="${LATEST_TAG#tdl-v}"
ARCHIVE="${BINARY}_${VERSION}_${os}_${arch}.tar.gz"
BASE_URL="https://github.com/${REPO}/releases/download/${LATEST_TAG}"
DOWNLOAD_URL="${BASE_URL}/${ARCHIVE}"
CHECKSUM_URL="${BASE_URL}/SHA256SUMS.txt"

TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

echo "Downloading tdl ${VERSION} (${os}/${arch})..."
eval "$FETCH" "$DOWNLOAD_URL" -o "$TMPDIR/$ARCHIVE"

# Verify checksum when shasum/sha256sum is available
if command -v shasum >/dev/null 2>&1; then
  eval "$FETCH" "$CHECKSUM_URL" -o "$TMPDIR/SHA256SUMS.txt"
  (cd "$TMPDIR" && grep " ${ARCHIVE}$" SHA256SUMS.txt | shasum -a 256 -c -)
elif command -v sha256sum >/dev/null 2>&1; then
  eval "$FETCH" "$CHECKSUM_URL" -o "$TMPDIR/SHA256SUMS.txt"
  (cd "$TMPDIR" && grep " ${ARCHIVE}$" SHA256SUMS.txt | sha256sum -c -)
else
  echo "Warning: shasum/sha256sum not found — skipping checksum verification." >&2
fi

tar -xzf "$TMPDIR/$ARCHIVE" -C "$TMPDIR"

INSTALL_PATH="${INSTALL_DIR}/${BINARY}"

if [ -w "$INSTALL_DIR" ]; then
  mv "$TMPDIR/$BINARY" "$INSTALL_PATH"
else
  echo "Installing to ${INSTALL_DIR} (sudo required)..."
  sudo mv "$TMPDIR/$BINARY" "$INSTALL_PATH"
fi

chmod +x "$INSTALL_PATH"

echo "Installed tdl ${VERSION} → ${INSTALL_PATH}"
echo "Run 'tdl --help' to get started."
