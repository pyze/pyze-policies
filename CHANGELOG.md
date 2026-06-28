# Changelog

## Unreleased

## v0.2.0 — 2026-06-28

- Add `auto-merge-pr` policy (promoted from pyze-workflow via `--from-predicate`; pyze-workflow#121). Predicate gate policy: auto-merge a PR when tests green ∧ 0 critical/medium findings ∧ policy-audit clean ∧ change-class allowed.
- Add `auto-merge-denylist` policy (promoted from pyze-workflow via `--from-predicate`; pyze-workflow#121). Paired defer: never auto-merge denylisted change-classes; provably disjoint with `auto-merge-pr`.

## v0.1.0 — 2026-06-14

Bootstrap pyze-policies repo (#63):

- Plugin manifest, MIT license, README.
- CONTRIBUTING.md documenting package layout (`policies/<name>/policy.md` + optional `predicate.json`, `spec.allium`, `README.md`), local-first proposal flow, `/policy-promote` integration, surfacing-quality bar, and single-tag versioning with `.pins.toml` consumer pinning.
- `.github/` issue + PR templates for policy proposals; tag-triggered GitHub Release workflow.
- `scripts/release.sh` adapted from pyze-workflow: bumps `plugin.json`, rotates `## Unreleased` into the new version section, bumps the marketplace entry, tags, and pushes.
- Empty `policies/` directory (no real policy packages yet; first one lands via `/policy-promote`).
