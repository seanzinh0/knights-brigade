#!/usr/bin/env bash
set -e

AGENTS_DIR="$HOME/.claude/agents"
SKILLS_DIR="$HOME/.claude/skills"

echo "⚔  Installing Knights Brigade..."

mkdir -p "$AGENTS_DIR"
mkdir -p "$SKILLS_DIR/knights-brigade"
mkdir -p "$SKILLS_DIR/war-plans"

cp agents/*.md "$AGENTS_DIR/"
echo "✓  Agents installed to $AGENTS_DIR"

cp skills/knights-brigade/SKILL.md "$SKILLS_DIR/knights-brigade/SKILL.md"
cp skills/war-plans/SKILL.md "$SKILLS_DIR/war-plans/SKILL.md"
echo "✓  Skills installed to $SKILLS_DIR"

echo ""
echo "Knights Brigade is ready. Start with /knights-brigade or /war-plans in Claude Code."
