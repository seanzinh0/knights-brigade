#!/usr/bin/env bash
set -e

AGENTS_DIR="$HOME/.claude/agents"
SKILLS_DIR="$HOME/.claude/skills/knights-brigade"

echo "⚔  Installing Knights Brigade..."

mkdir -p "$AGENTS_DIR"
mkdir -p "$SKILLS_DIR"

cp agents/*.md "$AGENTS_DIR/"
echo "✓  Agents installed to $AGENTS_DIR"

cp skills/knights-brigade/SKILL.md "$SKILLS_DIR/SKILL.md"
echo "✓  Skill installed to $SKILLS_DIR"

echo ""
echo "Knights Brigade is ready. Start with /knights-brigade in Claude Code."
