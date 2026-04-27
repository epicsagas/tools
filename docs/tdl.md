# tdl

Tidal music downloader written in Rust. Provides CLI, TUI, and GUI (Tauri) interfaces.

## Supported Platforms

| OS | Architecture | Archive | Native Installer |
|----|-------------|---------|-----------------|
| macOS | `arm64` | `.tar.gz` | `.dmg` |
| macOS | `amd64` | `.tar.gz` | `.dmg` |
| Linux | `amd64` | `.tar.gz` | `.deb`, `.AppImage` |
| Linux | `arm64` | `.tar.gz` | `.deb`, `.AppImage` |
| Windows | `amd64` | `.zip` | `.msi`, `-setup.exe` |

The archive and native installer contain the **same binary**. GUI is built in by default (`features = ["gui"]`). The archive is for PATH-based use (CLI/TUI/GUI all work); the native installer packages it as an OS app bundle.

## Features

- OAuth device authorization and PKCE login (required for HiRes Lossless)
- Download tracks, albums, playlists, mixes, and videos
- AES-128-CTR file decryption
- BTS JSON and MPEG-DASH (MPD) manifest parsing
- Parallel segment downloading with retry and exponential backoff
- FLAC/M4A metadata tagging (lofty)
- ReplayGain tag support
- Cover art embedding and standalone `cover.jpg`
- Synced lyrics (`.lrc`) export and embedding
- TS to MP4 conversion via FFmpeg
- FLAC extraction from MP4 containers
- M3U8 / M3U playlist file generation
- Browse and download favorites (tracks, albums, artists, videos)
- Three interfaces: CLI, TUI, and GUI (Tauri 2)

## Requirements

- Rust 1.80+ (build only)
- FFmpeg (optional; required for video conversion and FLAC extraction)
- A Tidal subscription

## Installation

### Homebrew (macOS/Linux)

```sh
brew tap epicsagas/tap
brew install tdl
```

### Download from Releases

1. Open the `epicsagas/tools` release page.
2. Select the `tdl-v<version>` tag.
3. Download the archive matching your OS/architecture.
4. Verify checksum using `SHA256SUMS.txt`.
5. Extract and place `tdl` in your `PATH`.

### Windows (PowerShell)

```powershell
# Replace version as needed
Invoke-WebRequest -Uri https://github.com/epicsagas/tools/releases/download/tdl-v0.1.0/tdl_0.1.0_windows_amd64.zip -OutFile tdl.zip
Expand-Archive .\tdl.zip -DestinationPath .\tdl
```

Or use the `.msi` installer for a GUI installation experience.

## Quick Usage

### Login

```sh
tdl login           # OAuth device authorization (standard)
tdl login --pkce    # PKCE flow (required for HiRes Lossless)
```

### Download

```sh
tdl dl https://tidal.com/browse/track/12345
tdl dl https://tidal.com/browse/album/67890
tdl dl --list urls.txt
```

### Favorites

```sh
tdl fav tracks
tdl fav albums
tdl fav artists
tdl fav videos
```

### Interfaces

```sh
tdl tui     # terminal UI
tdl gui     # desktop GUI (Tauri)
tdl         # defaults to GUI
```

## Configuration

Settings file: `~/.tdl/settings.json`

Key options:

- Download base path and output path templates
- Audio/video quality (`hi_res_lossless` requires PKCE login)
- Concurrency and retry behavior
- Metadata, cover art, and lyrics options
- Playlist file format (`m3u8` default, `m3u` for legacy DAP compatibility)
- FFmpeg path and conversion/extraction toggles

## Release Assets

Artifacts per release:

| File | Type | Notes |
|------|------|-------|
| `tdl_<ver>_darwin_arm64.tar.gz` | Archive | macOS arm64 — extract and add to PATH |
| `tdl_<ver>_darwin_amd64.tar.gz` | Archive | macOS amd64 — extract and add to PATH |
| `tdl_<ver>_linux_arm64.tar.gz` | Archive | Linux arm64 — extract and add to PATH |
| `tdl_<ver>_linux_amd64.tar.gz` | Archive | Linux amd64 — extract and add to PATH |
| `tdl_<ver>_windows_amd64.zip` | Archive | Windows amd64 — extract and add to PATH |
| `tdl_<ver>_darwin_arm64.dmg` | Installer | macOS arm64 app bundle |
| `tdl_<ver>_darwin_amd64.dmg` | Installer | macOS amd64 app bundle |
| `tdl_<ver>_linux_amd64.deb` | Installer | Debian/Ubuntu amd64 |
| `tdl_<ver>_linux_arm64.deb` | Installer | Debian/Ubuntu arm64 |
| `tdl_<ver>_linux_amd64.AppImage` | Installer | Linux amd64 portable |
| `tdl_<ver>_linux_arm64.AppImage` | Installer | Linux arm64 portable |
| `tdl_<ver>_windows_amd64.msi` | Installer | Windows MSI |
| `tdl_<ver>_windows_amd64-setup.exe` | Installer | Windows NSIS |
| `SHA256SUMS.txt` | Checksum | SHA256 for all archives |

## CI/CD Pipeline

Source repo: `epicsagas/tdl` (private)

Pipeline: `.github/workflows/release-public.yml`

- Trigger: push of `v*` or `tdl-v*` tag, or manual `workflow_dispatch`
- Builds via `cargo tauri build` (one binary with GUI built in; also produces OS installer bundles)
- Packages the binary as an archive (`.tar.gz` / `.zip`) and as native OS installers per target
- Publishes all artifacts to `epicsagas/tools` with `tdl-v<ver>` tag
- Updates `epicsagas/homebrew-tap` Formula/tdl.rb with new version and SHA256

Required secrets and variables in source repo:

| Name | Type | Description |
|------|------|-------------|
| `PUBLIC_RELEASE_TOKEN` | Secret | PAT with write access to `epicsagas/tools` |
| `HOMEBREW_TAP_TOKEN` | Secret | PAT with write access to `epicsagas/homebrew-tap` |
| `PUBLIC_RELEASE_REPO` | Variable | `epicsagas/tools` |

## License

Apache-2.0
