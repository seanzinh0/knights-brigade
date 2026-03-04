---
name: war-plans
description: Use when starting any non-trivial engineering task that needs a written implementation plan before the knights brigade deploys. Use before touching code, before assembling agents, or when requirements need to be translated into an ordered task list with file paths, code, and test steps.
---

# War Plans

## Overview

Draft a comprehensive implementation plan that any engineer — or any agent — can execute without knowing the codebase. Document every file to touch, exact code, and test steps. Bite-sized tasks. DRY. YAGNI. TDD.

> **Plans contain ONLY code and file paths.** Never include `git commit`, `git add`, lint commands (`npm run lint`, `eslint`), build commands (`npm run build`, `nx build`), or any shell commands other than test runner commands.

**Announce at start:** "The War Scribe is drafting the campaign plan."

**Deploy the `war-scribe` agent** to do the actual research and drafting — do not write the plan inline. The war-scribe reads CLAUDE.md, memory files, and the codebase to discover conventions before writing a single task.

**Save plans to:** `docs/plans/YYYY-MM-DD-<feature-name>.md`

> `docs/plans/` is gitignored — plans are working documents, not committed artifacts.

---

## Bite-Sized Task Granularity

Each step is one atomic action (2–5 minutes):

- "Write the failing test" — step
- "Run it to confirm it fails" — step
- "Write minimal implementation to make it pass" — step
- "Run tests and confirm green" — step

Never combine implementation and test into one step. Break them apart.

> **Never add commit steps, lint steps, or build steps.** The user handles all of that manually.

---

## Plan Document Header

Every plan MUST start with this header:

```markdown
# [Feature Name] Campaign Plan

> **For the Brigade:** Read this plan fully before deploying. Hand to marshall to divide into sprint buckets.

**Objective:** [One sentence — what does this build or fix?]

**Architecture:** [2–3 sentences — what's the approach, what layers are touched?]

**Tech Stack:** [Key technologies: TypeScript, React, Knex, Objection, Jest, Nx, Easy Peasy, etc.]

**Affected Areas:** [e.g. admin-api, admin-ui, libs/conditions, lambda/encompass-webhook-processor]

---
```

---

## Task Structure

````markdown
### Task N: [Component Name]

**Files:**
- Create: `exact/path/to/file.ts`
- Modify: `exact/path/to/existing.ts:123–145`
- Test: `apps/admin-api/__tests__/handlers/Example.spec.ts`

**Step 1: Write the failing test**

```typescript
it('should do the specific thing', () => {
  const result = myFunction(input)
  expect(result).toEqual(expected)
})
```

**Step 2: Run test to confirm it fails**

```bash
node 'node_modules/jest/bin/jest.js' 'apps/admin-api/__tests__/handlers/Example.spec.ts' -t 'describe block name'
```
Expected: FAIL — "myFunction is not defined"

**Step 3: Write minimal implementation**

```typescript
export function myFunction(input: InputType): OutputType {
  return expected
}
```

**Step 4: Run test to confirm it passes**

```bash
node 'node_modules/jest/bin/jest.js' 'apps/admin-api/__tests__/handlers/Example.spec.ts' -t 'describe block name'
```
Expected: PASS
````

---

## Conventions Are Discovered, Not Assumed

The War Scribe discovers project conventions from the codebase — CLAUDE.md, AGENTS.md, memory files, package.json, and existing code patterns. Never hardcode project-specific conventions into this skill.

The plan will include a **Terrain Report** section with the discovered stack, test runner command, and import conventions.

---

## Execution Handoff

After saving the plan, present this choice:

```
War plan saved to docs/plans/<filename>.md

Three execution paths:

1. Knights Brigade (recommended) — assemble the full field corps, rangers ride
   recon, knights implement task-by-task, knight-commander reviews every output

2. Solo subagent per task — dispatch a fresh agent per task in this session,
   code review between each task, fast iteration for smaller campaigns

3. Manual — you implement it yourself using the plan as a checklist

Which path?
```

**If Knights Brigade chosen:**
- Invoke `knights-brigade` skill
- Pass the saved plan file path — marshall reads it directly, sovereign is skipped

**If Solo subagent chosen:**
- Dispatch one subagent per task in order
- After each: run a `knight-commander` code review before advancing
- Do not parallelize — tasks may have sequential dependencies

**If Manual chosen:**
- Present the plan clearly formatted
- Remind them: `docs/plans/` is gitignored, plan won't be committed

---

## Laws of the War Scribe

- **Exact file paths always** — never "the handler file", always `apps/admin-api/src/handlers/Conditions.handler.ts`
- **Complete code in the plan** — not "add validation here", write the actual code
- **Test commands only** — the only shell commands allowed in a plan are test runner commands; never include `git commit`, `git add`, lint commands, or build commands
- **TDD always** — test step before implementation step, every task
- **No YAGNI violations** — plan only what the objective requires, nothing extra
- **Research before writing** — read the codebase first, never guess at patterns
