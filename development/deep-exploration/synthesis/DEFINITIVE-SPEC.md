# Edison v2: Definitive Specification

*Produced by running Edison on itself. 5 research agents, 7 R1 agents, 7 R2 agents, 4 R3 tension agents, 3 synthesis passes.*

---

## Core Philosophy

Edison exists because of three insights:

1. **AI's unique value is research, not interrogation.** Scan the landscape. Bring back intelligence the user didn't have. Questions are a last resort.
2. **Great specs that nobody follows are worse than no specs.** Every mode includes a binding mechanism that makes the spec impossible to ignore during implementation.
3. **Exploration saves tokens long-term.** Building the right thing once costs less than building the wrong thing and rebuilding. Spare no expense.

---

## Architecture Overview

Edison has two modes and an audit capability:

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

### Self-Trigger

Pause and run the Check if you're about to:
- Implement something that contradicts or isn't covered by an existing spec
- Make UX decisions inline while coding
- Build a feature that's interconnected (3+ features), precedent-setting, or opinionated

Do NOT self-trigger for:
- Adding a component that follows an established pattern
- CRUD operations on an existing data model
- Bug fixes, config changes, dependency updates, test files
- Work the user explicitly said "just build"

**Positive examples** (should trigger): adding a new payment flow, designing the first notification system, choosing between competing architecture patterns.
**Negative examples** (should not trigger): adding a new REST endpoint following existing patterns, updating a form's validation rules, fixing a CSS alignment bug.

---

## The Check (10 seconds)

Five questions. Unweighted. Threshold: 2 of 5.

### The 5 Questions

1. **Interconnected?** Does this touch 3+ other features?
   *Signal: "oh, and this could also be used for..."*

2. **Precedent-setting?** Will future code copy this pattern?
   *Signal: creating a new directory, hook pattern, data access convention.*

3. **Opinionated?** Will someone with authority have a strong reaction to this?
   *Signal: user-facing text, animation timing, API contract shape, architecture choice the team lead cares about.*

4. **Irreversible?** Is this expensive to change after shipping?
   *Signal: database schema, public API, navigation structure, data model.*

5. **Multi-stakeholder?** Does this affect different user types or teams differently?
   *Signal: admin vs. end-user, mobile vs. desktop, frontend vs. backend team.*

### Scoring

Score 0-1: Build. Flag assumptions.
Score 2+: Recommend Explore. Present the case. User decides.

**Hard trigger:** If both Interconnected AND Irreversible are true, always recommend Explore regardless of total score.

### Pre-Check

Before scoring, do a quick contradiction sniff:
- Glob for specs in `docs/design/`, CLAUDE.md "Active Design Specs" section
- If the task conflicts with an active spec, flag immediately and route to Audit

### What to Say

> "Before I build [feature], this [scores on questions X, Y]. I think exploration would save us from building the wrong thing. This will be thorough — expect [estimate]. Want me to explore, or should I go ahead?"

The check is advisory. "Just build it" = build it.

---

## Explore (The Main Event)

Research-first, progressively-deepening design exploration.

**Cost warning (always present before starting):**
> "This exploration will be thorough — expect 300-600K tokens across research, up to three progressive rounds, and synthesis. The payoff is a spec informed by what real users actually want. Proceed?"

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

From the vision document, generate 8-12 specific, falsifiable research questions. Group into clusters of 3-5 by domain similarity.

Good questions: "What do users of [competitor X] complain about on Reddit?" / "Has anyone built [this specific feature]? What happened?" / "What's the standard technical pattern for [core mechanism]?"
Bad questions: "What do users want?" / "What are best practices?"

#### Step 2: Research Dispatch (1-5 agents in parallel)

Number of agents = number of question clusters (minimum 1, maximum 5). Each agent gets:
- Their question cluster
- Required output per question: Sources Found → Specific Findings → Project Implication
- Minimum 2 real sources per question (or explicit "nothing found")
- Confidence tag per finding: verified / inferred / speculative

#### Step 3: Research Synthesis

Collate findings into `RESEARCH-BRIEF.md`:
- **Key findings** ranked by surprise value (what the user didn't already know)
- **Contradictions** between findings surfaced explicitly — these are the most valuable output
- **Opportunity map** — where the vision aligns with unmet user needs
- **Risk flags** — where the vision conflicts with what users actually want

Present top findings to user. No approval needed — intelligence gathering, not a decision point.

### Phase 3: Priority Identification

Interpret the vision through research. Identify 5-10 key functionalities the vision hinges on.

Each priority gets:
- **Name** — Short, specific
- **Why it's critical** — What breaks if this is wrong
- **Research signal** — What research says about this area
- **Classification** — Primary type (structural / tradeoff / conceptual) + secondary type. This classification flows through the entire pipeline: synthesis weighting, artifact selection, and handoff shape.
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
- `analysis.md` — 500-800 words: the priority understood, 2-3 approaches informed by research, recommended path with rationale, self-score 1-5
- **Unchallenged assumptions** — things the agent took for granted
- **Artifact** — chosen by agent based on priority classification:
  - Structural → spec with diagrams (Mermaid)
  - Tradeoff → comparison table or side-by-side
  - Conceptual/UX → interactive HTML mockup

#### R1 Synthesis

After all R1 agents complete:
- Per-priority: recommended path, confidence, unchallenged assumptions
- Cross-priority: conflicts, shared dependencies
- Classify each priority: **RESOLVED** (high confidence, clear winner) / **CONTESTED** (viable alternatives) / **MURKY** (unclear framing)
- RESOLVED priorities freeze — they don't advance to Round 2
- List of "conventional choices" worth questioning

Write `R1-SYNTHESIS.md`. Present checkpoint table to user.

**Early exit:** If all priorities are RESOLVED, skip to Final Synthesis.

### Phase 5: Round 2 — Constraint Challenging

**Character: The Designer.** Find what the Engineer missed.

Only CONTESTED and MURKY priorities advance. Each agent receives:
- Everything from R1 + R1-SYNTHESIS
- Their priority's specific unchallenged assumptions (MUST address at least 2)
- Cross-priority insights from 2 other priorities

Each agent MUST:
- Address assumptions with verdicts (confirmed / overturned / refined)
- Produce a structured diff against R1 (what changed, what stayed, why)
- Find gaps within the gaps
- Cross-pollinate: apply insights from other priorities

**On-demand research:** If a R2 agent discovers a question that research could answer, it emits `RESEARCH_NEEDED: [specific question]`. A lightweight single-question agent is dispatched. On-demand must be narrower than upfront research.

#### R2 Synthesis

- Per-priority: which assumptions validated/overturned, updated confidence
- Updated graduation: RESOLVED / CONTESTED / MURKY
- **Tensions:** Pairs of priorities that pull against each other, each phrased as a design conflict
- "Most radical departure that still serves the vision"

Write `R2-SYNTHESIS.md`. Present checkpoint table.

**Early exit:** If all remaining priorities are now RESOLVED, skip to Final Synthesis.

### Phase 6: Round 3 — Constraint Removal

**Character: The Provocateur.** Push boundaries on the hardest problems.

Round 3 does NOT run per-priority. It runs per-tension from R2-SYNTHESIS. Typically 3-5 tension agents (fewer agents, harder problems, more genuine creativity).

Each agent receives:
- All prior outputs + both syntheses
- One specific tension between two priorities
- The constraint to explore removing

Each agent MUST:
- Name the removed constraint explicitly
- Explore what becomes possible
- Produce a **kernel extraction:** "Even if this full proposal is rejected, the insight that should survive is [X]"

Round 3 ideas don't have to be practical. They have to contain at least one insight that Rounds 1 and 2 missed.

### Phase 7: Final Synthesis

Per priority, pick the best answer from any round. Some priorities get R1's sensible path. Some get R2's creative refinement. Some get a kernel from R3's wild ideas. Most get a composite.

#### Deliverable 1: CONVERGENCE.md

Per priority:
- Best source round and why
- What taken from each round
- What left behind and why
- Confidence level (high / medium / low)
- Declared dependencies: "This decision assumes [external fact Edison can't verify]"
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

The spec carries its own execution metadata. No separate contracts directory. No separate checklist. The VERIFICATION fields ARE the checklist.

#### Deliverable 3: Definitive Artifact

Format-agnostic — interactive mockup for product design explorations, architecture diagram for technical explorations, or both. Named by what it is, not a hardcoded filename.

### Phase 8: Handoff

**Input:** The three deliverables.
**Output:** User-approved design bound to the build process.

#### Step 1: Present
Walk the user through key research findings, which rounds won for which priorities, convergence decisions, and the artifact's flows.

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

2. **Tell the user:** "The spec is bound to CLAUDE.md with path-based triggers. Every implementation session working on related files will see the relevant section. After building, run `/audit` to verify."

#### Step 4: Preserve
All round outputs stay in the exploration directory. Never delete alternatives — especially Round 3 kernels.

**Gate:** Spec approved AND bound to CLAUDE.md.

---

## Audit (Spec vs. Code)

Compare an existing spec against the codebase. No new exploration.

### When to Use
- After a major implementation phase
- "Does this match the spec?" / "What happened to X?"
- When the Check finds a spec exists but code diverged
- Periodically, as a health check

### Process

1. **Find the spec** — CLAUDE.md Active Design Specs, docs/design/
2. **Read both sides** — spec thoroughly, then implementation files
3. **Gap analysis** — `docs/GAP-ANALYSIS.md`:

   | Spec Item | Spec Says | Current Code | Gap Level |
   |-----------|-----------|-------------|-----------|
   | [item] | [requirement] | [code state, file:line] | None / Partial / Missing / Contradiction |

4. **Prioritize** — Contradictions > Missing critical > Partial > Nice-to-have
5. **Present** — Scoreboard + prioritized list. "Fix now or plan a realignment?"
6. **Bind updates** — If gaps fixed, update VERIFICATION fields. If spec was wrong, update spec with rationale in DEVIATIONS.md.

---

## Key Principles

### Research Before Opinions
Scan the landscape. Bring back intelligence. Questions are a last resort.

### Progressive Deepening
Rounds build on each other. R1 establishes the foundation. R2 challenges assumptions. R3 resolves tensions. Each round's synthesis feeds the next.

### Per-Priority, Not Per-Round
Synthesis picks the best answer for each priority across all rounds. The final spec is a composite.

### Graduated Depth
Not every priority needs all 3 rounds. Resolve early, freeze, move on. Only unresolved priorities advance.

### Specs Must Be Self-Executing
The spec carries its own execution metadata (task blocks, verification criteria). No bridge artifacts between spec and implementation. Proximity prevents drift.

### Spare No Expense
Edison is explicitly token-intensive. Warn the user, then go hard. The math works: rework costs 2.5-30x more than getting design right.

### Preserve Everything
Never delete alternatives. Round 3 kernels are especially valuable — radical ideas that contain insights worth revisiting.

### The User Is Always Right
Every mode is advisory. "Just build it" = build it. "The spec is wrong" = update the spec.

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
