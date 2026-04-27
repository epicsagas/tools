# claudy

Modern multi-provider launcher for Claude CLI, written in Rust.

Manages multiple Claude Code provider profiles and modes with a unified CLI.

## Getting Started

### Which file do I download?

Go to the [Releases page](https://github.com/epicsagas/tools/releases), find the latest `claudy-v...` release, and download the file that matches your computer:

| Your computer | Download this file |
|---|---|
| **Windows** (most PCs) | `claudy-<ver>-x86_64-pc-windows-msvc.zip` |
| **macOS** (Apple Silicon: M1/M2/M3/M4) | `claudy-<ver>-aarch64-apple-darwin.tar.gz` |
| **macOS** (Intel) | `claudy-<ver>-x86_64-apple-darwin.tar.gz` |
| **Linux** (Ubuntu/Debian, 64-bit) | `claudy-<ver>-x86_64-unknown-linux-gnu.tar.gz` |
| **Linux** (ARM) | `claudy-<ver>-aarch64-unknown-linux-gnu.tar.gz` |

> Not sure which macOS you have? Click the Apple menu () → "About This Mac".
> If it says "Apple M1" or later, choose `aarch64`. Otherwise choose `x86_64`.

### macOS

1. Download `claudy-<ver>-aarch64-apple-darwin.tar.gz` (or `x86_64` for Intel Mac)
2. Open Terminal and run:
   ```sh
   cd ~/Downloads
   tar -xzf claudy-*-aarch64-apple-darwin.tar.gz
   ```
3. Move the `claudy` binary to your PATH:
   ```sh
   sudo mv claudy /usr/local/bin/
   ```

Or install via Homebrew (recommended):
```sh
brew tap epicsagas/tap
brew install claudy
```

### Linux

1. Download `claudy-<ver>-x86_64-unknown-linux-gnu.tar.gz`
2. Extract and install:
   ```sh
   cd ~/Downloads
   tar -xzf claudy-*-x86_64-unknown-linux-gnu.tar.gz
   sudo mv claudy /usr/local/bin/
   ```

Or via Homebrew:
```sh
brew tap epicsagas/tap
brew install claudy
```

### Windows

1. Download `claudy-<ver>-x86_64-pc-windows-msvc.zip`
2. Extract the zip file
3. Move `claudy.exe` to a folder in your PATH

For silent/enterprise install, use the MSI installer:
```powershell
msiexec /i claudy-0.1.0-x86_64-pc-windows-msvc.msi /quiet
```

### Quick Install (Shell Script)

**macOS / Linux:**
```sh
curl --proto '=https' --tlsv1.2 -LsSf \
  https://github.com/epicsagas/tools/releases/latest/download/claudy-installer.sh | sh
```

**Windows (PowerShell):**
```powershell
irm https://github.com/epicsagas/tools/releases/latest/download/claudy-installer.ps1 | iex
```

## First-Time Setup

### 1. Verify installation

```sh
claudy --version
```

### 2. List available profiles

```sh
claudy ls
```

This shows all provider profiles claudy can resolve from its catalog.

### 3. Launch Claude with a profile

```sh
claudy run <profile> --
```

Or using the shorthand:
```sh
claudy <profile>
```

### 4. Where are my files?

Claudy config directory: `~/.claudy/`
Modes directory: `~/.claudy/modes/<name>/`

## Usage

```sh
claudy --help                  # Show all commands
claudy ls                      # List available profiles
claudy info <profile>          # Show profile details and resolved credentials
claudy run <profile> -- <args> # Launch Claude Code with a profile
claudy <profile> <mode>        # Launch with profile + mode
claudy status                  # Check claudy health and configuration
claudy setup/config            # Edit claudy settings
claudy diagnostics             # Troubleshoot setup issues
```

## Modes

A `mode` is a user-managed Claude config directory. When active, claudy sets `CLAUDE_CONFIG_DIR` to that path for the session, giving each mode its own isolated settings, history, and memory.

Mode name rule: `[a-z0-9][a-z0-9_-]*` (the name `mode` is reserved)

```sh
claudy mode create work        # Create a "work" mode
claudy mode create personal    # Create a "personal" mode
claudy mode ls                 # List all modes
claudy mode rm <name>          # Delete a mode
```

Use a mode when launching:
```sh
claudy <profile> work          # Launch profile with "work" mode
```

## Features

- Profile-based target resolution through catalog and custom profile chains
- Secure secret/env wiring for provider authentication
- Unified launch orchestration (resolve → env → spawn)
- User-defined Claude config modes (`~/.claudy/modes/<name>`)
- Operational subcommands: install, update, status, config, diagnostics
- Channel bridge (Telegram/Slack/Discord) — in development

## Supported Platforms

| OS | Architecture |
|---|---|
| macOS | `arm64`, `amd64` |
| Linux | `amd64`, `arm64` |
| Windows | `amd64` |

## Configuration

Settings file: `~/.claudy/config.toml`

You can also edit settings by running `claudy config`.

Key directories:

| Path | Purpose |
|---|---|
| `~/.claudy/` | Main config directory |
| `~/.claudy/modes/<name>/` | Per-mode Claude config |
| `~/.claudy/catalog/` | Profile catalog |

## All Release Assets

| File | What it is |
|---|---|
| `claudy-<ver>-aarch64-apple-darwin.tar.gz` | macOS CLI binary (Apple Silicon) |
| `claudy-<ver>-x86_64-apple-darwin.tar.gz` | macOS CLI binary (Intel) |
| `claudy-<ver>-x86_64-unknown-linux-gnu.tar.gz` | Linux CLI binary (amd64) |
| `claudy-<ver>-aarch64-unknown-linux-gnu.tar.gz` | Linux CLI binary (arm64) |
| `claudy-<ver>-x86_64-pc-windows-msvc.zip` | Windows CLI binary (portable) |
| `claudy-<ver>-x86_64-pc-windows-msvc.msi` | Windows MSI installer (enterprise) |
| `claudy-installer.sh` | Shell installer (macOS/Linux) |
| `claudy-installer.ps1` | PowerShell installer (Windows) |
| `claudy.rb` | Homebrew formula |
| `SHA256SUMS.txt` | Checksums for verifying downloads |

## CI/CD Pipeline

Source repo: `epicsagas/claudy` (private)

Pipeline: `.github/workflows/release.yml` (generated by cargo-dist)

- Trigger: push of version tag (e.g. `v0.1.0` or `claudy-v0.1.0`), or pull request (plan only)
- Builds via `cargo dist build` across all targets
- Publishes to `epicsagas/tools` with `claudy-v<ver>` tag via `publish-to-tools` job
- Updates `epicsagas/homebrew-tap` Formula/claudy.rb via cargo-dist `publish-homebrew-formula` job

Required secrets and variables in source repo:

| Name | Type | Description |
|---|---|---|
| `PUBLIC_RELEASE_TOKEN` | Secret | PAT with write access to `epicsagas/tools` |
| `HOMEBREW_TAP_TOKEN` | Secret | PAT with write access to `epicsagas/homebrew-tap` |
| `PUBLIC_RELEASE_REPO` | Variable | `epicsagas/tools` |

## Related Docs

- Repository governance: `docs/management-rules.md`

## License

Apache-2.0
