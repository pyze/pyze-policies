#!/usr/bin/env bash
# Atomic release: bump plugin.json + rotate CHANGELOG + bump marketplace entry, commit, tag.
#
# Usage:
#   scripts/release.sh patch|minor|major [--push]
#
# Run AFTER content commits are in place. Makes a separate release commit so
# content history stays readable.
#
# Env:
#   MARKETPLACE_REPO  Path to claude-plugin-marketplace checkout.
#                     Defaults to $HOME/dev/claude-plugin-marketplace.

set -euo pipefail

BUMP="${1:-}"
PUSH="${2:-}"

if [[ -z "$BUMP" || ! "$BUMP" =~ ^(patch|minor|major)$ ]]; then
  echo "Usage: $0 patch|minor|major [--push]" >&2
  exit 2
fi

cd "$(dirname "$0")/.."
PLUGIN_ROOT="$(pwd)"
MKT="${MARKETPLACE_REPO:-$HOME/dev/claude-plugin-marketplace}"

if [[ ! -f "$MKT/.claude-plugin/marketplace.json" ]]; then
  echo "Marketplace not found at $MKT (set MARKETPLACE_REPO)" >&2
  exit 1
fi

if [[ -n "$(git status --porcelain .claude-plugin/plugin.json CHANGELOG.md)" ]]; then
  echo "plugin.json or CHANGELOG.md has uncommitted changes — commit or stash first" >&2
  exit 1
fi

check_fresh_main() {
  local label="$1" dir="$2"
  local branch local_sha remote_sha
  branch=$(git -C "$dir" rev-parse --abbrev-ref HEAD)
  if [[ "$branch" != "main" ]]; then
    echo "$label: not on main (HEAD=$branch)" >&2
    exit 1
  fi
  git -C "$dir" fetch --quiet origin main
  local_sha=$(git -C "$dir" rev-parse HEAD)
  remote_sha=$(git -C "$dir" rev-parse origin/main)
  if [[ "$local_sha" != "$remote_sha" ]]; then
    echo "$label: local main ($local_sha) != origin/main ($remote_sha) — pull/rebase first" >&2
    exit 1
  fi
}

check_fresh_main "pyze-policies" "$PLUGIN_ROOT"
check_fresh_main "marketplace"   "$MKT"

bump_version() {
  local cur="$1" kind="$2" maj min pat
  IFS='.' read -r maj min pat <<<"$cur"
  case "$kind" in
    major) echo "$((maj+1)).0.0" ;;
    minor) echo "${maj}.$((min+1)).0" ;;
    patch) echo "${maj}.${min}.$((pat+1))" ;;
  esac
}

CUR=$(jq -r '.version' .claude-plugin/plugin.json)
NEW=$(bump_version "$CUR" "$BUMP")
echo "pyze-policies: $CUR -> $NEW"

jq --arg v "$NEW" '.version = $v' .claude-plugin/plugin.json > .claude-plugin/plugin.json.tmp
mv .claude-plugin/plugin.json.tmp .claude-plugin/plugin.json

# Rotate CHANGELOG: rename '## Unreleased' to '## vX.Y.Z — DATE' and add a fresh '## Unreleased'.
DATE=$(date -u +%Y-%m-%d)
awk -v v="$NEW" -v d="$DATE" '
  !done && /^## Unreleased$/ {
    print "## Unreleased"
    print ""
    print "## v" v " — " d
    done=1
    next
  }
  { print }
' CHANGELOG.md > CHANGELOG.md.tmp
mv CHANGELOG.md.tmp CHANGELOG.md

MKT_CUR=$(jq -r '.metadata.version' "$MKT/.claude-plugin/marketplace.json")
MKT_NEW=$(bump_version "$MKT_CUR" patch)
echo "marketplace metadata: $MKT_CUR -> $MKT_NEW"

jq --arg v "$NEW" --arg m "$MKT_NEW" '
  .metadata.version = $m
  | (.plugins[] | select(.name == "pyze-policies") | .version) = $v
' "$MKT/.claude-plugin/marketplace.json" > "$MKT/.claude-plugin/marketplace.json.tmp"
mv "$MKT/.claude-plugin/marketplace.json.tmp" "$MKT/.claude-plugin/marketplace.json"

git add .claude-plugin/plugin.json CHANGELOG.md
git commit -m "chore: bump pyze-policies to $NEW"
git tag -a "v$NEW" -m "Release v$NEW"

(cd "$MKT" \
  && git add .claude-plugin/marketplace.json \
  && git commit -m "chore: bump pyze-policies to $NEW")

echo
echo "Released v$NEW. Tag: v$NEW"
if [[ "$PUSH" == "--push" ]]; then
  echo "Pushing..."
  git push --follow-tags
  (cd "$MKT" && git push)
else
  echo "Run with --push to push, or push manually:"
  echo "  git -C $PLUGIN_ROOT push --follow-tags"
  echo "  git -C $MKT push"
fi
