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

Rubric: pyze-workflow [`surfacing-quality`](https://github.com/pyze/pyze-workflow/blob/main/skills/surfacing-quality/SKILL.md) skill — 5 checks. Score: __/5.

- [ ] `description` names the trigger contexts explicitly (artifacts, phases, user phrasings)
- [ ] `description` contains a "use when / before / after / whenever / while" verb cue
- [ ] `description` length 80–400 chars
- [ ] `description` includes ≥1 specific term that prevents spurious firing
- [ ] Manual surfacing test: would Claude have loaded this for the originating incident?
- [ ] (Optional) Ran `skill-creator:skill-creator`'s `improve_description.py` for deeper eval

## Checklist

- [ ] `policies/<name>/policy.md` present with valid skill frontmatter
- [ ] `CHANGELOG.md` `## Unreleased` updated
- [ ] (Optional) `predicate.json` / `spec.allium` / `README.md` included if useful
- [ ] No project-specific identifiers leaked from origin project
