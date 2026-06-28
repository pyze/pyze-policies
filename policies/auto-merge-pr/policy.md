---
name: auto-merge-pr
description: "Gate policy for the auto-merge gate: autonomously merge a PR when the fresh scan-pr evaluator's pr-review verdict passes all four predicate components — tests green, 0 critical/medium findings, policy-audit clean, and change-class allowed (not denylisted). Use during PDCA React when deciding whether a green PR may merge without a human."
---

Auto-merge a PR autonomously when the pr-review rubric verdict (produced by the fresh scan-pr evaluator) passes all four predicate components: tests green AND 0 critical/medium findings AND policy-audit clean AND change-class allowed (not denylisted). This is predicate-only with no tier backstop — the policy deliberately carries no blast_radius clause, so the gate is tier-agnostic (any tier auto-merges when the predicate holds). Merge is reversible (git revert; a post-merge monitor backstops it). The runner is a fresh non-implementer agent (scan-pr), so the predicate is mechanical, not self-judgment.

## When this fires

Gate: `auto-merge`. Action: `merge`. Evaluated by `decide-gate.sh` when **all** predicate clauses hold:

- `tests_green` eq `true`
- `findings_clean` eq `true`
- `policy_audit_clean` eq `true`
- `change_class_allowed` eq `true`

## Why

Auto-merge is the one gate authorized to run autonomously regardless of the project autonomy ceiling. It is safe because three properties hold together: the runner is a fresh non-implementer agent (no self-review), the predicate is fully mechanical (not a judgment call), and a merge is reversible (git revert, plus a post-merge monitor). Pairs with [`auto-merge-denylist`](../auto-merge-denylist/policy.md), which defers denylisted change-classes (policy edits, gate machinery, cross-repo, schema/data migrations, dependency bumps, public-surface-without-test) to a human gate. The two key on the same `change_class_allowed` feature with opposite values, so they are provably disjoint.
