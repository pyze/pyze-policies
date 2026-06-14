## Policy

<!-- policy package name, kebab-case -->
Name:
Adds / updates / removes:

## Triggering example or incident

<!-- Concrete situation where this policy would have helped -->

## Applies-to scope

<!-- Which projects, languages, phases. Be specific. -->

## Rationale: share vs keep local

<!-- Why does this belong in pyze-policies vs each project's local rules? -->

## Surfacing quality

- [ ] `description` mentions the trigger contexts explicitly
- [ ] Considered skill-creator eval for description robustness
- [ ] Manual check: would Claude surface this when the example incident recurs?

## Checklist

- [ ] `policies/<name>/policy.md` present with valid skill frontmatter
- [ ] `CHANGELOG.md` `## Unreleased` updated
- [ ] (Optional) `predicate.json` / `spec.allium` / `README.md` included if useful
- [ ] No project-specific identifiers leaked from origin project
