#!/usr/bin/env bash
# === COMMANDER AUTOMATION INSTALLER (mac/linux — reads /VERSION) ===
# Usage: automation/install.sh /path/to/project
# Mirrors install-automation.bat: vendors rules + hooks + skills locally,
# no network fetch. Works with a PRIVATE Commander repo.
set -e

TARGET="${1:?Usage: install.sh /path/to/project}"
SOURCE="$(cd "$(dirname "$0")" && pwd)"     # automation/
CROOT="$(cd "$SOURCE/.." && pwd)"           # repo root (holds VERSION + docs)
CVER="$(tr -d ' \n' < "$CROOT/VERSION")"

[ -d "$TARGET" ] || { echo "[FAIL] Target does not exist: $TARGET"; exit 1; }
echo "Installing Commander v$CVER into: $TARGET"

mkdir -p "$TARGET/.claude/hooks" "$TARGET/corrections" "$TARGET/.commander"

# vendor rule docs locally (so .commander/ paths resolve — no fetch)
cp "$CROOT"/*.md "$TARGET/.commander/"
cp "$CROOT/VERSION" "$TARGET/.commander/VERSION"
echo "[OK] Rule docs vendored into .commander/ (local, no fetch)"

# hooks
cp "$SOURCE"/.claude/hooks/*.js "$TARGET/.claude/hooks/"

# skills
[ -d "$SOURCE/.claude/skills" ] && cp -r "$SOURCE/.claude/skills" "$TARGET/.claude/" && \
  echo "[OK] Skills installed: /kraj /sprint-close /commander-audit /specify /plan-feature /tasks"

# CI workflow
if [ -f "$SOURCE/.github/workflows/project-guard.yml" ]; then
  mkdir -p "$TARGET/.github/workflows"
  cp "$SOURCE/.github/workflows/project-guard.yml" "$TARGET/.github/workflows/"
  echo "[OK] GitHub Actions workflow installed (server-side E-13)"
fi

# guard config
[ -f "$TARGET/.claude/project-guard.config.json" ] || \
  cp "$SOURCE/.claude/project-guard.config.example.json" "$TARGET/.claude/project-guard.config.json"

# settings.json (merge-safe)
if [ -f "$TARGET/.claude/settings.json" ]; then
  cp "$SOURCE/.claude/settings.json" "$TARGET/.claude/settings.commander.json"
  echo "[WARN] settings.json exists — saved as settings.commander.json, merge hooks manually"
else
  cp "$SOURCE/.claude/settings.json" "$TARGET/.claude/settings.json"
fi

# CLAUDE.md
[ -f "$TARGET/CLAUDE.md" ] || { cp "$SOURCE/PROJECT_CLAUDE_MD_TEMPLATE.md" "$TARGET/CLAUDE.md"; \
  echo "[OK] CLAUDE.md copied — edit [PROJECT NAME] and [project-repo]"; }

# version marker (single source: /VERSION)
[ -f "$TARGET/.commander-version" ] || echo "$CVER" > "$TARGET/.commander-version"

echo "=== Commander v$CVER installed (vendor-local, no network) ==="
echo "Requirement: Node.js in PATH (already true for Next.js/Vite projects)."
