# auto-merge-denylist

Never auto-merge a PR whose change-class is on the denylist — defer to a human gate, as an explicit named verdict rather than a bare "uncovered".

## Origin

Promoted from the standalone predicate `auto-merge-denylist` in `pyze-workflow` on 2026-06-28 (via `/policy-promote --from-predicate`, pyze-workflow#121).

## Rationale

The safety counterpart to `auto-merge-pr`. Both key on `change_class_allowed`; the coverage policy requires `true`, this one fires on `false` — provably disjoint, so they can never conflict. Shipping them as a pair ensures a project that adopts autonomous merge also adopts the conservative defer for risky change-classes, instead of silently auto-merging them.

## Example

A PR edits gate machinery (`decide-gate.sh`) — a denylisted change-class. The fresh `scan-pr` evaluator sets `change_class_allowed=false`; this policy returns `defer`, and the PR goes to a human with a named reason ("auto-merge-denylist: gate-machinery change"), recorded in the decision corpus.
