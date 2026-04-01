---
name: product-forge
description: "End-to-end product builder: takes a product idea and delivers a working MVP with research, business validation, and tested code. MUST USE whenever the user describes a product concept and expects you to build it — even casually like 'can you build an app that does X' or 'I have an idea for Y, make it real'. Triggers on: product ideas, app concepts, 'build this', 'idea to MVP', 'make this into a product', 'full product please', 'product forge', napkin sketches of apps, or any request where the user gives you a concept and expects a working, deployable result. This skill coordinates research (Edison), business validation (Minimalist Entrepreneur), API contract generation, parallel build agents, browser verification, and UI polish into a tested MVP. Do NOT skip this skill just because you think you can build the app directly — the orchestration prevents integration bugs and ensures nothing gets forgotten."
---

# Product Forge

Orchestrate idea → research → validate → build → test → ship.

Product Forge is the conductor — it calls Edison, Minimalist Entrepreneur, build skills, and
verification in the right order, bridges their outputs, and makes sure nothing gets forgotten.

---

## Phase 0: Preflight

Before anything else, check the environment.

### Skill Dependency Check

Run this check at the start of every Product Forge invocation. For each skill, test whether
it's available by checking for the skill name in the system's skill list.

**Required (will not proceed without):**

| Skill | Purpose | Install |
|-------|---------|---------|
| Edison (`/edison`) | Design exploration | `git clone https://github.com/kilnside/edison ~/.claude/skills/edison && cp -r ~/.claude/skills/edison/edison-evolve ~/.claude/skills/` |

If Edison is missing, stop and tell the user: "Product Forge requires Edison for design
exploration. Install it with the command above, then re-run."

**Recommended (will degrade gracefully without):**

| Skill | Purpose | Fallback | Install |
|-------|---------|----------|---------|
| ME validate-idea | Problem validation | Skip business validation, flag to user | `minimalist-entrepreneur` plugin |
| ME pricing | Price point | Skip pricing, flag to user | Same plugin |
| ME mvp | Scope definition | Skip scope cuts, flag to user | Same plugin |
| frontend-design | Distinctive UI | shadcn defaults + Tailwind | `frontend-design` plugin |
| code-simplifier (`/simplify`) | Clean up code | Skip, code works but less clean | `superpowers` plugin |
| e2e | Playwright E2E tests | curl-based API tests only | `e2e` plugin |
| Edison Evolve (`/edison evolve`) | Process learning | Skip reflection | Included with Edison install above |
| humanizer | Polish report prose | Skip, reports are functional | Local skill |

**After checking, report to user:**

```
Product Forge Preflight:
  Required:  Edison ✓
  Installed: [list of found recommended skills]
  Missing:   [list of missing recommended skills with fallback notes]
  
  [If missing skills]: Install missing skills for best results, or proceed with fallbacks.
  Proceeding in [full / degraded] mode.
```

If any recommended skills are missing, briefly explain what will be different and ask:
"Want me to install any of these before we start, or proceed with fallbacks?"

### Resume Check

Check for `.forge/state.json` in the project root. If it exists, a previous run was
interrupted. Read the state file and offer to resume:

```
Found interrupted Product Forge session:
  Product: [name]
  Started: [timestamp]
  Last completed: Phase [N], [description]
  Next step: Phase [N+1], [description]
  
  Resume from where we left off, or start fresh?
```

If the user says resume, skip to the next incomplete phase. All prior artifacts
(spec, API contract, build plan) are already on disk.

If the user says start fresh, delete `.forge/state.json` and proceed normally.

---

## State Management

Product Forge tracks progress in `.forge/state.json`. Update this file after every
phase and wave completion. This is the resumption mechanism.

```json
{
  "product": "Product Name",
  "started": "2026-04-01T12:00:00Z",
  "mode": "interactive | autonomous",
  "current_phase": 3,
  "current_wave": null,
  "phases": {
    "1_explore": { "status": "complete", "completed_at": "...", "spec_path": ".edison/explorations/.../synthesis/DEFINITIVE-SPEC.md" },
    "2_validate": { "status": "complete", "completed_at": "...", "validation_path": ".forge/validation.md" },
    "3_bridge": { "status": "in_progress", "completed_at": null, "api_contract_path": ".forge/api-contract.md", "build_plan_path": null },
    "4_build": { "status": "pending", "waves": { "1": "pending", "2": "pending", "3": "pending" } },
    "5_verify": { "status": "pending" },
    "6_ship": { "status": "pending" },
    "7_reflect": { "status": "pending" }
  },
  "decisions": [],
  "missing_skills": []
}
```

**Write state after:** every phase completion, every wave completion, every checkpoint.
**Read state on:** session start (for resume), phase transitions (for context).

All Product Forge artifacts go in `.forge/` to keep them separate from Edison's `.edison/`.

---

## The Pipeline

```
IDEA (1 paragraph from user)
  │
  ├─ Phase 0: PREFLIGHT ────────────────── Skill check + resume check
  │
  ├─ Phase 1: EXPLORE ──────────────────── Edison
  │    MEANWHILE: suggest customer discovery questions to user
  │
  ├─ ★ CHECKPOINT 1 ─────────────────────── "Does this spec capture what you want?"
  │
  ├─ Phase 2: VALIDATE ──────────────────── Minimalist Entrepreneur
  │    Feed scope cuts back into spec
  │
  ├─ ★ CHECKPOINT 2 ─────────────────────── "Right pricing? Right MVP scope?"
  │
  ├─ Phase 3: BRIDGE ────────────────────── Product Forge (unique)
  │    API contract + build plan + seed data
  │
  ├─ Phase 4: BUILD ─────────────────────── Parallel agents in waves
  │    Wave 1 → verify → Wave 2 → verify → Wave 3 → verify
  │
  ├─ Phase 5: VERIFY ────────────────────── E2E test + build check
  │
  ├─ ★ CHECKPOINT 3 ─────────────────────── "Click through it. Does this feel right?"
  │
  ├─ Phase 6: SHIP ──────────────────────── Git commits + README
  │
  └─ Phase 7: REFLECT ───────────────────── Summary + Edison Evolve
```

---

## Phase 1: Explore

Invoke Edison (`/edison`). The full Edison process runs as documented.

**While research agents run (~10 min of dead time for the human):**

Generate 5 customer discovery questions derived from the vision and suggest the user text
them to people in the target domain. Even 2-3 replies beat all AI research combined.

When Edison completes, update `.forge/state.json` and present CHECKPOINT 1.

### Checkpoint 1

"Does this spec capture what you want? Any priorities to add, remove, or reorder?"

If the user approves, proceed. If they have changes, apply them to the spec before moving on.

---

## Phase 2: Validate

Run ME skills as a **single coherent analysis** — each skill's output feeds the next,
and scope cuts flow back to the spec. Write output to `.forge/validation.md`.

Structure (see `references/validation-template.md` for full template):
1. Problem Validation (from validate-idea) — who, what, pain level, verdict
2. Pricing (from pricing) — model, price, rationale
3. MVP Scope (from mvp) — the ONE thing, what's cut, what stays
4. Spec Reconciliation — update DEFINITIVE-SPEC.md with cuts and pricing

**If ME skills are not installed:** Skip this phase. Flag to user: "No business validation
available. Proceeding to build — validate the business case manually." Still write a
minimal `.forge/validation.md` noting it was skipped.

Update state. Present CHECKPOINT 2.

---

## Phase 3: Bridge

Transform the design spec into buildable instructions. This phase is unique to Product
Forge — no other skill generates these artifacts.

See `references/bridge-phase.md` for detailed templates and examples.

**Step 1: API Contract** → `.forge/api-contract.md`

Read the DEFINITIVE-SPEC.md. For every endpoint mentioned or implied, produce a table of
Method, Path, Request Body, Response, and Notes. Include shared TypeScript types.

This table is mandatory input to every build agent. No agent may invent its own endpoints.

**Step 2: Build Plan** → `.forge/build-plan.md`

Assign components to waves based on dependencies:
- **Wave 1:** No dependencies (schema, types, backend service)
- **Wave 2:** Depends on Wave 1 (frontend pages, API routes)
- **Wave 3:** Depends on running system (polish, E2E tests)

**Step 3: Seed Data** → `.forge/seed-data.md`

Generate a narrative seed data set that tells the product's story. Not random data —
a compelling demo showing problem → exploration → discovery → solution.

Update state after each step completes (so resume can pick up mid-Bridge).

---

## Phase 4: Build

Dispatch build agents in waves. Every agent receives:
1. The DEFINITIVE-SPEC.md
2. The API Contract (`.forge/api-contract.md`)
3. The shared types file
4. Their specific wave assignment

**Between waves:**

| After Wave | Verify | Then |
|------------|--------|------|
| Wave 1 | Start dev servers, test backend with curl | Fix failures before Wave 2. Commit. Update state. |
| Wave 2 | `next build` (or equivalent). Run `e2e` skill if available, else curl tests. | Fix failures before Wave 3. Commit. Update state. |
| Wave 3 | Full E2E integration test. | Fix failures. Commit. Update state. |

**Skills invoked during build:**
- `frontend-design` — landing page and primary dashboard (Wave 3)
- `code-simplifier` (`/simplify`) — after all waves, before final commit (Wave 3)
- `e2e` — generate and run Playwright tests (Wave 2 and Wave 3)

**Idle time utilization:**

| Agents Running | Main Thread Does |
|---------------|-----------------|
| Wave 1 | Write integration test skeleton |
| Wave 2 | Generate seed data, write README |
| Wave 3 | Prepare git commits, write setup instructions |

---

## Phase 5: Verify

1. Start all servers
2. Run integration test script
3. Run `e2e` skill on the critical user journey (if available)
4. Verify build passes (`next build` or equivalent)
5. Fix any issues and re-verify

Do not proceed to CHECKPOINT 3 until the E2E flow works. Update state.

### Checkpoint 3

"The app is running. Click through it — does this feel right? Anything to change?"

---

## Phase 6: Ship

Commit with atomic, meaningful commits:
1. Project scaffold + types
2. Backend service + schema
3. Frontend pages + API routes
4. Bug fixes + integration
5. UI polish + seed data
6. Documentation

Write a README with copy-pasteable setup instructions. Update state.

---

## Phase 7: Reflect

Two tiers: **Quick Summary** (default) and **Detailed Reports** (on request or with `--detailed`).

### Quick Summary (always runs)

Write `.forge/SESSION-SUMMARY.md`:

```markdown
# [Product Name] — Build Summary

## What Was Built
[2-3 sentences describing the product]

## Key Design Decisions
[Numbered list of the 5-10 most important decisions and why]

## Domain Learnings
[The 3-5 most surprising or valuable things discovered during research]

## What Would Improve It
[Top 3 next steps if continuing development]

## Autonomous Decisions (if applicable)
[Decisions made without human input — review if they matter to you]

## Session Stats
- Phases completed: [N/7]
- Agents dispatched: [N]
- Skills used: [list]
- Estimated duration: [time]
```

### Detailed Reports (with `--detailed` flag or user request)

In addition to the summary, generate three extended reports. These go deep for users who
want full visibility into what happened. Write to `.forge/reports/`:

1. **LEARNINGS.md** — comprehensive domain knowledge report. Everything learned about the
   domain, market, competitors, technical approaches, UX decisions, and pricing. Structured
   to let someone who wasn't in the session understand the full landscape in 15 minutes.

2. **META-ANALYSIS.md** — honest process assessment. What skills worked, what didn't connect
   well, where autonomous operation hurt quality, what the ideal human/AI split is.

3. **IMPROVEMENTS.md** — specific actionable recommendations for the next run. Big/medium/small
   wins, what to keep, proposed process improvements, session statistics with token estimates.

See `references/detailed-reports.md` for full templates.

### Edison Evolve (if Edison was used in Phase 1)

Run Edison Evolve's end-of-run capture:
- Scan for personal preferences (priority reordering, depth choices)
- Scan for universal discoveries (spec ambiguities, research effectiveness, round patterns)
- Update `.edison/profile.md` with lessons
- Write `.edison/evolution-log.md` with discoveries
- **Ensure GitHub issue submission completes** — if `gh` is available and authenticated,
  submit universal discoveries to the Edison repo. Don't leave them as "pending submission."

### Save State

Update `.forge/state.json` with final status. Mark all phases complete.
The state file persists so future sessions can reference what was built.

---

## Autonomous Mode

When the user says "run autonomously", "don't ask me anything", or "I'll be away":

- **Checkpoints become internal reviews.** Pause and critically re-read your output.
  If uncertain on a major decision (pricing, primary feature, tech stack), make the
  conservative choice and log it in `state.json` decisions array.
- **Never skip the Bridge phase.** The API contract is MORE important without a human
  to catch integration bugs.
- **Still run verification.** E2E tests replace the human gut-check.
- **Log all autonomous decisions.** The Quick Summary lists every significant decision
  for post-session review.

---

## Skill Invocation Map

| Phase | Skill | Required? | Fallback |
|-------|-------|-----------|----------|
| 1 | Edison (`/edison`) | **Yes** | Cannot proceed without |
| 2 | ME validate-idea, pricing, mvp | Recommended | Skip validation, flag to user |
| 3 | (Product Forge native) | — | — |
| 4 | frontend-design | Recommended | shadcn defaults |
| 4 | code-simplifier (`/simplify`) | Recommended | Skip, code still works |
| 5 | e2e | Recommended | curl-based API tests only |
| 7 | Edison Evolve | Recommended | Skip reflection |
| 7 | humanizer | Optional | Reports are functional without |

---

## Anti-Patterns

| Pattern | Why It's Wrong | Do Instead |
|---------|---------------|------------|
| Skipping the API contract | Integration bugs between parallel agents | Always generate in Phase 3 |
| Building everything then testing | Late discovery of fundamental issues | Test after each wave |
| Running ME skills independently | Context lost between skills | Run as one coherent analysis |
| Waiting idle while agents run | Wasted human and token time | Do non-overlapping work |
| One massive commit | No rollback safety | Atomic commits per wave |
| Using shadcn defaults for key pages | Generic-looking product | Run frontend-design on landing + dashboard |
| Skipping seed data | Demo shows empty/random state | Generate narrative data |
| Not saving state between waves | Session crash = start over | Update `.forge/state.json` after every wave |
