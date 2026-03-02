#!/usr/bin/env bash
# Patches the superpowers plugin to register knights-brigade as priority 3 in skill ordering.
# Runs at session start via Claude Code hooks — idempotent, safe to re-run on every plugin update.

PLUGIN_BASE="$HOME/.claude/plugins/cache/claude-plugins-official/superpowers"
SKILL_SUBPATH="skills/using-superpowers/SKILL.md"
PATCH_MARKER="knights-brigade"

# Find the latest installed superpowers version
LATEST_VERSION=$(ls -1 "$PLUGIN_BASE" 2>/dev/null | sort -V | tail -n 1)

if [ -z "$LATEST_VERSION" ]; then
  exit 0
fi

SKILL_FILE="$PLUGIN_BASE/$LATEST_VERSION/$SKILL_SUBPATH"

if [ ! -f "$SKILL_FILE" ]; then
  exit 0
fi

# Already patched — nothing to do
if grep -q "$PATCH_MARKER" "$SKILL_FILE"; then
  exit 0
fi

# Apply the patch — insert knights-brigade as priority 3 after the existing 2-item list
python3 - "$SKILL_FILE" <<'PYEOF'
import sys

path = sys.argv[1]
with open(path, 'r') as f:
    content = f.read()

OLD = (
    '1. **Process skills first** (brainstorming, debugging) - these determine HOW to approach the task\n'
    '2. **Implementation skills second** (frontend-design, mcp-builder) - these guide execution\n'
    '\n'
    '"Let\'s build X" → brainstorming first, then implementation skills.\n'
    '"Fix this bug" → debugging first, then domain-specific skills.'
)

NEW = (
    '1. **Process skills first** (brainstorming, debugging) - these determine HOW to approach the task\n'
    '2. **Implementation skills second** (frontend-design, mcp-builder) - these guide execution\n'
    '3. **Team assembly third** (knights-brigade) - when a non-trivial task benefits from specialist collaboration; deploy after brainstorming to assemble the right field corps\n'
    '\n'
    '"Let\'s build X" → brainstorming first, then knights-brigade to deploy the field corps.\n'
    '"Fix this bug" → debugging first, then domain-specific skills.\n'
    '"Add a feature" → brainstorming → knights-brigade → specialists ride out.'
)

if OLD in content:
    content = content.replace(OLD, NEW)
    with open(path, 'w') as f:
        f.write(content)
PYEOF
