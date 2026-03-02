# Knights Brigade

```
        ╔══════════════════════════════╗
        ║                              ║
        ║    ⚔  KNIGHTS BRIGADE  ⚔    ║
        ║                              ║
        ║   Rangers ride first.        ║
        ║   Knights hold the line.     ║
        ║   The Sovereign commands.    ║
        ║                              ║
        ╚══════════════════════════════╝
```

A field corps of specialist Claude Code agents that work together to ship features. Rangers recon the codebase, Knights implement, and a command layer keeps everything on target.

Drop this into any project. Works with any stack — the agents adapt to what they find.

---

## Install

```bash
git clone https://github.com/yourusername/knights-brigade.git
cd knights-brigade
./install.sh
```

That's it. The script copies all agents to `~/.claude/agents/` and the skills to `~/.claude/skills/`.

### Manual install

```bash
# Copy agents
cp agents/*.md ~/.claude/agents/

# Copy skills
mkdir -p ~/.claude/skills/knights-brigade
cp skills/knights-brigade/SKILL.md ~/.claude/skills/knights-brigade/SKILL.md
mkdir -p ~/.claude/skills/war-plans
cp skills/war-plans/SKILL.md ~/.claude/skills/war-plans/SKILL.md
```

---

## Usage

Start any non-trivial engineering task by invoking the skill:

```
/knights-brigade
```

Or draft a campaign plan first, then deploy:

```
/war-plans
```

Claude will automatically select the right agents for your task.

Claude will:
1. Classify your task into the right **theatre** (frontend, backend, full-stack, etc.)
2. Propose the field corps and sprint count
3. Wait for your approval before deploying
4. Run the campaign with sprint reviews and optional UAT scrolls

---

## The Field Roster

### Command Layer
| Agent | Role |
|-------|------|
| `sovereign` | Translates vague requests into precise mission specs with acceptance criteria |
| `marshall` | Owns the campaign board, sprint planning, and debriefs |
| `knight-commander` | Gates ranger intel briefs and knight code before sovereign review |

### Planning
| Agent | Role |
|-------|------|
| `war-scribe` | Researches the codebase and drafts implementation plans before the brigade deploys |

### Rangers *(read-only recon — never write code)*
| Agent | Role |
|-------|------|
| `ranger-frontend` | Maps components, patterns, state, and UI terrain |
| `ranger-backend` | Maps routes, services, models, and data flow |

### Knights & Specialists
| Agent | Role |
|-------|------|
| `knight-frontend` | Frontend implementation (adapts to project's UI framework) |
| `knight-backend` | Backend/API implementation (adapts to project's server framework) |
| `artificer-state` | Client-side state management (adapts to project's state library) |
| `artificer-data` | Data layer: queries, migrations (adapts to project's ORM/DB) |
| `castle-architect` | DB schema design |
| `grand-architect` | Cross-layer architecture decisions |
| `siege-engineer` | Distributed systems / event-driven design |
| `quartermaster` | Infrastructure as code, cloud resources, containerization |
| `herald` | Visual design + styling implementation (adapts to project's CSS/design system) |
| `armorer` | Test authoring (adapts to project's test framework) |

---

## Theatre Compositions

Pre-built corps for common task types:

| Theatre | Agents |
|---------|--------|
| **Frontend** | sovereign + marshall + ranger-frontend + knight-frontend + herald |
| **Back-end** | sovereign + marshall + ranger-backend + knight-backend + artificer-data |
| **Full-stack** | Full court + both rangers + knight-frontend + knight-backend + artificer-data + herald |
| **Schema/data** | castle-architect + artificer-data |
| **State management** | ranger-frontend + artificer-state + knight-frontend |
| **Architecture** | grand-architect or siege-engineer |
| **Infrastructure** | quartermaster |
| **Testing** | armorer |

---

## How It Works

Each campaign follows this pattern:

```
sovereign → mission spec
marshall  → campaign board + order of battle
  ↓
for each task:
  rangers   → intel brief (parallel, read-only)
  knight-commander → gate intel brief
  knights   → implement (parallel when independent)
  knight-commander → gate code
  marshall  → mark done
  ↓
sprint debrief → optional UAT scroll → next sprint
```

Rangers always ride before knights. Knights ride in parallel when their objectives don't conflict. The sovereign and marshall never touch code.

---

## Requirements

- [Claude Code](https://claude.ai/code) CLI
- Agents directory: `~/.claude/agents/`
- Skills directory: `~/.claude/skills/`

---

## File Structure

```
knights-brigade/
├── README.md
├── install.sh
├── agents/
│   ├── sovereign.md
│   ├── marshall.md
│   ├── knight-commander.md
│   ├── ranger-frontend.md
│   ├── ranger-backend.md
│   ├── knight-frontend.md
│   ├── knight-backend.md
│   ├── artificer-state.md
│   ├── artificer-data.md
│   ├── castle-architect.md
│   ├── grand-architect.md
│   ├── siege-engineer.md
│   ├── quartermaster.md
│   ├── herald.md
│   ├── armorer.md
│   └── war-scribe.md
└── skills/
    ├── knights-brigade/
    │   └── SKILL.md
    └── war-plans/
        └── SKILL.md
```
