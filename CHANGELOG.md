# Changelog

## Unreleased

## v0.1.0 — 2026-06-14

Bootstrap pyze-policies repo (#63):

- Plugin manifest, MIT license, README.
- CONTRIBUTING.md documenting package layout (`policies/<name>/policy.md` + optional `predicate.json`, `spec.allium`, `README.md`), local-first proposal flow, `/policy-promote` integration, surfacing-quality bar, and single-tag versioning with `.pins.toml` consumer pinning.
- `.github/` issue + PR templates for policy proposals; tag-triggered GitHub Release workflow.
- `scripts/release.sh` adapted from pyze-workflow: bumps `plugin.json`, rotates `## Unreleased` into the new version section, bumps the marketplace entry, tags, and pushes.
- Empty `policies/` directory (no real policy packages yet; first one lands via `/policy-promote`).
