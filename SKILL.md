---
name: edison
description: >
  Three modes for getting design decisions right. (1) Check — quick 5-question gate before coding.
  (2) Explore — research-first, multi-round deep dive that progressively deepens from literal to
  creative to wild. (3) Audit — compare an existing spec against the codebase to find gaps.
  Triggers on: /iterate, /edison, /deep-dive, /audit, "explore all the options", "are we missing
  anything?", "what happened to the spec?", or any situation where design decisions need validation
  before code. Also self-triggers before implementing interconnected, unexplored, or brand-sensitive
  features. Do NOT use for simple bug fixes, typos, or config changes.
---

# Edison

Three modes for getting design decisions right before writing code.

Named after Edison who tried 1000 materials before finding the right filament. The lesson:
systematic exploration before commitment produces results that "just build it" never could.

Edison exists because of three insights:

1. **AI's unique value is research, not interrogation.** Scan the landscape. Bring back
   intelligence the user didn't have. Questions are a last resort.
2. **Great specs that nobody follows are worse than no specs.** Every mode includes a
   binding mechanism that makes the spec impossible to ignore during implementation.
3. **Exploration saves tokens long-term.** Building the right thing once costs less than
   building the wrong thing and rebuilding. Spare no expense.

---

## Routing: Which Mode Do I Need?

```
User request or self-trigger
│
├── "Does the code match the spec?" / /audit
│   └── Audit
│
├── Is there a design decision being made?
│   ├── No → Just build
│   └── Yes → Does a spec already exist?
│       ├── Yes → Does the code match it?
│       │   ├── Yes → Build from the spec
│       │   └── No → Audit (then fix)
│       └── No → How complex is the decision?
│           ├── Simple (1-2 choices) → Brainstorm skill
│           └── Complex (3+ interconnected) → The Check
│               ├── Score 0-1 → Build
│               └── Score 2+ → Explore
```

### Trigger Phrases

| Phrase | Route |
|--------|-------|
| `/edison`, `/iterate`, `/deep-dive` | Start at the Check, escalate if needed |
| `/audit`, "what happened to the spec?", "does this match?" | Audit |
| "explore all the options", "spare no expense", "I want to get this right" | Explore directly |
| "are we missing anything?" | The Check |

### Self-Trigger (Before Writing Code)

Pause and run the Check if you're about to:
- Implement something that contradicts or isn't covered by an existing spec
- Make UX decisions inline while coding
- Build a feature that's interconnected (3+ features), precedent-setting, or opinionated

Do NOT self-trigger for:
- Adding a component that follows an established pattern
- CRUD operations on an existing data model
- Bug fixes, config changes, dependency updates, test files
- Work the user explicitly said "just build"

**Should trigger:** Adding a new payment flow, designing the first notification system,
choosing between competing architecture patterns.
**Should not trigger:** Adding a REST endpoint following existing patterns, updating form
validation rules, fixing a CSS alignment bug.

---

## The Check (10 seconds)

Five questions. Unweighted. Threshold: 2 of 5.

### The 5 Questions

#### 1. Interconnected? (Does this touch 3+ other features?)
**Signal:** You're thinking "oh, and this could also be used for..."

#### 2. Precedent-setting? (Will future code copy this pattern?)
**Signal:** You're about to create a new directory, hook pattern, or data access convention.

#### 3. Opinionated? (Will someone with authority have a strong reaction?)
**Signal:** User-facing text, animation timing, API contract shape, architecture choice
the team lead cares about.

#### 4. Irreversible? (Is this expensive to change after shipping?)
**Signal:** Database schema, public API, navigation structure, data model.

#### 5. Multi-stakeholder? (Does this affect different user types or teams differently?)
**Signal:** Admin vs. end-user, mobile vs. desktop, frontend vs. backend team.

### Scoring

Score 0-1: Build. Flag assumptions.
Score 2+: Recommend Explore. Present the case. User decides.

**Hard trigger:** If both Interconnected AND Irreversible are true, always recommend
Explore regardless of total score.

### Pre-Check

Before scoring, do a quick contradiction sniff:
- Glob for specs in `docs/design/`, CLAUDE.md "Active Design Specs" section
- If the task conflicts with an active spec, flag immediately and route to Audit

### What to Say When the Check Says Stop

> "Before I build [feature], this [scores on questions X, Y]. I think exploration would
> save us from building the wrong thing. This will be thorough — expect [estimate].
> Want me to explore, or should I go ahead?"

**Be honest about when Edison is NOT the right tool.** If the Check scores 0-1, say so
clearly: "This doesn't need Edison — it's a straightforward implementation. Just build
it." Don't upsell exploration when a simple build would serve better. Edison's value is
precision, not frequency. Every unnecessary run erodes trust and wastes the user's budget.

The check is advisory. If the user says "just build it," build it.

---

## Phase 0: Project Scan (First-Run Only)

On first invocation in a project, Edison scans the codebase to understand context before
doing anything else. This runs once and caches the result.

**Detection:** Check if `.edison/profile.md` exists. If yes, read it and proceed. If no,
this is a first run.

**UX:** Scan runs in parallel with the user's input. Never block.

> "First time running Edison in this project. Scanning your codebase while we get started —
> what's the design decision?"

The user describes their problem while Edison reads in the background. No confirmation
gate. Findings are woven into the first substantive response, not presented as a
separate step. If Edison gets something wrong, the user corrects naturally ("actually
we migrated away from that").

### What to Scan

**Tier 1 — Always read (~1500 tokens, <5 seconds):**

| Order | File | Why |
|-------|------|-----|
| 1 | User's current request | Determines which parts of the project matter |
| 2 | CLAUDE.md | Agent-facing source of truth: conventions, specs, architecture |
| 3 | Package manifest (package.json / pyproject.toml / Cargo.toml) | Stack, deps, project name. Top ~50 lines. |
| 4 | Directory tree (2 levels) | Architecture shape, where code lives |
| 5 | README.md (first 80 lines) | Purpose, setup, high-level architecture |

**Tier 2 — Only if Explore triggers (~800 additional tokens):**

| Order | File | Why |
|-------|------|-----|
| 6 | Existing specs (glob docs/design/, deep-exploration/) | Prevents re-exploring solved problems |
| 7 | Git log (last 15 commits, oneline) | Recent velocity, active areas |
| 8 | Entry point (src/app/layout.tsx, main.py, etc.) | How pieces connect |

**Skip:** lockfiles, node_modules, test files, .env, CI config, binary files. Never
read more than 80 lines of any single file during scan.

### Project Profile

The scan produces `.edison/profile.md` (~500 tokens):

```markdown
# Edison Project Profile
Generated: [date] | Updated: [date]

## Identity
- **Name:** [from manifest]
- **Domain:** [2-3 words: "ceramics social app", "B2B SaaS dashboard"]
- **Stack:** [framework, language, DB, deployment]
- **Maturity:** [greenfield | early | established | legacy]

## Architecture
- **Pattern:** [monolith | monorepo | microservices]
- **Key directories:** [top 5]
- **Data layer:** [ORM/DB, schema location]

## Active Specs
- [spec name]: [path] (coverage: [%] if audited)

## Established Patterns
- [pattern]: [one-line + example file]

## Edison History
- Last run: [date] | Mode: [check/explore/audit] | Result: [summary]
```

This profile replaces raw file contents in all downstream agent prompts. Agents get
the map, not the territory.

### How the Profile Feeds Each Phase

- **The Check:** Question 2 (Precedent-setting?) becomes accurate — Edison *knows* existing
  patterns instead of guessing
- **Research:** Questions go from generic to specific ("Given Supabase + Clerk, should
  notifications use realtime subscriptions or a separate service?")
- **Rounds:** Agents start from existing constraints, don't waste tokens rediscovering the stack
- **Handoff:** Path-based CLAUDE.md triggers generated from actual directory structure
- **Audit:** Knows where implementation files live, what conventions to check against

### Updates

Profile updates append-on-event, not on every run:
- After Explore: add new spec to Active Specs, record run in Edison History
- After Audit: update coverage percentages, flag new tensions
- Never auto re-scan. User can delete `.edison/` to force regeneration.

### Greenfield Projects

Near-empty profile: `{ maturity: "greenfield" }`. Every decision is precedent-setting,
which biases the Check toward recommending Explore more aggressively.

---

## Explore (The Main Event)

Research-first, progressively-deepening design exploration. This is where Edison earns
its name — trying every material before picking the filament.

**This mode is token-intensive by design.** Before starting, estimate the cost and
frame the ROI so the user can make an informed decision.

### Cost Estimation (always present before starting)

Estimate based on the number of priorities identified (or expected):

| Depth | Priorities | Estimated Tokens | When to use |
|-------|-----------|-----------------|-------------|
| Check only | N/A | ~2-5K | Score 0-1, just build |
| Focused (2 rounds) | 3-5 | ~150-250K | Moderate stakes, clear problem |
| Full (3 rounds) | 5-9 | ~350-550K | High stakes, interconnected decisions |
| Deep (3 rounds + extra research) | 7-10 | ~500-700K | "Spare no expense" |

Present the estimate with ROI context:

> "This exploration will run [depth] across [N] priorities — estimated ~[X]K tokens.
> For context, that's roughly [fraction] of a daily budget on [plan tier if detectable].
> The ROI: research shows rework costs 2.5-30x more than getting design right. One
> prevented rebuild pays for this exploration many times over.
>
> Options:
> - **Full explore** (~[X]K tokens) — research + 3 rounds + review gate
> - **Focused explore** (~[Y]K tokens) — research + 2 rounds, skip wild ideas
> - **Just the research** (~[Z]K tokens) — scan the landscape, I'll report findings,
>   you decide whether to go deeper
>
> Which depth?"

If the user doesn't specify, default to Full for high-scoring Checks (4-5) and
Focused for moderate Checks (2-3). The user can always say "go deeper" or "that's
enough" mid-exploration.

**Per-priority graduation reduces actual cost.** If priorities resolve early in R1,
they don't advance — the estimate is a ceiling, not a commitment. Report actual
usage at the end.

### Phase 1: Vision Capture

Listen. Don't interrogate. Structure what the user said into:
1. **Core principles** — Non-negotiables
2. **The feeling** — What should using this feel like
3. **Target users** — Who, what skill level
4. **Entry points** — How users arrive
5. **Anti-targets** — What this is NOT

Play it back in one paragraph. Save to project docs.

**Gate:** User confirms vision captures their intent.

### Phase 2: Research

**This is what makes Edison different.** Do what humans can't.

#### Step 1: Question Generation (~5 seconds)

From the vision document, generate 8-12 specific, falsifiable research questions.
Group into clusters of 3-5 by domain similarity.

Good questions: "What do users of [competitor X] complain about on Reddit?" /
"Has anyone built [this specific feature]? What happened?" / "What's the standard
technical pattern for [core mechanism]?"

Bad questions: "What do users want?" / "What are best practices?"

**Coverage check:** After generating questions, verify they hit 3+ source categories
(user forums, technical docs, competitor analysis, business data, design research).
If questions cluster in one category, reframe 2-3 from an underrepresented perspective
(user advocate, business skeptic, newcomer). This prevents search monoculture.

#### Step 2: Research Dispatch (1-5 agents in parallel)

Number of agents = number of question clusters (minimum 1, maximum 5). Each agent gets:
- Their question cluster
- Required output per question: Sources Found → Specific Findings → Project Implication
- Minimum 2 real sources per question (or explicit "nothing found")
- Confidence tag per finding: verified / inferred / speculative

#### Step 3: Research Synthesis

Collate findings into `RESEARCH-BRIEF.md`:
- **Key findings** ranked by surprise value (what the user didn't already know)
- **Contradictions** between findings surfaced explicitly — most valuable output
- **Opportunity map** — where the vision aligns with unmet user needs
- **Risk flags** — where the vision conflicts with what users actually want

Present top findings to user. No approval needed — intelligence gathering, not a
decision point.

### Phase 3: Priority Identification

Interpret the vision through research. Identify 5-10 key functionalities the vision
hinges on. These aren't "gaps" — they're **priorities**: the things that must be right
for the vision to work.

Each priority gets:
- **Name** — Short, specific
- **Why it's critical** — What breaks if this is wrong
- **Research signal** — What research says about this area
- **Classification** — Primary type (structural / tradeoff / conceptual) + secondary
  type. This classification flows through the entire pipeline: synthesis weighting,
  artifact selection, and handoff shape.
- **Dependencies** — "Depends on [other priority]" and "May invalidate [other priority]"

Present to user. User confirms, reorders, adds, removes.

**Gate:** Priority list confirmed.

### Phase 4: Round 1 — Constraint Satisfaction

**Character: The Engineer.** Find the best known solution for each priority.

One agent per priority (batched in waves of 3-4 for subagent limits). Each receives:
- Vision document + research brief
- Their priority + all other priorities for context
- Resolved outputs from any dependency priorities (if explored in an earlier wave)

Each agent produces:
- `analysis.md` — 500-800 words: priority understood, 2-3 approaches informed by
  research, recommended path with rationale, self-score 1-5
- **Unchallenged assumptions** — things the agent took for granted
- **Artifact** — chosen by agent based on priority classification:
  - Structural → spec with diagrams (Mermaid)
  - Tradeoff → comparison table or side-by-side
  - Conceptual/UX → interactive HTML mockup

#### R1 Synthesis

After all R1 agents complete:
- Per-priority: recommended path, confidence, unchallenged assumptions
- Cross-priority: conflicts, shared dependencies
- Classify each priority: **RESOLVED** (high confidence, clear winner) /
  **CONTESTED** (viable alternatives) / **MURKY** (unclear framing)
- RESOLVED priorities freeze — they don't advance to Round 2
- List of "conventional choices" worth questioning

Write `R1-SYNTHESIS.md`. Present checkpoint table to user.

**Early exit:** If all priorities are RESOLVED, skip to Final Synthesis.

### Progress Visibility

Throughout the exploration, keep the user engaged:
- **Stream one-line findings** as each agent completes (synchronous user)
- **Maintain a living summary** — a rewritable "story so far" block after each
  milestone (async user who steps away)
- **Welcome-back moment** — when user returns after >3 min gap, brief catchup:
  "While you were away: completed Round 2. Key surprise: [X]. Want details?"
- **Checkpoint table** after each round: priority, current answer, confidence, status
- **Never block on user input** — steering available (skip round, reprioritize, stop
  and synthesize what you have) but never required
- **Clear completion block** when done: duration, findings count, top surprises,
  and actual token usage vs. estimate ("Estimated ~400K, used ~320K — 3 priorities
  resolved in R1, saving ~80K")

### Phase 5: Round 2 — Constraint Challenging

**Character: The Designer.** Find what the Engineer missed.

Only CONTESTED and MURKY priorities advance. Each agent receives:
- Everything from R1 + R1-SYNTHESIS
- Their priority's specific unchallenged assumptions (MUST address at least 2)
- Cross-priority insights from 2 other priorities
- An **analytical lens** assigned based on priority classification (see below)

#### Analytical Lenses

Each R2 agent applies a lens — a specific angle of attack, not a persona. Prompt
framing: "Apply the lens of [archetype]" not "You are [archetype]." Include 2-3
trigger questions per lens to prevent degradation to generic analysis.

| Lens | Trigger Questions | Best For |
|------|-------------------|----------|
| **Archaeologist** | What precedents exist? What happened when others tried this? | Tradeoff, Conceptual |
| **Failure Analyst** | What breaks first? Under what load? At what edge? | Structural |
| **End-User Materialist** | What does the person actually do with their hands and eyes? | Conceptual/UX |
| **Economist** | What does this cost to maintain, migrate, or reverse? | Tradeoff, Structural |
| **Integrator** | What happens at the seam where this meets everything else? | Structural, default fallback |

Assignment heuristic: match lens to priority classification (structural → Failure
Analyst or Integrator, tradeoff → Economist or Archaeologist, conceptual → End-User
Materialist). When priorities outnumber lenses, default unmatched to Integrator.
Allow reuse across waves but avoid same lens on related priorities in the same wave.

Each agent MUST:
- Address assumptions with verdicts (confirmed / overturned / refined)
- Produce a structured diff against R1 (what changed, what stayed, why)
- Find gaps within the gaps — guided by their assigned lens
- Cross-pollinate: apply insights from other priorities

**On-demand research:** If a R2 agent discovers a question that research could answer,
it emits `RESEARCH_NEEDED: [specific question]`. A lightweight single-question agent
is dispatched. On-demand must be narrower than upfront research.

#### R2 Synthesis

- Per-priority: assumptions validated/overturned, updated confidence
- Updated graduation: RESOLVED / CONTESTED / MURKY
- **Tensions:** Pairs of priorities that pull against each other, each phrased as a
  design conflict
- "Most radical departure that still serves the vision"

Write `R2-SYNTHESIS.md`. Present checkpoint table.

**Early exit:** If all remaining priorities are now RESOLVED, skip to Final Synthesis.

### Phase 6: Round 3 — Constraint Removal

**Character: The Provocateur.** Push boundaries on the hardest problems.

Round 3 does NOT run per-priority. It runs per-tension from R2-SYNTHESIS. Typically
3-5 tension agents (fewer agents, harder problems, more genuine creativity).

Each agent receives:
- All prior outputs + both syntheses
- One specific tension between two priorities
- The constraint to explore removing

Each agent MUST:
- Name the removed constraint explicitly
- Explore what becomes possible
- Produce a **kernel extraction:** "Even if this full proposal is rejected, the insight
  that should survive is [X]"

Round 3 ideas don't have to be practical. They have to contain at least one insight
that Rounds 1 and 2 missed.

### Phase 7: Final Synthesis

Per priority, pick the best answer from any round. Some priorities get R1's sensible
path. Some get R2's creative refinement. Some get a kernel from R3's wild ideas.
Most get a composite.

#### Deliverable 1: CONVERGENCE.md

Per priority:
- Best source round and why
- What taken from each round
- What left behind and why
- Confidence level (high / medium / low)
- Declared dependencies: "This assumes [external fact Edison can't verify]"
- Reversal triggers for low-confidence decisions

#### Deliverable 2: DEFINITIVE-SPEC.md

The complete design specification. Dual-structure:

**Narrative sections** (for human readers):
- Architecture decisions with rationale
- User flows step by step
- What we are NOT building (informed by research)

**Embedded task blocks** (for implementation agents):
```
## Component: [Name]
IMPLEMENTS: Priority [N]
DEPENDS ON: [files/components]
AGENT INSTRUCTION: [specific implementation directive]
MUST: [requirements]
MUST NOT: [anti-requirements]
VERIFICATION: [how to check this was done correctly]
```

The spec carries its own execution metadata. No separate contracts directory.
No separate checklist. The VERIFICATION fields ARE the checklist.

#### Deliverable 3: Definitive Artifact

Format-agnostic — interactive mockup for product design explorations, architecture
diagram for technical explorations, or both. Named by what it is, not a hardcoded
filename.

### Phase 7.5: Review Gate (~10-12K tokens)

Before handoff, two archetype reviewers independently stress-test the spec as an
artifact (not the design — the document). These are spec *consumers*, not designers.

| Reviewer | Catches | Output |
|----------|---------|--------|
| **The Adversary** | Contradictions between spec sections, unstated assumptions that could be false, gaps where two requirements conflict | Top concern + 3-5 flags + verdict |
| **The New Hire** | Undefined terms, assumed context, sections that only make sense if you were in the room, missing "why" behind decisions | Top concern + 3-5 flags + verdict |

Each reviewer reads the spec independently (no debate) and produces:
- **Top concern** — single biggest risk (1-2 sentences)
- **Flags** — 3-5 specific spec sections with specific problems
- **Verdict** — SHIP IT / NEEDS WORK / STOP

Only STOP verdicts block handoff. NEEDS WORK flags are presented to the user as
advisory. Flags feed into Phase 8 presentation.

**Skip condition:** If all R1 priorities resolved (no R2/R3 needed), skip the review
gate — the spec is simple enough that the gate adds noise, not signal.

### Phase 8: Handoff (THE CRITICAL PHASE)

**Input:** The three deliverables + review gate flags (if any).
**Output:** User-approved design AND binding integration with the build process.

#### Step 1: Present
Walk the user through key research findings, which rounds won for which priorities,
convergence decisions, the artifact's flows, and any review gate flags.

#### Step 2: Get Approval
User approves or requests changes. Iterate until approved.

#### Step 3: Bind (MANDATORY)

1. **CLAUDE.md integration** with path-based triggers:
   ```
   ## Active Design Specs
   - [Feature]: path/to/DEFINITIVE-SPEC.md
     - When working on files in src/auth/**, read the [Auth] section FIRST
     - When working on files in src/mobile/**, read the [Mobile] section FIRST
   ```

2. **Tell the user:** "The spec is bound to CLAUDE.md with path-based triggers. Every
   implementation session working on related files will see the relevant section.
   After building, run `/audit` to verify."

#### Step 4: Preserve
All round outputs stay in the exploration directory. Never delete alternatives —
especially Round 3 kernels.

**Gate:** Spec approved AND bound to CLAUDE.md.

### Directory Structure

```
deep-exploration/
├── VISION.md
├── RESEARCH-BRIEF.md
├── priorities.md
├── r1/
│   ├── priority-1-name/    (analysis.md + artifact)
│   ├── priority-2-name/
│   └── ...
├── R1-SYNTHESIS.md
├── r2/
│   ├── priority-1-name/
│   └── ...
├── R2-SYNTHESIS.md
├── r3/
│   ├── tension-1-name/
│   ├── tension-2-name/
│   └── ...
├── synthesis/
│   ├── CONVERGENCE.md
│   ├── DEFINITIVE-SPEC.md
│   └── [definitive artifact]
└── DEVIATIONS.md            (created during implementation, read on re-invocation)
```

---

## Audit (Spec vs. Code)

Compare an existing design spec against the actual codebase. No new exploration — just
an honest diff between "what we said we'd build" and "what we actually built."

### When to Use

- After completing a major implementation phase
- When the user says "does this match the spec?" or "what happened to X?"
- When the Check finds a spec exists but code has diverged
- Periodically, as a health check
- After implementation agents complete a batch of work

### The Process

#### Step 1: Find the Spec

Use the project profile (`.edison/profile.md`) to locate active specs. Fall back to
searching CLAUDE.md "Active Design Specs" section and `docs/design/`.
If no spec exists, this isn't an audit — route to Explore or just build.

#### Step 2: Parse Task Blocks

Edison specs use a dual-structure: narrative sections + embedded task blocks with
MUST/MUST NOT/VERIFICATION fields. Extract these structured fields first — they are
the machine-checkable assertions. For each task block:

```
## Component: [Name]
MUST: [requirements]
MUST NOT: [anti-requirements]
VERIFICATION: [how to check]
```

Use the project profile's directory structure and CLAUDE.md path-based triggers to
locate the implementation files for each component.

#### Step 3: Check Deviations

Read `DEVIATIONS.md` if it exists. Intentional, documented deviations are NOT gaps —
they are acknowledged decisions. Filter them out before scoring.

#### Step 4: Produce the Gap Analysis

Write `docs/GAP-ANALYSIS.md` (or update if it exists):

| Component | Spec Field | Spec Says | Current Code | Gap Level |
|-----------|-----------|-----------|-------------|-----------|
| [name] | MUST | [requirement] | [code state, file:line] | None / Partial / Missing |
| [name] | MUST NOT | [anti-requirement] | [code state, file:line] | None / Contradiction |
| [name] | VERIFICATION | [check] | [result] | Pass / Fail |

Gap levels:
- **None** — Code matches spec
- **Partial** — Structure exists but incomplete or different
- **Missing** — Not implemented at all
- **Contradiction** — Code does the opposite (highest priority). Check these against
  DEVIATIONS.md — if documented, downgrade to "Acknowledged Deviation"

#### Step 5: Prioritize

1. **Contradictions** (undocumented) — Code does the opposite. Fix first.
2. **Missing critical** — MUST items in core user flows
3. **Failed verifications** — VERIFICATION checks that don't pass
4. **Partial** — Structure exists, needs completion
5. **Missing nice-to-have** — Lower-priority MUST items

#### Step 6: Present to User

Show the scoreboard (% coverage by category) and the prioritized gap list.
Ask: "Want to fix these now, or plan a realignment pass?"

#### Step 7: Bind Updates

- If gaps are fixed, update VERIFICATION fields in the spec
- If the spec was wrong (implementation revealed better approach), update the spec
  and record the rationale in DEVIATIONS.md
- Update the project profile: record audit date, coverage percentage, any new tensions

---

## Key Principles

### Research Before Opinions
Scan the landscape. Bring back intelligence. Questions are a last resort.

### Progressive Deepening
Rounds build on each other. R1 establishes the foundation. R2 challenges assumptions.
R3 resolves tensions. Each round's synthesis feeds the next.

### Per-Priority, Not Per-Round
Synthesis picks the best answer for each priority across all rounds. The final spec
is a composite.

### Graduated Depth
Not every priority needs all 3 rounds. Resolve early, freeze, move on. Only unresolved
priorities advance.

### Specs Must Be Self-Executing
The spec carries its own execution metadata (task blocks, verification criteria). No
bridge artifacts between spec and implementation. Proximity prevents drift.

### Spare No Expense
Edison is explicitly token-intensive. Warn the user, then go hard. The math works:
rework costs 2.5-30x more than getting design right.

### Preserve Everything
Never delete alternatives. Round 3 kernels are especially valuable — radical ideas
that contain insights worth revisiting.

### The User Is Always Right
Every mode is advisory. "Just build it" = build it.
"The spec is wrong, the code is right" = update the spec.

---

## Scaling

| Situation | Approach |
|-----------|----------|
| 1-2 design decisions | Brainstorm skill, not Edison |
| 3-5 priorities, moderate stakes | Explore with 2 rounds (skip R3) |
| 5-9 priorities, high stakes | Explore with 3 rounds (default) |
| 10+ priorities | Split into sub-topics, run Explore on each |
| "Does the code match?" | Audit only |
| "Spare no expense" | Explore with 3 rounds, extra research depth |

## Anti-Patterns

- Running Explore on bug fixes or config changes
- Running Explore when a spec already covers the feature (use Audit)
- Skipping Phase 8 handoff (binding is the whole point)
- Using the Check as procrastination — score 0-1 = just build
- Running Audit without a spec to compare against
- Asking the user questions when you could research the answer
- Watering down the exploration to save tokens
- Running all priorities through all rounds when some resolve in R1
- Generating mockups for architectural priorities (use diagrams/specs)

## Relationship to Other Skills

- **Brainstorming**: Simple decisions. Escalate to Edison if brainstorming reveals unexpected complexity.
- **Writing Plans**: Edison's spec feeds into implementation planning. Plans should reference spec task blocks.
- **Frontend Design**: Round agents can use this for mockup quality.
- **Simplify**: Run after implementation to clean up spec-matched code.
