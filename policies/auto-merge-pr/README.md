# auto-merge-pr

Autonomously merge a PR when the fresh `scan-pr` evaluator's `pr-review` verdict passes all four predicate components.

## Origin

Promoted from the standalone predicate `auto-merge-pr` in `pyze-workflow` on 2026-06-28 (via `/policy-promote --from-predicate`, pyze-workflow#121).

## Rationale

Auto-merge is the canonical autonomy gate: tests green ∧ 0 critical/medium findings ∧ policy-audit clean ∧ change-class allowed → merge, with no human in the loop. Predicate-only, tier-agnostic, reversible. Belongs in the shared repo because every project that wants autonomous PR merge needs the same definition; keeping it project-local guarantees drift.

## Example

A PR opened during PDCA Do is reviewed by a fresh `scan-pr` agent. The rubric returns tests green, zero critical/medium findings, a clean policy-audit, and a change-class not on the denylist → `decide-gate.sh` returns `merge`, and the PR is squash-merged autonomously. Had any component failed — or the change-class been denylisted — the paired `auto-merge-denylist` policy (or a bare uncovered verdict) would defer to a human.
