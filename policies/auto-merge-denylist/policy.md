---
name: auto-merge-denylist
description: "Gate policy for the auto-merge gate: NEVER auto-merge when the PR's change-class is on the never-auto-merge denylist — defer to a human gate. Use during PDCA React whenever a change touches policy/gate machinery, crosses repos, migrates schema/data, bumps dependencies, or adds public surface without tests."
---

NEVER auto-merge when the PR's change-class is on the never-auto-merge denylist — defer to a human gate. The denylist (shipped conservative) covers: policy edits + gradient-policy proposals; gate-machinery / autonomy-surface changes; cross-repo changes; schema or data migrations; dependency / lockfile changes (supply-chain); and public-surface-without-test. The fresh scan-pr evaluator classifies the diff and sets `change_class_allowed=false` for any denylisted class (the exact file enumeration lives in the pr-review rubric's change-class taxonomy). This policy keys on `change_class_allowed==false` — the SAME feature the coverage policy requires true — so the two are provably disjoint (ConflictFreedom). It exists to make the denial an explicit, named defer for the decision corpus rather than a bare "uncovered". Conservative: classes are removed only when explicitly proven safe.

## When this fires

Gate: `auto-merge`. Action: `defer`. Evaluated by `decide-gate.sh` when **all** predicate clauses hold:

- `change_class_allowed` eq `false`

## Why

The paired [`auto-merge-pr`](../auto-merge-pr/policy.md) coverage policy would otherwise leave denylisted changes as a bare `uncovered` verdict. This policy turns that into an explicit, named `defer` so the decision corpus records *why* a human gate was required, not just *that* it was. Keying on the same `change_class_allowed` feature with the opposite value makes the two policies provably disjoint — they can never both fire. Conservative by design: a change-class leaves the denylist only when explicitly proven safe to auto-merge.
