# tdl

Tidal music downloader for macOS, Windows, and Linux.
Supports tracks, albums, playlists, mixes, and music videos.

## Getting Started

### Quick Install (Recommended)

**macOS / Linux:**
```sh
curl --proto '=https' --tlsv1.2 -LsSf \
  https://github.com/epicsagas/tools/releases/latest/download/tdl-installer.sh | sh
```

**Windows (PowerShell):**
```powershell
irm https://github.com/epicsagas/tools/releases/latest/download/tdl-installer.ps1 | iex
```

### Homebrew (macOS / Linux)

```sh
brew tap epicsagas/tap
brew install tdl
```

### Manual Download

Go to the [Releases page](https://github.com/epicsagas/tools/releases), find the latest `tdl-v...` release, and download the file that matches your computer:

| Your computer | Download this file |
|---|---|
| **Windows** (most PCs) | `tdl-x86_64-pc-windows-msvc.zip` |
| **macOS** (Apple Silicon: M1/M2/M3/M4) | `tdl-aarch64-apple-darwin.tar.xz` |
| **macOS** (Intel) | `tdl-x86_64-apple-darwin.tar.xz` |
| **Linux** (Ubuntu/Debian, 64-bit) | `tdl-x86_64-unknown-linux-gnu.tar.xz` |
| **Linux** (ARM) | `tdl-aarch64-unknown-linux-gnu.tar.xz` |

> Not sure which macOS you have? Click the Apple menu () → "About This Mac".
> If it says "Apple M1" or later, choose `aarch64`. Otherwise choose `x86_64`.

#### macOS / Linux

```sh
cd ~/Downloads
tar -xJf tdl-*-aarch64-apple-darwin.tar.xz   # macOS Apple Silicon
# or
tar -xJf tdl-*-x86_64-unknown-linux-gnu.tar.xz  # Linux x64
sudo mv tdl /usr/local/bin/
```

#### Windows

1. Download `tdl-x86_64-pc-windows-msvc.zip`
2. Extract the zip file
3. Move `tdl.exe` to a folder in your PATH

For silent/enterprise install, use the MSI installer:
```powershell
msiexec /i tdl-0.2.1-x86_64-pc-windows-msvc.msi /quiet
```

## First-Time Setup

### 1. Login to Tidal

Open a terminal (or the GUI settings) and run:

```sh
tdl login
```

This opens a link in your browser. Sign in with your Tidal account and approve the connection.

**For HiRes Lossless quality**, use the PKCE login instead:
```sh
tdl login --pkce
```

### 2. Download music

Copy a Tidal URL from your browser or the Tidal app, then:

```sh
tdl dl https://tidal.com/browse/album/12345
```

Or paste it into the GUI download bar.

### 3. Where are my files?

Downloaded files are saved to `~/download` by default. You can change this in Settings.

## Interfaces

tdl has three ways to use it:

| Interface | How to open | Best for |
|---|---|---|
| **GUI** (desktop app) | Double-click the app, or run `tdl` | Most users |
| **TUI** (terminal UI) | Run `tdl tui` | Terminal users who prefer a visual layout |
| **CLI** (command line) | Run `tdl dl <url>` | Automation and scripting |

## Features

- Download tracks, albums, playlists, mixes, and music videos
- FLAC lossless and HiRes Lossless quality (requires PKCE login)
- Automatic metadata tagging (artist, album, track number, etc.)
- Cover art embedding and standalone `cover.jpg`
- Synced lyrics (`.lrc`) download
- M3U8 playlist file generation
- Parallel downloads with automatic retry
- Browse and download your Tidal favorites

## Requirements

- A Tidal subscription
- FFmpeg (optional; only needed for video downloads and FLAC extraction)

## Configuration

Settings file: `~/.tdl/settings.json`

You can also edit settings in the GUI or by running `tdl cfg`.

Key options:

| Setting | Description |
|---|---|
| Download path | Where files are saved (default: `~/download`) |
| Audio quality | `low_96k` / `low_320k` / `high_lossless` / `hi_res_lossless` |
| Video quality | `p360` / `p480` / `p720` / `p1080` |
| Cover art | Embed in audio files + save `cover.jpg` per album |
| Lyrics | Embed synced lyrics and/or save `.lrc` files |
| Playlist format | `m3u8` (default, UTF-8) or `m3u` (for older DAP devices) |

## All Release Assets

| File | What it is |
|---|---|
| `tdl-installer.sh` | Shell installer (macOS/Linux) |
| `tdl-installer.ps1` | PowerShell installer (Windows) |
| `tdl-aarch64-apple-darwin.tar.xz` | macOS CLI binary (Apple Silicon) |
| `tdl-x86_64-apple-darwin.tar.xz` | macOS CLI binary (Intel) |
| `tdl-aarch64-unknown-linux-gnu.tar.xz` | Linux CLI binary (arm64) |
| `tdl-x86_64-unknown-linux-gnu.tar.xz` | Linux CLI binary (amd64) |
| `tdl-x86_64-pc-windows-msvc.zip` | Windows CLI binary (portable) |
| `tdl-x86_64-pc-windows-msvc.msi` | Windows MSI installer (enterprise) |
| `SHA256SUMS.txt` | Checksums for verifying downloads |
| `sha256.sum` | Per-file checksums (`.sha256` sidecar) |

## License

Apache-2.0
