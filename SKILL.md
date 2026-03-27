---
name: edison
description: >
  Three modes for getting design decisions right. (1) Check — quick 5-question gate before coding.
  (2) Explore — full parallel multi-agent deep dive for major features. (3) Audit — compare
  an existing spec against the codebase to find gaps. Triggers on: /iterate, /edison, /deep-dive,
  /audit, "explore all the options", "are we missing anything?", "what happened to the spec?",
  or any situation where design decisions need validation before code. Also self-triggers before
  implementing interconnected, unexplored, or brand-sensitive features.
  Do NOT use for simple bug fixes, typos, or config changes.
---

# Edison

Three modes for getting design decisions right before writing code.

Named after Edison who tried 1000 materials before finding the right filament. The lesson:
systematic exploration before commitment produces results that "just build it" never could.

Edison exists because of one hard-won insight: **great specs that nobody follows during
implementation are worse than no specs at all.** Every mode in Edison includes a handoff
mechanism that binds the output to the build process.

---

## Routing: Which Mode Do I Need?

```
User request or self-trigger
│
├── "Does the code match the spec?" / "What happened to X?" / /audit
│   └── Mode 3: Audit
│
├── Is there a design decision being made?
│   ├── No → Just build
│   └── Yes → Does a spec already exist?
│       ├── Yes → Does the code match it?
│       │   ├── Yes → Build from the spec
│       │   └── No → Mode 3: Audit (then fix)
│       └── No → How complex is the decision?
│           ├── Simple (1-2 choices) → Brainstorm skill
│           └── Complex (3+ interconnected) → Run the Check (Mode 1)
│               ├── Score 0-1 → Build
│               └── Score 2+ → Mode 2: Explore
```

### Trigger Phrases

| Phrase | Mode |
|--------|------|
| `/edison`, `/iterate`, `/deep-dive` | Start at Mode 1 (Check), escalate if needed |
| `/audit`, "what happened to the spec?", "does this match?" | Mode 3: Audit |
| "explore all the options", "spare no expense", "I want to get this right" | Mode 2: Explore |
| "are we missing anything?", "is there more to think about?" | Mode 1: Check |

### Self-Trigger (Before Writing Code)

Pause and run Mode 1 if you're about to:
- Implement something that contradicts or isn't covered by an existing spec
- Make UX decisions inline while coding (layout, copy, interactions, animations)
- Build a feature that's interconnected (touches 3+ other features), unexplored (first of its kind), or brand-sensitive (users will form opinions)

Do NOT self-trigger for:
- Adding a component that follows an established pattern
- Bug fixes, config changes, dependency updates
- Work the user explicitly said "just build"

---

## Mode 1: The Check (30 seconds)

A quick gate before building. Five questions, honest answers.

### The 5 Questions

#### 1. Interconnected? (Does this touch 3+ other features?)
**Signal:** You're thinking "oh, and this could also be used for..."

#### 2. Unexplored? (Is this the first of its kind in the codebase?)
**Signal:** You're about to create a new directory, hook pattern, or data table.

#### 3. Brand-sensitive? (Will users form opinions about this?)
**Signal:** You're writing user-facing text, choosing animation timing, or deciding layout.

#### 4. Spec exists? (Has this already been designed?)
Search `docs/design/`, `.superpowers/brainstorm/`, and any project-specific design directories.
If a spec exists, the answer isn't "explore" — it's "follow the spec" or "audit the spec."

#### 5. Will this output actually get used?
The hardest question. If the answer to #4 is "yes, a spec exists but the code doesn't match it,"
then the problem isn't exploration — it's execution. Route to Mode 3 (Audit) instead.

### Scoring

| Score | Spec exists? | Action |
|-------|-------------|--------|
| 0-1 true | Yes | Build from spec |
| 0-1 true | No | Build, flag assumptions |
| 2+ true | Yes, code matches | Build from spec |
| 2+ true | Yes, code diverged | **Mode 3: Audit** |
| 2+ true | No | **Mode 2: Explore** |

### What to Say When the Check Says Stop

> "Before I build [feature], this touches [X, Y, Z], it's the first time we're implementing
> [category], and it involves [visual/UX decisions] that will be hard to change later.
> I think [Mode 2 exploration / Mode 3 audit] would save us from building the wrong thing.
> Want me to do that, or should I go ahead?"

The check is advisory. If the user says "just build it," build it.

---

## Mode 2: The Exploration (Major Features)

Full parallel multi-agent deep dive. Reserve this for paradigm shifts, major redesigns,
and features where 3+ design decisions are interconnected.

**Cost warning:** A typical run with 7 gaps × 3 rounds produces ~24 agents and 300-500K tokens.
Always warn the user before launching.

### Phase 1: Vision Extraction

**Input:** The user talking about what they want.
**Output:** A structured vision document.

Listen. Structure what they said into:
1. **Core principles** — Non-negotiables
2. **Entry points** — How users arrive
3. **Target users** — Who, what skill level
4. **Anti-targets** — What this is NOT
5. **The feeling** — What should using this feel like

Play it back. Save to project docs.

**Gate:** User confirms vision captures their intent.

### Phase 2: Paradigm Check

**Input:** Vision + current product state.
**Output:** Polish pass or paradigm shift?

Signs of a paradigm shift:
- "Everything feels disjointed" → information architecture
- "I keep switching between X and Y" → workflow fragmentation
- "This should all be one thing" → object model collapse
- "Why do I have to go to a different page?" → navigation mismatch

**Gate:** User agrees on scope.

### Phase 3: Focused Clarification

**Input:** Vision doc.
**Output:** Key structural decisions.

Ask ONE question at a time:
1. **User model** — How do different users experience this?
2. **Interaction model** — Core navigation metaphor (show 2-3 visual options)
3. **Object model** — Core objects and relationships
4. **Entry points** — Primary entry or all equal?

**Gate:** You can describe the interaction model in one sentence.

### Phase 4: Core Prototype

**Input:** Structural decisions.
**Output:** One interactive HTML mockup of the core interaction.

Deliberately incomplete — validates structure, not details. Missing things become the gap list.

**Gate:** User validates core interaction model.

### Phase 5: Gap Identification

**Input:** Core prototype + vision.
**Output:** Numbered list of gaps (typically 5-9).

Each gap must be:
- Specific enough for one agent to explore independently
- Broad enough that multiple valid solutions exist
- Testable against vision principles

**Gate:** User confirms gap list.

### Phase 6: Parallel Deep Exploration

**Input:** Vision + prototype + gaps.
**Output:** N gaps × 3 rounds = analysis docs + interactive mockups.

#### Round Framing
- **Round 1: Direct** — "Solve this gap."
- **Round 2: Challenger** — "Challenge the obvious solution."
- **Round 3: Provocateur** — Specific constraint or radical metaphor. These are the most
  important prompts. Take the user's most radical statements and push them further.

#### Agent Instructions
Each agent produces:
- `analysis.md` — 500-800 words: problem, 2-3 approaches, recommendation, self-score 1-5 per vision principle
- `mockup.html` — Standalone interactive HTML showing solution integrated into core prototype

#### Directory Structure
```
deep-exploration/
├── gap-1-name/       (Round 1)
├── gap-2-name/
├── r2/gap-1-name/    (Round 2)
├── r2/gap-2-name/
├── r3/gap-1-name/    (Round 3)
├── r3/gap-2-name/
├── synthesis/
└── meta-synthesis/
```

Launch all agents per round in parallel. Don't wait for Round 1 to finish before starting Round 2.

**Gate:** All 3 rounds complete.

### Phase 7: Synthesis

**Input:** All analysis docs and mockups.
**Output:** Three deliverables.

1. **CONVERGENCE.md** — Per gap: converged (high confidence), refined (take latest), or diverged (judgment call)
2. **DEFINITIVE-SPEC.md** — Complete design spec. Opinionated. No "could do X or Y."
3. **definitive-mockup.html** — THE interactive prototype showing every major flow

**Gate:** All three deliverables written.

### Phase 8: Handoff (THE CRITICAL PHASE)

This is where previous Edison runs failed. The spec was great but didn't become a build contract.

**Input:** The three deliverables.
**Output:** User-approved design AND binding integration with the build process.

#### Step 1: Present
Walk the user through convergence decisions, key choices, and the mockup's flows.

#### Step 2: Get Approval
User approves or requests changes. Iterate until approved.

#### Step 3: Bind the Spec to Implementation (MANDATORY)

This step prevents the "great spec, ignored during build" failure mode:

1. **Add to CLAUDE.md** under an "Active Design Specs" section:
   ```
   ## Active Design Specs
   - [Feature Name]: path/to/DEFINITIVE-SPEC.md — MUST be checked before implementing any related feature
   ```

2. **Create a verification checklist** at `docs/design/[feature]-checklist.md`:
   - One checkbox per spec item
   - Grouped by component/area
   - Used by implementation agents and audit mode

3. **Tell the user:** "The spec is now linked in CLAUDE.md. Every implementation session will
   see it. After building, we can run `/audit` to verify the code matches."

#### Step 4: Preserve
All round mockups stay in the exploration directory. Never delete alternatives.

**Gate:** Spec is approved AND bound to CLAUDE.md AND verification checklist created.

---

## Mode 3: The Audit (Spec vs Code)

Compare an existing design spec against the actual codebase. No new exploration — just an
honest diff between "what we said we'd build" and "what we actually built."

### When to Use

- After completing a major implementation phase
- When the user says "does this match the spec?" or "what happened to X?"
- When Mode 1's check reveals a spec exists but code has diverged
- Periodically, as a health check

### The Process

#### Step 1: Find the Spec
Search `docs/design/`, `.superpowers/brainstorm/`, CLAUDE.md "Active Design Specs" section.
If no spec exists, this isn't an audit — route to Mode 2 (Explore) or just build.

#### Step 2: Read Both Sides
Read the spec thoroughly. Then read the actual implementation files.

#### Step 3: Produce the Gap Analysis

Write `docs/GAP-ANALYSIS.md` (or update if it exists) with:

| Spec Item | Spec Says | Current Code | Gap Level |
|-----------|-----------|-------------|-----------|
| [item] | [what spec requires] | [what code does, with file:line] | None / Partial / Missing |

Categories:
- **None** — Code matches spec
- **Partial** — Structure exists but incomplete or different
- **Missing** — Not implemented at all
- **Contradiction** — Code does the opposite of what spec says (highest priority)

#### Step 4: Prioritize

Group gaps into:
1. **Contradictions** — Code does the opposite. Fix first.
2. **Missing critical** — Core user flows that don't work
3. **Partial** — Structure exists, needs completion
4. **Missing nice-to-have** — Spec items that can wait

#### Step 5: Present to User

Show the scoreboard (% coverage by category) and the prioritized gap list.
Ask: "Want to fix these now, or plan a realignment pass?"

#### Step 6: Bind Updates

If gaps are fixed, update the verification checklist. If the spec needs revision
(some decisions changed during implementation for good reasons), update the spec
and note why.

---

## Key Principles

### Divergence Before Convergence
Three rounds exist to produce genuinely different solutions. Round 3's provocateur prompts
prevent groupthink. Don't make them soft.

### Prototypes Over Prose
Every agent produces an interactive mockup. Mockups reveal problems prose hides.

### Specs Must Be Binding
A spec that isn't checked during implementation is decoration. Mode 2's handoff phase and
Mode 3's audit exist specifically to close this gap.

### Preserve Everything
Never delete alternatives. The user may revisit a rejected idea.

### The User Is Always Right
Every mode is advisory. If the user says "just build it," build it.
If the user says "the spec is wrong, the code is right," update the spec.

---

## Scaling

| Situation | Approach |
|-----------|----------|
| 1-2 design decisions | Brainstorm skill, not Edison |
| 3-4 gaps, moderate stakes | Mode 2 with 2 rounds |
| 5-9 gaps, high stakes | Mode 2 with 3 rounds (default) |
| 10+ gaps | Split into sub-topics, run Mode 2 on each |
| "Does the code match?" | Mode 3 only |
| User says "spare no expense" | Mode 2 with 3+ rounds |

## Anti-Patterns

- Running Mode 2 on bug fixes or config changes
- Running Mode 2 when a spec already covers the feature (use Mode 3 instead)
- Skipping Phase 8 handoff (the whole point is binding the spec to the build)
- Using the self-check as procrastination — if score is 0-1, just build
- Running Mode 3 without a spec to compare against (that's Mode 2's job)
- Producing a spec and not adding it to CLAUDE.md Active Design Specs

## Relationship to Other Skills

- **Brainstorming**: For simple design decisions. Escalate to Edison Mode 2 if brainstorming reveals unexpected complexity.
- **Writing Plans**: Edison's definitive spec feeds into implementation planning.
- **Frontend Design**: Gap agents can use this for mockup quality, but it's optional.
- **Simplify**: Run after implementation to clean up code that was built to match a spec.
