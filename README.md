<div align="center">

# Edison

**The design decision phase that AI skipped.**

[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Claude Code Skill](https://img.shields.io/badge/Claude_Code-Skill-blueviolet)](https://code.claude.com/docs/en/skills)
[![Agent Skills](https://img.shields.io/badge/Agent_Skills-Compatible-green)](https://agentskills.io)

*Named after Edison who tried 1,000 materials before finding the right filament.*<br>
*Systematic research before commitment produces results that "just build it" never could.*

---

[Install](#install) | [Usage](#usage) | [How It Works](#how-it-works) | [Cost](#cost) | [Output Contract](#output-contract)

</div>

## The Gap

FigJam helps you brainstorm. v0 helps you build. Nothing helps you **decide**.

Edison fills the phase between brainstorming and building — the part where you research alternatives, weigh tradeoffs, and commit to an approach. It dispatches parallel research agents, runs progressively-deepening rounds of analysis, and produces a self-executing spec that binds to your implementation workflow.

Edison's purpose is creative discovery, not convention compliance. It knows established patterns the way an artist knows art history — as context, not instructions. When Edison independently arrives at a known pattern, that's validation through understanding. When it doesn't, that's where the real value lives.

## Three Modes

| Mode | Time | What It Does |
|------|------|-------------|
| **Check** | ~10 seconds | Five questions that gate whether a decision needs exploration. Most don't. Edison tells you when to just build. |
| **Explore** | 20-40 minutes | Research-first, progressively-deepening design exploration. Three rounds of analysis. Produces a self-executing spec. |
| **Audit** | 5-15 minutes | Compares an existing spec against the codebase. An honest diff between "what we said we'd build" and "what we actually built." |

## Install

**Plugin marketplace** (recommended)
```bash
/plugin marketplace add kilnside/edison
```

<details>
<summary>Other install methods</summary>

**From source (installs Edison + Edison Evolve + Product Forge)**
```bash
git clone https://github.com/kilnside/edison.git
cd edison && ./install.sh
```

**Project-level (team sharing)**
```bash
cp edison/SKILL.md .claude/skills/edison/SKILL.md
cp -r edison/resources .claude/skills/edison/resources
git add .claude/skills/edison/
```
</details>

## Usage

```
/edison              # Start with the Check, escalate if needed
/deep-dive           # Go straight to Explore
/edison audit        # Compare spec vs. code
/edison --autonomous # Run end-to-end without pausing at gates
```

Or just describe a complex design decision — Edison self-triggers when it detects interconnected, precedent-setting, or irreversible decisions.

**Autonomous mode** (`--autonomous`, or say *"run autonomously"* / *"I'll be AFK"* / *"don't wait for me"*) keeps gates as internal synthesis checkpoints but doesn't pause for confirmation. Edison writes the vision, priorities, and final spec, binds it, auto-commits, and reports completion. You review the result after the fact. Steering via interrupt is always available.

## How It Works

```
/edison
  |
  +-- The Check (5 questions, 10 seconds)
  |   +-- Score 0-1: "Just build it"
  |   +-- Score 2+: Recommends Explore
  |
  +-- Explore
  |   +-- Phase 0:   Project Scan (first run only)
  |   +-- Phase 1:   Vision Capture
  |   +-- Phase 2:   Research (1-5 agents scan the real world)
  |   |   +-- Guidance Board posted (◆ Edison companion with
  |   |       1-3 fork questions + phase progress spine)
  |   +-- Phase 3:   Priority Identification (5-10 key decisions)
  |   +-- Phase 4:   Round 1 - The Engineer (constraint satisfaction)
  |   |   +-- Auto-graduation: confident priorities freeze early
  |   |   +-- Round Signal Check: skip if no new signal
  |   +-- Phase 5:   Round 2 - The Designer (constraint challenging)
  |   |   +-- Creative contribution map: novel vs established ground
  |   +-- Phase 6:   Round 3 - The Provocateur (constraint removal)
  |   +-- Phase 7:   Final Synthesis
  |   +-- Phase 7.5: Review Gate (Adversary + New Hire stress-test)
  |   +-- Phase 8:   Handoff (bind spec to AGENTS.md, auto-commit)
  |
  +-- Audit
      +-- Parse MUST/VERIFICATION fields from spec
      +-- Check DEVIATIONS.md for intentional divergences
      +-- Produce gap analysis in .edison/audits/
      +-- Prioritize: Contradictions > Missing > Partial
```

<details>
<summary><strong>The Check: 5 Questions</strong></summary>

| # | Question | Signal |
|---|----------|--------|
| 1 | **Interconnected?** | Touches 3+ other features |
| 2 | **Precedent-setting?** | Future code will copy this pattern |
| 3 | **Opinionated?** | Someone with authority will react strongly |
| 4 | **Irreversible?** | Expensive to change after shipping |
| 5 | **Multi-stakeholder?** | Affects different user types or teams differently |

Score 2+ recommends Explore.
</details>

<details>
<summary><strong>Progressive Deepening</strong></summary>

- **Round 1 (The Engineer)** — Finds the sensible, research-informed path for each priority. High-confidence priorities with no cross-priority conflicts auto-graduate — they freeze and don't advance, saving tokens. A Round Signal Check after R1 scores novelty and disagreement; if agents just confirmed what research already found, Edison recommends skipping to synthesis.
- **Round 2 (The Designer)** — Challenges Round 1's assumptions through analytical lenses (Archaeologist, Failure Analyst, End-User Materialist, Economist, Integrator). Seeks synthesis between R1 options, not just elimination. Tracks a creative contribution map: which recommendations align with established conventions vs. genuinely novel territory.
- **Round 3 (The Provocateur)** — Tackles tensions *between* priorities. Finds ideas nobody asked for that might be brilliant. Produces kernel extractions.

Synthesis picks the best answer per-priority across all rounds. Round 1 might win for stability. Round 3 might win for the signature interaction.

**Fork Questions:** Before dispatching research, Edison identifies 1-3 high-leverage pivot questions — places where one answer would eliminate 30%+ of the research scope. These are surfaced async (like an email from a colleague who keeps working regardless). If you answer, Edison narrows at synthesis time. If you don't, the exploration is identical to a fully autonomous run.
</details>

<details>
<summary><strong>The Guidance Board</strong></summary>

When Edison finds high-leverage fork questions, it posts a Guidance Board — an ambient companion presence, not a task list:

```
┌ ▐░▌ Edison — Researching
│
│  A few forks in the road:
│
│  ◇ Mobile-first or desktop-first?              (high leverage)
│  ◇ Clean break or coexist with current system?  (moderate leverage)
│
│  ◆◇◇◇◇◇ Researching · 0/4 agents
└
```

**Three-layer presence:**
- **Mark** — `◆` prefixes every Edison status line. Recognition at scroll speed.
- **Narrator** — Phase-tied action verbs with brevity decay. `Researching` → `Shaping` → `Exploring` → `Challenging` → `Probing` → `Synthesizing` → `Complete`.
- **Figure** — `▐░▌` appears exactly twice per run, as bookends. Hello at the first board, goodbye at the handoff line.

**The board re-emits** at major phase transitions with updated header and fork question states. Between re-emissions, standalone diamond breadcrumbs (`◆◆◆◇◇◇ Exploring · 3/8`) form a scannable spine through the scrollback. An AFK user who returns after 30 minutes can reconstruct the journey from 5-8 breadcrumb lines.

The board never nags, never re-asks unanswered questions, and never references silence. Insurance against retroactive regret — not obligation.
</details>

<details>
<summary><strong>Cross-User Read Verification</strong></summary>

When a Component queries rows the current user doesn't own (social feeds, discovery, shared content, notifications), Edison adds a `CROSS-USER READ` field to the spec. This flags the need for explicit RLS / access control verification alongside functional testing.

Why: functional tests cannot detect silently-blocked cross-user queries. A query that returns zero rows because of policy blocking is indistinguishable from a query that returns zero rows because there's no data yet. The feature "works" in tests and breaks in production. Only explicit policy review catches it.

```markdown
## Component: Inspired-By Feed
IMPLEMENTS: Priority 3 (Community Discovery)
VERIFICATION: Feed renders pieces from users the viewer doesn't follow
CROSS-USER READ: yes — confirm RLS policies permit this query for
  non-owner users. Silently-empty RLS results look identical to
  "no data yet" state.
```
</details>

<details>
<summary><strong>Self-Executing Specs</strong></summary>

Edison's specs carry their own implementation instructions:

```markdown
## Component: Recipe Tree View
IMPLEMENTS: Priority 3 (Branching Visualization)
DEPENDS ON: recipe-card.tsx, branch-model.ts
AGENT INSTRUCTION: Render recipe lineage as a collapsible tree...
MUST: Show attribution chain to original author
MUST NOT: Use accordion pattern for depth levels
VERIFICATION: Tree renders 3+ levels, originator visible at every depth
```

No separate contracts. No separate checklist. The VERIFICATION fields ARE the checklist.
</details>

## Cost

Edison is token-intensive by design. The thesis: building the right thing once saves more than iterating on the wrong thing.

| Depth | Estimated Tokens | When to Use |
|-------|-----------------|-------------|
| Check only | ~2-5K | Quick gate — most decisions |
| Focused (2 rounds) | ~150-250K | Moderate stakes, clear problem |
| Full (3 rounds) | ~350-550K | High stakes, interconnected decisions |
| Audit | ~10-30K | Checking spec vs. code alignment |

Edison always presents the estimate before starting and offers cheaper alternatives. Per-priority graduation means early-resolved priorities don't advance to later rounds.

## Output Contract

Edison's DEFINITIVE-SPEC.md uses a predictable structure any tool can consume:

| Field | Meaning |
|-------|---------|
| `## Component:` | Independent implementation unit |
| `IMPLEMENTS:` | Traces to a named priority |
| `MUST:` / `MUST NOT:` | Binary-testable requirements |
| `VERIFICATION:` | How to confirm it was done correctly |
| `DEPENDS ON:` | File/component prerequisites |
| `AGENT INSTRUCTION:` | Specific implementation directive |

Any skill that reads markdown with these fields can plan from an Edison spec. No Edison installation required to consume the output.

## Output Location

All Edison output lives in `.edison/` at the project root:

```
.edison/
├── profile.md           Project identity + lessons
├── explorations/        Timestamped exploration runs
├── audits/              Spec vs. code gap analyses
├── evolution-log.md     Run metadata for self-improvement
└── DEVIATIONS.md        Intentional spec divergences
```

## Companion Skills

Edison works alone. Edison works better with these:

| Skill | Role | Install |
|-------|------|---------|
| **Edison Evolve** | Reads Edison outputs, proposes SKILL.md improvements | `cp -r edison-evolve ~/.claude/skills/` |
| **Product Forge** | End-to-end orchestrator: Edison → validate → build → test → ship | `cp -r product-forge ~/.claude/skills/` |
| **Brainstorming** | Simple decisions (Check score 0-1) | — |
| **Implementation Planning** | Plans from Edison's spec task blocks | — |

None are required. Product Forge is recommended for going from idea to working MVP in one session.

## Origin

Edison was born from a real failure. While building a ceramics community app, we ran a deep design exploration that produced a thorough spec — 21 subagents, 3 rounds, a beautiful DEFINITIVE-SPEC.md. Then we built it. The result: 51% spec coverage, 4 structural contradictions. The spec was great. Nobody followed it.

That failure taught us: a spec that nobody follows is worse than no spec. So we built Edison with binding mechanisms that make specs impossible to ignore — and then ran Edison on itself to design its own v2 and v3 specifications.

---

<div align="center">

MIT License | Made by [Kilnside](https://kilnside.com)

</div>
