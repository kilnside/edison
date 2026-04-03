# Explore Mode — Phase Execution Detail

> **Loaded on-demand when Edison enters Explore mode.**
> This file contains the full execution instructions for every phase.
> The main SKILL.md body has phase summaries and gates only.

---

## Phase 1: Vision Capture

**Vision Capture is synthesis of user input, not interrogation.** Structure what the user
already said — don't ask 5 questions. If the user gave you a paragraph, extract the
categories below from that paragraph. Only ask for clarification on categories where the
user's input is genuinely ambiguous.

Listen. Structure what the user said into:

1. **Core principles** — Non-negotiables ("it must be real-time", "no vendor lock-in")
2. **The feeling** — What should using this feel like ("snappy", "trustworthy", "invisible")
3. **Target users** — Who, what skill level, what context
4. **Entry points** — How users arrive at this feature
5. **Anti-targets** — What this is NOT ("not a full CMS", "not for power users")

Play it back in one paragraph. Save to `.edison/explorations/[date]-[feature]/VISION.md`.

**Gate (blocking):** User confirms vision captures their intent. This is one of three
blocking gates in Explore mode. Steering is non-blocking. Gates (Vision, Priority,
Handoff) are blocking by design.

---

## Phase 2: Research

**This is what makes Edison different.** Do what humans can't — scan the landscape and
bring back intelligence the user didn't have.

### Step 1: Question Generation (~5 seconds)

From the vision document, generate 8-12 specific, falsifiable research questions.
Group into clusters of 3-5 by domain similarity.

Good questions:
- "What do users of [competitor X] complain about on Reddit?"
- "Has anyone built [this specific feature]? What happened?"
- "What's the standard technical pattern for [core mechanism]?"

Bad questions:
- "What do users want?"
- "What are best practices?"

**User signal category (REQUIRED):** At least 1 question MUST come from the "user signal"
category: forum complaints, support tickets, analytics patterns, review sentiment. Examples:
- "What are the top complaints about [competitor]'s implementation of [feature] on G2/Reddit?"
- "What patterns show up in support tickets for apps with similar [mechanism]?"
- "What do app store reviews say about [feature type] in [domain] apps?"

**Coverage check:** After generating questions, verify they hit 3+ source categories:
- User forums / community discussions
- Technical docs / implementation references
- Competitor analysis
- Business data / market signals
- Design research / UX studies
- **User signals** (required — see above)

If questions cluster in one category, reframe 2-3 from an underrepresented perspective
(user advocate, business skeptic, newcomer). This prevents search monoculture.

### Step 2: Research Dispatch (1-5 agents in parallel)

Number of agents = number of question clusters (minimum 1, maximum 5).

**Example split for product features:** UX patterns / domain needs / technical
implementation / visual design. This 4-way split produces non-redundant results
for domain-specific product work. Adapt the split to match the exploration's domain
— this template is a starting point, not a prescription.

Each agent gets:
- Their question cluster
- Required output per question: Sources Found → Specific Findings → Project Implication
- Minimum 2 real sources per question (or explicit "nothing found")
- Confidence tag per finding: verified / inferred / speculative

### Step 3: Research Synthesis

Collate findings into `RESEARCH-BRIEF.md`:
- **Key findings** ranked by surprise value (what the user didn't already know)
- **Contradictions** between findings surfaced explicitly — most valuable output
- **Opportunity map** — where the vision aligns with unmet user needs
- **Risk flags** — where the vision conflicts with what users actually want

Present top findings to user. No approval needed — intelligence gathering, not a
decision point.

**Fallback — Null research:** If >50% of research questions return nothing useful,
compress what exists, flag the low-evidence state explicitly to the user, and bias
Round 1 toward conservative, well-established approaches. Do not fabricate findings
to fill gaps.

---

## Phase 3: Priority Identification

Interpret the vision through research. Identify 5-10 key functionalities the vision
hinges on. These aren't "gaps" — they're **priorities**: the things that must be right
for the vision to work.

Each priority gets:
- **Name** — Short, specific
- **Why it's critical** — What breaks if this is wrong
- **Research signal** — What research says about this area
- **Classification** — Primary type + secondary type:
  - **Structural** — Architecture, data model, system boundaries
  - **Tradeoff** — Competing approaches with real costs on each side
  - **Conceptual** — UX, mental model, how users think about it
  This classification flows through the entire pipeline: synthesis weighting,
  artifact selection, and handoff shape.
- **Dependencies** — "Depends on [other priority]" and "May invalidate [other priority]"

Present to user. User confirms, reorders, adds, removes.

**Gate (blocking):** Priority list confirmed.

**Late priority injection:** Users may add priorities between rounds. These are accepted
with a note in synthesis that late-added priorities have reduced coverage (fewer rounds
of analysis). They enter the next round alongside advancing priorities.

---

## Phase 4: Round 1 — Constraint Satisfaction

**Character: The Engineer.** Find the best known solution for each priority.

One agent per priority, batched in waves of 3-4 for subagent limits. Each receives:
- Vision document + research brief
- Their priority + all other priorities for context
- Resolved outputs from any dependency priorities (if explored in an earlier wave)

Each agent produces:
- `analysis.md` — 500-800 words: priority understood, 2-3 approaches informed by
  research, recommended path with rationale, **self-score 1-5**
- **Unchallenged assumptions** — things the agent took for granted
- **Artifact** — chosen by agent based on priority classification:
  - Structural → spec with diagrams (Mermaid)
  - Tradeoff → comparison table or side-by-side
  - Conceptual/UX → interactive HTML mockup

Agent outputs go to `.edison/explorations/[date]-[feature]/r1/priority-N-name/`.

### R1 Synthesis

After all R1 agents complete:
- Per-priority: recommended path, confidence, unchallenged assumptions
- Cross-priority: conflicts, shared dependencies
- Classify each priority using self-score as starting heuristic:
  - **Self-score 1-2 → MURKY** (unclear framing, no clear winner)
  - **Self-score 3 → CONTESTED** (viable alternatives, needs challenge)
  - **Self-score 4-5 → RESOLVED** (high confidence, clear winner)
  Synthesis can override these classifications based on cross-priority analysis
  (e.g., a self-score-4 priority that contradicts another priority may be downgraded
  to CONTESTED).
- **Auto-graduation:** Priorities with self-score ≥4 AND no cross-priority conflicts
  detected in synthesis auto-graduate to RESOLVED. Do not advance them to R2. This
  saves tokens on well-understood priorities without sacrificing depth on contested
  ones. Cross-priority conflict = the priority's recommended path contradicts or
  creates tension with another priority's recommendation.
- RESOLVED priorities freeze — they don't advance to Round 2
- List of "conventional choices" worth questioning

Write `R1-SYNTHESIS.md`. Present checkpoint table to user.

### Round Signal Check

Before proceeding to the next round, evaluate whether this round produced enough
new signal to justify the token investment of another round. Score two dimensions:

| Dimension | Question | Low Signal |
|-----------|----------|------------|
| **Novelty** | Did agents produce findings not already in the research brief? | >70% of findings trace directly to research with no new analysis |
| **Disagreement** | Did agents disagree with each other or with research? | All agents converged on the same answer with no tension |

- **0/2 = skip to Final Synthesis.** The round didn't produce new information —
  another round won't either. Tell the user: "This round confirmed what research
  already found. Recommending we synthesize now rather than spend tokens on another
  round."
- **1/2 = recommend skip, user can override.** Present the signal assessment and
  let the user decide.
- **2/2 = proceed.** Genuine signal exists for the next round to build on.

Add a signal row to the checkpoint table:

```
| Round Signal | Novelty: ✓/✗ | Disagreement: ✓/✗ | → Proceed/Skip |
```

**Early exit:** If all priorities are RESOLVED, skip to Final Synthesis.

---

## Progress Visibility

Throughout the exploration, keep the user engaged:

- **Stream one-line findings** as each agent completes (synchronous user)
- **Maintain a living summary** — a rewritable "story so far" block after each
  milestone (async user who steps away)
- **Welcome-back moment** — when user returns after >3 min gap, brief catchup:
  "While you were away: completed Round 2. Key surprise: [X]. Want details?"
- **Checkpoint table** after each round:

  | Priority | Current Answer | Confidence | Status |
  |----------|---------------|------------|--------|
  | [name]   | [one-line]    | [1-5]      | RESOLVED / CONTESTED / MURKY |

- **Steering is non-blocking.** Gates (Vision, Priority, Handoff) are blocking by
  design. Between gates, steering is always available (skip round, reprioritize,
  stop and synthesize what you have) but never required.
- **Clear completion block** when done: duration, findings count, top surprises,
  and actual token usage vs. estimate ("Estimated ~400K, used ~320K — 3 priorities
  resolved in R1, saving ~80K")

---

## Phase 5: Round 2 — Constraint Challenging

**Character: The Designer.** Find what the Engineer missed.

Only CONTESTED and MURKY priorities advance. Each agent receives:
- Everything from R1 + R1-SYNTHESIS
- Their priority's specific unchallenged assumptions (MUST address at least 2)
- Cross-priority insights from 2 other priorities
- An **analytical lens** assigned based on priority classification (see below)

### Analytical Lenses

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
Analyst or Integrator, tradeoff → Economist (default) or Archaeologist, conceptual →
End-User Materialist). Tradeoffs default to Economist because tradeoffs are
fundamentally about resource allocation and opportunity cost. When priorities outnumber
lenses, default unmatched to Integrator. Allow reuse across waves but avoid same lens
on related priorities in the same wave.

Each agent MUST:
- Address assumptions with verdicts: **confirmed** / **overturned** / **refined**
- Produce a structured diff against R1 (what changed, what stayed, why)
- **Seek synthesis between R1 options, not just elimination.** R2's power is often in
  combining the best of competing approaches into a hybrid R1 didn't consider. Ask:
  "Can two of R1's options work together?" before asking "Which option wins?"
- Find gaps within the gaps — guided by their assigned lens
- Cross-pollinate: apply insights from other priorities

**On-demand research:** If a R2 agent discovers a question that research could answer,
it emits `RESEARCH_NEEDED: [specific question]`. A lightweight single-question agent
is dispatched. On-demand research must be narrower than upfront research.

Agent outputs go to `.edison/explorations/[date]-[feature]/r2/priority-N-name/`.

### R2 Synthesis

- Per-priority: assumptions validated/overturned, updated confidence
- Updated graduation: RESOLVED / CONTESTED / MURKY
- **Tensions:** Pairs of priorities that pull against each other, each phrased as a
  design conflict (e.g., "Performance wants server rendering but Interactivity wants
  client state")
- "Most radical departure that still serves the vision"

Write `R2-SYNTHESIS.md`. Present checkpoint table.

### Round Signal Check

Same evaluation as post-R1 (see Phase 4). Score Novelty and Disagreement for R2's
output relative to R1. If 0/2, skip to Final Synthesis. If 1/2, recommend skip.
If 2/2, proceed to R3.

**Early exit:** If all remaining priorities are now RESOLVED, skip to Final Synthesis.

**Fallback — All MURKY after R2:** If all advancing priorities remain MURKY after R2,
force Round 3 on the top-3 MURKY priorities treated as tensions against each other.
If fewer than 2 priorities remain, escalate to the user: "These priorities aren't
resolving. Want to reframe them or proceed to synthesis with what we have?"

---

## Phase 6: Round 3 — Constraint Removal

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

Agent outputs go to `.edison/explorations/[date]-[feature]/r3/tension-N-name/`.

**Focused (2-round) path:** When the user chose Focused depth, Round 3 is skipped
entirely. Final Synthesis uses only R1 + R2 outputs. No R3 references, no tension
agents, no kernel extractions. The synthesis instruction becomes "pick the best answer
from available rounds" — not "from any round including R3."

---

## Phase 7: Final Synthesis

Per priority, pick the best answer **from available rounds** (not "from any round").
Some priorities get R1's sensible path. Some get R2's creative refinement. On Full
runs, some get a kernel from R3's wild ideas. Most get a composite.

For Focused (2-round) runs, synthesis draws only from R1 and R2.

### Deliverable 1: CONVERGENCE.md

Per priority:
- Best source round and why
- What taken from each round
- What left behind and why
- Confidence level (high / medium / low)
- Declared dependencies: "This assumes [external fact Edison can't verify]"
- Reversal triggers for low-confidence decisions

#### Run Metadata

Append `## Run Metadata` to CONVERGENCE.md after synthesis:
- Priority count (initial and final, noting any late injections)
- Resolution rounds per priority (which round resolved each)
- User modifications (reorders, additions, removals during gates)
- Fallbacks triggered (null research, all-MURKY, etc.)
- Research hit rate (questions with useful results / total questions)

### Deliverable 2: DEFINITIVE-SPEC.md

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

**Validation Plan (REQUIRED):** DEFINITIVE-SPEC.md includes a `## Validation Plan`
section at the end. For each low-confidence or medium-confidence decision:
```
- **[Decision]**: After building, test [assumption] with [method]
  Confidence: [medium/low] | Source: [round]
```
Edison is pre-prototype — proxy signals (analytics, user forums, competitor patterns)
are the correct method for this phase. Do not require the developer to conduct user
testing during Edison exploration. The Validation Plan frames what to validate *after*
building.

### Deliverable 3: Definitive Artifact

Format-agnostic — interactive mockup for product design explorations, architecture
diagram for technical explorations, or both. Named by what it is, not a hardcoded
filename.

### Cross-Project Learning

During Final Synthesis, deposit tagged observations to the user's Claude Code memory.
These are reusable insights that transcend the current project:

- `[edison:preference]` — User style/approach preferences observed during this run
- `[edison:stack-pattern]` — Technical patterns that worked well for this stack
- `[edison:process-outcome]` — What happened when Edison took a particular process path
- `[edison:edge-case]` — Edge cases encountered and how they resolved
- `[edison:domain-insight]` — Domain-specific knowledge worth carrying forward

Write observations as they occur during synthesis, not extracted afterward. Do not store
file paths, code snippets, or project-specific identifiers in cross-project observations.

All synthesis outputs go to `.edison/explorations/[date]-[feature]/synthesis/`.

---

## Phase 7.5: Review Gate (~10-12K tokens)

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

Only **STOP** verdicts block handoff. **NEEDS WORK** flags are presented to the user as
advisory. Flags feed into Phase 8 presentation.

**No skip.** The review gate always runs, even on simple specs. Evidence shows it
catches real contradictions (scope conflicts, undefined thresholds, missing taxonomies)
at low cost (~10-12K tokens). The gate earns its cost.

---

## Phase 8: Handoff (THE CRITICAL PHASE)

**Input:** The three deliverables + review gate flags (if any).
**Output:** User-approved design AND binding integration with the build process.

### Step 1: Present (Interactive Artifact Review)

Present the synthesized artifact first (DEFINITIVE-SPEC.md). Walk the user through:
- Key research findings that shaped the design
- Which rounds won for which priorities
- Convergence decisions and their rationale
- The artifact's user flows
- Any review gate flags (Adversary/New Hire concerns)

**Do not dump all files.** Start with the synthesis. Offer drill-down per-priority
on request: "The auth decision came from Round 2's challenge. Want to see the
alternatives it considered?"

Collect feedback per-artifact when reviewing: "Any changes to this section?"

### Step 2: Get Approval

User approves or requests changes. Iterate until approved.

### Step 3: Bind (MANDATORY)

1. **AGENTS.md integration** (primary) with directory-scoped triggers. Create or update
   AGENTS.md files scoped to relevant directories:
   ```
   # src/auth/AGENTS.md
   ## Active Design Specs
   - [Feature]: .edison/explorations/[date]-[feature]/synthesis/DEFINITIVE-SPEC.md
     - When working on files in this directory, read the [Auth] section FIRST
   ```

2. **CLAUDE.md supplement** (cross-reference only). If CLAUDE.md exists, add:
   ```
   ## Active Design Specs
   See AGENTS.md for active design specs from Edison.
   ```
   Keep Claude-specific behaviors in CLAUDE.md only: self-trigger rules, Edison history,
   memory directives. Do not duplicate spec references across both files.

3. **Tell the user:** "The spec is bound to AGENTS.md with directory-scoped triggers.
   Every implementation session working on related files will see the relevant section.
   After building, run `/audit` to verify."

### Step 4: Preserve

All round outputs stay in the exploration directory. Never delete alternatives —
especially Round 3 kernels.

**Gate (blocking):** Spec approved AND bound to AGENTS.md.

### Step 5: Auto-Save (MANDATORY)

After binding, automatically commit and push Edison's artifacts. Don't ask.

1. Stage `.edison/` and any modified AGENTS.md / CLAUDE.md files
2. Commit with message: `edison: [feature-name] exploration complete`
3. Push if a remote is configured
4. If push fails (no remote, auth issue), note it but don't block — the commit is what matters

Edison artifacts are project infrastructure. Losing them across sessions breaks the
design chain — specs become unbound, audits have nothing to compare against, and
Edison Evolve loses its input data.

### Step 6: Cleanup Check

Before closing out, scan for stale artifacts from this session:

- Files created during exploration that aren't part of the final output (abandoned
  vision drafts, superseded priority lists, research that was discussed and rejected)
- Previous explorations in `.edison/explorations/` that are no longer referenced by
  any active AGENTS.md or CLAUDE.md binding

If stale artifacts are found, offer: "These artifacts aren't part of the final spec.
Archive them so they don't clutter future runs?" Archived artifacts move to
`.edison/archive/` — preserved but not read during Phase 0. Update the profile's
Active Specs to remove archived entries.

If nothing is stale, skip silently.

### Output Directory Structure

```
.edison/
├── profile.md
├── explorations/
│   └── [date]-[feature]/
│       ├── VISION.md
│       ├── RESEARCH-BRIEF.md
│       ├── priorities.md
│       ├── r1/
│       │   ├── priority-1-name/    (analysis.md + artifact)
│       │   ├── priority-2-name/
│       │   └── ...
│       ├── R1-SYNTHESIS.md
│       ├── r2/
│       │   ├── priority-1-name/
│       │   └── ...
│       ├── R2-SYNTHESIS.md
│       ├── r3/                     (Full runs only)
│       │   ├── tension-1-name/
│       │   ├── tension-2-name/
│       │   └── ...
│       └── synthesis/
│           ├── CONVERGENCE.md      (includes Run Metadata)
│           ├── DEFINITIVE-SPEC.md  (includes Validation Plan)
│           └── [definitive artifact]
├── audits/
│   └── [date]-[feature].md
├── evolution-log.md
└── DEVIATIONS.md
```

All Edison output lives in `.edison/` at the project root. Do not use `deep-exploration/`
or any other output directory.
