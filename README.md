# pyze-policies

Shared Pyze policies (Claude Code skills) surfaced via description-match.

Policies in this repo are fetched by `pyze-workflow`'s `/policy-sync` command and rendered into a consumer project's `.claude/policies/bundles/`. The plugin manifest is included so this repo is marketplace-installable; per-policy content is still version-pinned via `.pins.toml` in the consumer project.

## Layout

```
policies/<policy-name>/
├── policy.md       # REQUIRED: skill frontmatter (name, description) + body
├── predicate.json  # optional: machine-checkable predicate
├── spec.allium     # optional: formal spec
└── README.md       # optional: rationale, examples
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Policy proposals are typically scaffolded by `/policy-promote` in `pyze-workflow` from a project's local `project-rules.md` bundle.

## Install

Via the Pyze marketplace, then pin via `.pins.toml` in your consumer project.

## License

MIT
