# Tools Repository Management Rules

This document defines how `epicsagas/tools` is operated as a shared public release repository for multiple CLI projects (`tdl`, `claudy`, etc.).

## Repository Role

- `epicsagas/tools` is a release-artifact repository only.
- Store binaries, checksums, and installer files in GitHub Releases.
- Do not store private source code or internal implementation details.

## Tag and Release Naming

Use per-project release tags:

```
<project-name>-v<semver>
```

Examples:
- `tdl-v0.1.0`
- `claudy-v0.1.0`

Do not use plain `v0.1.0` tags because multiple projects share this repository.

## Versioning Policy

- Follow Semantic Versioning (`MAJOR.MINOR.PATCH`) per project independently.
- Project versions are scoped by the project name prefix in tags.
- Breaking changes must increment MAJOR.

## Release Asset Policy

Each release must include:
- Platform binaries and archives
- `SHA256SUMS.txt`
- Optional installer artifacts (`.msi`, shell/powershell installers)

Keep artifact file names explicit with project and target information. Never upload secrets, debug logs with sensitive data, or internal config files.

### Recommended Asset Naming

Unix archives:
```
<project>_<version>_<os>_<arch>.tar.gz
```

Windows archives:
```
<project>_<version>_<os>_<arch>.zip
```

MSI installers (when provided):
```
<project>-<version>-x86_64-pc-windows-msvc.msi
```

## Multi-Project Coexistence Rules

- One tag corresponds to one project release.
- Do not mix assets for different projects under the same tag.
- Each source repository publishes only its own prefixed tag into `tools`.

## Homebrew Policy

- Keep Homebrew formula management in `epicsagas/homebrew-tap`.
- `tools` provides release assets consumed by formulas.
- Formula is automatically updated by CI on each release.

## CI/CD Pipeline Conventions

Each source project uses one of two pipeline styles depending on build requirements:

### cargo-dist (pure CLI projects, e.g. claudy)

- Use `cargo-dist` to generate `.github/workflows/release.yml`.
- Add a `publish-to-tools` job after the `host` job to mirror artifacts to `epicsagas/tools`.
- cargo-dist handles Homebrew tap updates natively via `publish-homebrew-formula`.
- Tag format accepted: `v<semver>` in source repo; CI normalizes to `claudy-v<semver>` for `tools`.

### Custom workflow (Tauri GUI projects, e.g. tdl)

- Use a hand-written `.github/workflows/release-public.yml`.
- Build with `cargo tauri build --target <target>` per matrix target.
- Package CLI binary separately from GUI bundles in the same job.
- `publish` job uploads all artifacts to `epicsagas/tools` with `tdl-v<ver>` tag.
- `update-homebrew` job computes SHA256 and writes/pushes Formula to `epicsagas/homebrew-tap`.

### Required secrets and variables (both styles)

| Name | Type | Value |
|------|------|-------|
| `PUBLIC_RELEASE_TOKEN` | Secret | PAT with `contents: write` on `epicsagas/tools` |
| `HOMEBREW_TAP_TOKEN` | Secret | PAT with `contents: write` on `epicsagas/homebrew-tap` |
| `PUBLIC_RELEASE_REPO` | Variable | `epicsagas/tools` |

## Source Repository Contract

For every source repository publishing to `tools`:

1. Build in source repo CI (private).
2. Publish artifacts to `epicsagas/tools` release with `<project>-v<ver>` tag.
3. Keep project documentation in `tools/docs/<project>.md`.
4. Link installation commands to `tools` release assets and `epicsagas/homebrew-tap` for Homebrew.

## Documentation Rules

- Root `README.md` stays as a short index.
- Project-specific docs live under `docs/` (e.g. `docs/tdl.md`, `docs/claudy.md`).
- Update docs when release channels, install commands, pipeline style, or supported targets change.

## Operational Checklist (Per Release)

1. Push version tag in source repo (e.g. `tdl-v0.1.0`).
2. CI builds and verifies artifacts.
3. CI publishes artifacts to `epicsagas/tools` with `<project>-v<semver>` tag.
4. CI attaches/updates `SHA256SUMS.txt`.
5. CI updates `epicsagas/homebrew-tap` formula.
6. Verify install paths for macOS, Linux, and Windows.

## Minimum Cross-Platform Coverage

Unless documented otherwise in `docs/<project>.md`, each project publishes:

| OS | Architecture |
|----|-------------|
| macOS | `darwin/amd64`, `darwin/arm64` |
| Linux | `linux/amd64`, `linux/arm64` |
| Windows | `windows/amd64` |

If a target is temporarily unsupported, include a reason and expected restoration plan in the project document.

## Security and Access

- Use least-privilege tokens for release publishing.
- Restrict write access to release automation maintainers.
- Store tokens only in CI secrets; never in code or docs.
- Rotate tokens periodically.
