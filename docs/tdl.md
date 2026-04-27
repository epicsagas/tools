# tdl

Tidal music downloader for macOS, Windows, and Linux.
Supports tracks, albums, playlists, mixes, and music videos.

## Getting Started

### Which file do I download?

Go to the [Releases page](https://github.com/epicsagas/tools/releases), find the latest `tdl-v...` release, and download the file that matches your computer:

| Your computer | Download this file |
|---|---|
| **Windows** (most PCs) | `tdl_..._windows_amd64-setup.exe` |
| **macOS** (Apple Silicon: M1/M2/M3/M4) | `tdl_..._darwin_arm64.app.tar.gz` |
| **macOS** (Intel) | `tdl_..._darwin_amd64.app.tar.gz` |
| **Linux** (Ubuntu/Debian, 64-bit) | `tdl_..._linux_amd64.deb` |
| **Linux** (Ubuntu/Debian, ARM) | `tdl_..._linux_arm64.deb` |

> Not sure which macOS you have? Click the Apple menu () → "About This Mac".
> If it says "Apple M1" or later, choose `arm64`. Otherwise choose `amd64`.

### Windows

1. Download `tdl_..._windows_amd64-setup.exe`
2. Double-click the downloaded file
3. Follow the installer steps
4. Done! Open tdl from the Start menu or desktop shortcut

Alternatively, download `tdl_..._windows_amd64.msi` for a silent/enterprise install:
```
msiexec /i tdl_0.1.0_windows_amd64.msi /quiet
```

### macOS

1. Download `tdl_..._darwin_arm64.app.tar.gz` (or `amd64` for Intel Mac)
2. Open Terminal and run:
   ```sh
   cd ~/Downloads
   tar -xzf tdl_*_darwin_arm64.app.tar.gz
   ```
3. Move `tdl.app` to your Applications folder
4. Double-click `tdl.app` to launch

Or install via Homebrew (if you have it):
```sh
brew tap epicsagas/tap
brew install tdl
```

### Linux

**Ubuntu / Debian:**
```sh
sudo dpkg -i tdl_*_linux_amd64.deb
```

**Other Linux (AppImage):**
1. Download `tdl_..._linux_amd64.AppImage`
2. Make it executable: `chmod +x tdl_*_linux_amd64.AppImage`
3. Double-click or run `./tdl_*_linux_amd64.AppImage`

**Or via Homebrew:**
```sh
brew tap epicsagas/tap
brew install tdl
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
| `tdl_<ver>_windows_amd64-setup.exe` | Windows installer (recommended) |
| `tdl_<ver>_windows_amd64.msi` | Windows installer (enterprise/silent) |
| `tdl_<ver>_windows_amd64.zip` | Windows portable (extract and run) |
| `tdl_<ver>_darwin_arm64.app.tar.gz` | macOS app (Apple Silicon) |
| `tdl_<ver>_darwin_amd64.app.tar.gz` | macOS app (Intel) |
| `tdl_<ver>_darwin_arm64.tar.gz` | macOS CLI binary (Apple Silicon) |
| `tdl_<ver>_darwin_amd64.tar.gz` | macOS CLI binary (Intel) |
| `tdl_<ver>_linux_amd64.deb` | Linux installer (Debian/Ubuntu) |
| `tdl_<ver>_linux_arm64.deb` | Linux installer (Debian/Ubuntu ARM) |
| `tdl_<ver>_linux_amd64.AppImage` | Linux portable (any distro) |
| `tdl_<ver>_linux_arm64.AppImage` | Linux portable (ARM) |
| `tdl_<ver>_linux_amd64.tar.gz` | Linux CLI binary |
| `tdl_<ver>_linux_arm64.tar.gz` | Linux CLI binary (ARM) |
| `SHA256SUMS.txt` | Checksums for verifying downloads |

## License

Apache-2.0
