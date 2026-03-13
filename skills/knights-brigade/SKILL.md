---
name: knights-brigade
description: Assembles and deploys the Knights Brigade — a field corps of specialist agents for the current task. Automatically selects the right command, rangers, and knights/specialists based on the theatre. Use when starting any non-trivial engineering task. Can be overridden by naming specific agents.
---

# Knights Brigade

```
        ╔══════════════════════════════╗
        ║                              ║
        ║    ⚔  KNIGHTS BRIGADE  ⚔     ║
        ║                              ║
        ║   Rangers ride first.        ║
        ║   Knights hold the line.     ║
        ║   The Sovereign commands.    ║
        ║                              ║
        ╚══════════════════════════════╝
```

Deploys a mission-ready field corps using the flat agent library in `~/.claude/agents/`. Rangers ride ahead for reconnaissance. Knights execute based on their intel. The command layer sets objectives and tracks the campaign.

---

## Field Roster

**The Court (Command Layer):**

- `sovereign` — decrees mission objectives, acceptance criteria, and UAT scrolls
- `marshall` — owns the campaign board, order of battle, sprint planning, and debriefs
- `knight-commander` — field authority: gates ranger intel briefs and knight code before the sovereign reviews

**Rangers** _(reconnaissance only — read-only, carry no weapons, never write code)_:

- `ranger-frontend` — front-end recon (components, patterns, state — adapts to project's UI stack)
- `ranger-backend` — back-end recon (routes, services, models, data flow — adapts to project's server stack)

**Knights & Specialists** _(deploy one or many — multiple can ride in parallel on independent objectives)_:

- `knight-frontend` — frontend implementation (adapts to project's UI framework and component conventions)
- `knight-backend` — backend/API implementation (adapts to project's server framework and patterns)
- `artificer-state` — client-side state management (adapts to project's state library)
- `artificer-data` — data layer implementation: queries, repositories, migrations (adapts to project's ORM/DB)
- `castle-architect` — DB schema design (pairs with artificer-data)
- `grand-architect` — cross-layer architecture decisions
- `siege-engineer` — distributed systems / event-driven design
- `quartermaster` — infrastructure as code, cloud resources, containerization
- `herald` — visual design + styling implementation (adapts to project's CSS/design system)
- `armorer` — test authoring (adapts to project's test framework)

---

## Theatre Compositions

**Frontend theatre** (UI, components, styling):
→ sovereign + marshall + ranger-frontend + knight-frontend + herald

**Backend theatre** (API, services, DB):
→ sovereign + marshall + ranger-backend + knight-backend + artificer-data

**Schema/data theatre** (new tables, migrations, query changes):
→ castle-architect + artificer-data (no ranger needed — castle-architect rides their own recon)

**State management theatre** (client-side state, stores):
→ ranger-frontend + artificer-state + knight-frontend

**Full-stack theatre**:
→ Full court + both rangers + knight-frontend + knight-backend + artificer-data + herald

**Architecture/design theatre**:
→ grand-architect (no ranger) or siege-engineer for distributed/event-driven concerns

**Infrastructure theatre** (cloud resources, IaC, containers):
→ quartermaster (no ranger — quartermaster rides their own recon)

**Testing theatre**:
→ armorer (deploy directly, no ranger needed)

> **Multi-knight deployment**: When a sprint task requires it, deploy multiple knights/specialists in parallel against independent objectives — e.g. knight-frontend + artificer-state + herald all riding simultaneously on different files. Never hold knights back if their objectives don't conflict.

---

## Fuel the Campaign with a Plan First

The brigade operates best when it has a written plan to execute against. The richer the plan, the tighter the order of battle.

**Supported upstream plan sources:**

| Source                                                   | When to Use                                                                                                                                                                  |
| -------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **`war-plans`**                                          | Complex multi-step features — produces a saved plan file in `docs/plans/` that the marshall consumes directly; skip sovereign, use "Starting from an existing plan" workflow |
| **Claude Plan Mode** (`EnterPlanMode` / `ExitPlanMode`)  | In-session planning — explore the codebase, design the approach, get approval, then invoke the brigade to execute                                                            |
| **Cursor plan** (`.cursor/` or `instructions/` markdown) | Plans written in Cursor or saved as markdown specs — read the file, extract tasks, feed to marshall as if it were a `writing-plans` output; skip sovereign                   |

**No plan in context? Ask first — don't assume.**

If the brigade is invoked with no plan in context (no plan file, no Claude plan mode output, no Cursor spec), ask the user before proceeding:

> "No existing plan detected. Would you like the War Scribe to draft a campaign plan first, or should the brigade deploy directly?"

- **If the user wants a plan:** Invoke `war-plans` → produce a saved plan in `docs/plans/` → once approved, proceed to Campaign Overview using the "Starting from an existing plan" workflow
- **If the user wants to deploy directly:** Skip the War Scribe. Proceed to the Campaign Overview and let the sovereign decree the mission spec at kickoff (default workflow).

A plan produces a tighter order of battle, but it's not always needed — quick fixes, small tasks, and targeted reviews can ride out immediately.

**New feature or component with no plan? Strongly recommend war-plans.**

If the task is creating something new (a new component, a new feature, a new endpoint) and no plan exists, the recommendation should lean toward war-plans — not just a neutral ask. Without a plan, the Campaign Overview will be hollow: the sovereign has no domain knowledge, the order of battle will be generic, and the knights will ride blind. A war-plans run first produces the codebase research, existing patterns, and task breakdown that makes the campaign meaningful.

> "This looks like a new feature with no existing plan. I'd recommend running war-plans first so the brigade has a concrete order of battle. Want me to invoke the War Scribe, or deploy directly?"

---

## Campaign Configuration

Before starting, ask the user:

> "How many sprints do you want? (default: 1)"

**Sprint count** determines how the campaign is divided:

- **1 sprint** — all objectives in one campaign, single court review at the end
- **N sprints** — marshall divides objectives into N sprint buckets, user reviews after each sprint before the next begins

If the user doesn't specify, default to 1 sprint.

**Campaign board (sprint.md)** is created by `marshall` at kickoff and saved to `docs/plans/sprints/YYYY-MM-DD-<feature-name>-sprint.md`. It is the order of battle — backlog, status tracker, and permanent audit trail. The marshall updates it:

- When a task moves to in-progress
- When a task completes or is blocked
- After each sprint debrief
- After sovereign/user feedback is incorporated

**UAT scrolls** are commissioned by `sovereign` after each sprint (if requested) and saved to `docs/plans/sprints/uat/YYYY-MM-DD-<feature-name>-uat-sprint-[N].md`.

---

## Campaign Workflow

### Starting from a task description (default)

1. **Classify** the theatre using the compositions above
2. **Present the Campaign Overview** — display this block to the user and **wait for approval before deploying a single agent**:

   ```
   ⚔ CAMPAIGN OVERVIEW
   ─────────────────────────────────
   Theatre:     [e.g. Back-end / Full-stack / Testing]
   Objective:   [1-sentence summary of what the campaign will accomplish]
   Sprints:     [N] (default: 1)

   Field Corps:
     Court      → sovereign, marshall, knight-commander
     Rangers    → [ranger-backend / ranger-frontend / none]
     Knights    → [list of knights/specialists]

   Order of Battle:
     Sprint 1: [task 1], [task 2], ...
     Sprint 2: [task 3], ... (if N > 1)
   ─────────────────────────────────
   Awaiting your command. Override agents or sprint count, or reply to ride out.
   ```

3. **Do not deploy any agent until the user approves** — accept overrides (different agents, different sprint count, scope changes) and revise the overview if needed
4. **Court setup:**
   a. `sovereign` → decrees mission spec with acceptance criteria
   b. `marshall` → produces order of battle, divides into N sprint buckets, creates campaign board
5. **For each sprint:**
   a. Announce: "Riding out — Sprint [N] of [total]: [sprint objective]"
   b. **For each task in the order of battle:**
   - `marshall` → mark task 🔄 in-progress in campaign board **before** deploying rangers
   - Ranger(s) → ride in parallel, return intel brief
   - `knight-commander` (intel review) → ✅ clear or ❌ send rangers back to the field
   - Knight(s)/Specialist(s) → deploy using approved intel brief; **ride multiple in parallel when objectives are independent**
   - `knight-commander` (code review) → ✅ advance or ❌ stand down — fix loop with the responsible agent (knight, armorer, herald, or any specialist); **every specialist gets this gate, no exceptions**
   - `marshall` → mark task ✅ done (or ⛔ blocked) in campaign board **after** code review clears
     c. `marshall` → sprint debrief + retrospective, updates campaign board audit trail
     d. **Ask the user: "Would you like a UAT scroll for this sprint?"** — wait for yes/no before proceeding
     e. _(If yes)_ `sovereign` → commissions UAT scroll, saved to `docs/plans/sprints/uat/`, presents to user — wait for user to inspect before advancing
     f. _(If yes)_ `sovereign` → triages filled-in scroll (breaches / refinements / new decrees → sprint placement)
     g. _(If yes)_ `marshall` → adds groomed items to next sprint order of battle, updates campaign board
     h. _(If no)_ Present sprint summary to user — wait for acknowledgment before advancing
6. After final sprint: `sovereign` → full acceptance criteria sign-off; **ask user if they want a final UAT scroll** before commissioning one
7. **REQUIRED SUB-SKILL:** Use superpowers:finishing-a-development-branch

### Starting from an existing plan (Option 3 from writing-plans)

When invoked after `writing-plans` with a saved plan file:

1. **Read the plan** — extract all tasks and context
2. **Ask sprint count** before deploying
3. **Skip sovereign** — the decree is already in the plan
4. **Deploy marshall** to divide plan tasks into N sprint buckets, create campaign board
5. **For each sprint:**
   a. Announce: "Riding out — Sprint [N] of [total]"
   b. **For each task in the order of battle:**
   - `marshall` → mark task 🔄 in-progress **before** deploying rangers
   - Ranger(s) → ride in parallel, return intel brief
   - `knight-commander` (intel review) → ✅ clear or ❌ send rangers back to the field
   - Knight(s)/Specialist(s) → deploy using plan task text + approved intel brief; **ride multiple in parallel when objectives are independent**
   - `knight-commander` (code review) → ✅ advance or ❌ stand down — fix loop with the responsible agent (knight, armorer, herald, or any specialist); **every specialist gets this gate, no exceptions**
   - `marshall` → mark task ✅ done (or ⛔ blocked) **after** code review clears
     c. `marshall` → sprint debrief + retrospective, updates campaign board audit trail
     d. **Ask the user: "Would you like a UAT scroll for this sprint?"** — wait for yes/no
     e. _(If yes)_ `sovereign` → commissions UAT scroll, presents to user — wait for inspection before advancing
     f. _(If yes)_ `sovereign` → triages filled-in scroll, groomed items handed to marshall
     g. _(If yes)_ `marshall` → adds groomed items to next sprint order of battle, updates campaign board
     h. _(If no)_ Present sprint summary to user — wait for acknowledgment before advancing
6. `marshall` → final victory review against all plan tasks
7. **REQUIRED SUB-SKILL:** Use superpowers:finishing-a-development-branch

---

## Override Support

If the user names specific agents, skip auto-selection and deploy those agents directly (still run the court unless user says not to).

---

## Laws of the Campaign

- **No plan? Ask, don't assume** — if no plan is in context, ask the user: "Would you like the War Scribe to draft a plan, or should the brigade deploy directly?" Respect their answer — a plan is recommended for complex campaigns but not mandatory
- **Cursor plans and `instructions/` markdown are first-class** — treat them the same as `writing-plans` output; read the file, extract tasks, hand to marshall, skip sovereign
- **Always present the Campaign Overview and wait for approval** — no agent deploys before the user sees the theatre, field corps, and order of battle and gives the command to ride out
- **Rangers never ride without knights** to act on their intel — recon without follow-through is waste
- **Always deploy sovereign first** for feature work (skip for pure refactors/fixes)
- **Knights do not re-read files** the ranger already covered — pass the intel brief as input
- **Rangers always ride in parallel** — they are read-only and never conflict, dispatch all at once in a single message
- **Knights ride in parallel when objectives are independent** — parallel allowed when tasks touch different files with no shared state; forbidden when tasks write to the same file or one depends on the other's output; **scale the force to match the campaign**
- **knight-commander gates every specialist, not just knights** — armorer, herald, artificer-state, artificer-data, castle-architect, siege-engineer, quartermaster — every agent that produces output gets a knight-commander review before the marshall marks the task done
- **knight-commander rides in parallel with the next ranger where possible** — while one specialist's code review runs, the next task's rangers can already be in the field
- **Always hold at the gate between sprints** — never auto-advance without user acknowledgment
- **Always ask before commissioning a UAT scroll** — never auto-generate one; ask "Would you like a UAT scroll for this sprint?" and wait
- **UAT findings are binding decrees** — if the user opts in and fills in the scroll, every item must be triaged and groomed into the backlog, never ignored
- **Carry-overs are declared openly** — if a task doesn't complete in a sprint, marshall calls it out and it moves to the next order of battle, it never silently disappears
- **Never call the armorer or test skills unbidden** — do not invoke `armorer`, `superpowers:test-driven-development`, `superpowers:verification-before-completion`, or any test/verify skill unless: (a) the user explicitly requests it, or (b) existing test files were directly touched or new tests are required by the task
- **Never silently substitute unknown artifacts** — if the user references a handler, component, file, or entity by name that cannot be found in the codebase, stop and ask: "I couldn't find [name] — did you mean [closest match], or should I proceed with the name as given?" Do not infer a substitute and proceed as if it were the intended target
- **Knights and specialists NEVER compile or run tests** — no build, typecheck, lint, or test commands of any kind. Knights write code only. The ONLY agent permitted to run tests is the `armorer`, and only when explicitly requested by the user. Compilation and verification are manual steps performed by the user, not the brigade.
