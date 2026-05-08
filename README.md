# EpicSagas Tools

[![GitHub Release](https://img.shields.io/github/v/release/epicsagas/tools?sort=semver)](https://github.com/epicsagas/tools/releases)
[![GitHub Downloads (all assets, all releases)](https://img.shields.io/github/downloads/epicsagas/tools/total)](https://github.com/epicsagas/tools/releases)
[![License](https://img.shields.io/github/license/epicsagas/tools)](LICENSE)
[![Buy Me a Coffee](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-FFDD00?style=flat&logo=buy-me-a-coffee&logoColor=black)](https://buymeacoffee.com/epicsaga)

`epicsagas/tools` is the **public binary release repository** for CLI tools published by EpicSagas.

This repository contains only release artifacts for end users, such as binaries, checksums, and installer files.

## Included Tools

- [`tdl`](docs/tdl.md): TIDAL media downloader (CLI/TUI/GUI, macOS/Linux/Windows) — [Install Guide](docs/tdl.md#getting-started)
- [`claudy`](docs/claudy.md): Multi-provider launcher for Claude Code with user-defined config modes (macOS/Linux/Windows)

## Installation

### Homebrew (macOS / Linux)

```sh
brew tap epicsagas/tap
brew install tdl
brew install claudy
```

### Manual

All releases are published as open source on GitHub. Download the binary for your platform from the [Releases page](https://github.com/epicsagas/tools/releases):

1. Go to [Releases](https://github.com/epicsagas/tools/releases)
2. Find the latest release for your tool (`tdl-v*` or `claudy-v*`)
3. Download the file matching your OS and architecture
4. Extract the archive and place the binary in your `PATH`

#### Quick Links:
- [tdl Releases](https://github.com/epicsagas/tools/releases?q=tdl)
- [claudy Releases](https://github.com/epicsagas/tools/releases?q=claudy)

```sh
# Example: Extract macOS arm64 tdl binary
tar -xzf tdl_0.1.0_darwin_arm64.app.tar.gz
mv tdl /usr/local/bin/

# Example: Extract Linux claudy binary
tar -xJf claudy-0.1.0-x86_64-unknown-linux-gnu.tar.xz
sudo mv claudy /usr/local/bin/
```

## Governance

- [`docs/management-rules.md`](docs/management-rules.md): repository-wide release and tagging rules

## Open Source

This repository publishes open source CLI tools under the Apache-2.0 license. All source code and releases are available publicly.

### Contributing

- Report bugs and request features on [GitHub Issues](https://github.com/epicsagas/tools/issues)
- Source code is available in this repository
- Community contributions are welcome - please see individual tool docs for contribution guidelines

## Release Policy

- This repository includes only binaries, checksums, and installer-related artifacts.
- Issue reproduction and fixes are handled in each tool's source repository.
- All releases are built from the source code in this repository.

## Quick Release Expectations

Every project published here should provide:

- Target-specific artifacts for `darwin`, `linux`, and `windows`
- Architecture-specific builds (`amd64` and `arm64` when supported)
- A `SHA256SUMS.txt` file covering all uploaded assets
- Clear install snippets in each project document under `docs/`

