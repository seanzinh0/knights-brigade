#!/usr/bin/env bash
set -e

AGENTS_DIR="$HOME/.claude/agents"
SKILLS_DIR="$HOME/.claude/skills"
HOOKS_DIR="$HOME/.claude/hooks"

echo "⚔  Installing Knights Brigade..."

mkdir -p "$AGENTS_DIR"
mkdir -p "$SKILLS_DIR/knights-brigade"
mkdir -p "$SKILLS_DIR/war-plans"
mkdir -p "$HOOKS_DIR"

cp agents/*.md "$AGENTS_DIR/"
echo "✓  Agents installed to $AGENTS_DIR"

cp skills/knights-brigade/SKILL.md "$SKILLS_DIR/knights-brigade/SKILL.md"
cp skills/war-plans/SKILL.md "$SKILLS_DIR/war-plans/SKILL.md"
echo "✓  Skills installed to $SKILLS_DIR"

cp hooks/patch-superpowers.sh "$HOOKS_DIR/patch-superpowers.sh"
chmod +x "$HOOKS_DIR/patch-superpowers.sh"
echo "✓  Hook installed to $HOOKS_DIR"

echo ""
echo "Knights Brigade is ready. Start with /knights-brigade or /war-plans in Claude Code."
echo ""
echo "For Superpowers integration, add the SessionStart hook to your settings."
echo "See README.md for details."
