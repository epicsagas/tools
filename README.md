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

### Windows

Download the `.msi` or `-setup.exe` installer from the [Releases](https://github.com/epicsagas/tools/releases) page.

### Manual

Download the archive for your platform from the [Releases](https://github.com/epicsagas/tools/releases) page, extract it, and place the binary in your `PATH`.

```sh
# Example: macOS arm64
tar -xzf tdl_0.1.0_darwin_arm64.tar.xz
mv tdl /usr/local/bin/
```

## Governance

- [`docs/management-rules.md`](docs/management-rules.md): repository-wide release and tagging rules

## Release Policy

- This repository includes only binaries, checksums, and installer-related artifacts.
- Issue reproduction and fixes are handled in each tool's source repository.

## Quick Release Expectations

Every project published here should provide:

- Target-specific artifacts for `darwin`, `linux`, and `windows`
- Architecture-specific builds (`amd64` and `arm64` when supported)
- A `SHA256SUMS.txt` file covering all uploaded assets
- Clear install snippets in each project document under `docs/`

