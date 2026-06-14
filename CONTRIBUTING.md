# Contributing to pyze-policies

## What this repo is

Shared policies = Claude Code skills surfaced via description-match. A policy lives in `policies/<policy-name>/policy.md`. When a consumer project's `/policy-sync` runs, it fetches pinned policies and renders them into `.claude/policies/bundles/`.

## Local-first proposal flow

1. Capture the policy in your project's `.claude/policies/bundles/project-rules.md` first.
2. Let it bake — refine the rule across real incidents.
3. When mature, run `/policy-promote` from `pyze-workflow` in the origin project. The command scaffolds a `policies/<name>/` package here and opens a PR with the fields below pre-filled.

## Package layout

```
policies/<policy-name>/
├── policy.md       # REQUIRED
├── predicate.json  # optional
├── spec.allium     # optional
└── README.md       # optional
```

### `policy.md` frontmatter

Reuses Claude Code's skill frontmatter:

```markdown
---
name: <kebab-policy-name>
description: <when this policy should fire — load-bearing for surfacing>
---

<policy body>
```

The `description` is what Claude matches on. Treat it as a trigger, not a summary.

## Surfacing-quality bar

- `description` must mention the trigger contexts explicitly.
- Manual check: would Claude surface this policy when the example incident recurs?
- Consider running `skill-creator` evals for description robustness.

## Review council

Solo (@markaddleman) at launch. Council grows organically as contributors join.

## Versioning

Single repo tag (`vX.Y.Z`). No per-policy semver. Consumers pin via `.pins.toml` with `vX.Y.Z+<short-sha>`.

The plugin-level `version` in `.claude-plugin/plugin.json` gates updates to release tooling and templates — not per-policy content. Per-policy updates land via consumer `/policy-sync` against pinned refs.

## Release

Maintainer runs:

```
scripts/release.sh patch|minor|major --push
```

The script bumps `plugin.json`, rotates the `## Unreleased` section in `CHANGELOG.md` into the new version, commits, tags, and bumps the marketplace entry.
