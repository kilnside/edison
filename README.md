<div align="center">

# Edison

**Get design decisions right before writing code.**

[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Claude Code Skill](https://img.shields.io/badge/Claude_Code-Skill-blueviolet)](https://code.claude.com/docs/en/skills)
[![Agent Skills](https://img.shields.io/badge/Agent_Skills-Compatible-green)](https://agentskills.io)

*Named after Edison who tried 1,000 materials before finding the right filament.*<br>
*Systematic exploration before commitment produces results that "just build it" never could.*

---

[Install](#install) | [Usage](#usage) | [How It Works](#how-it-works) | [Cost](#cost) | [Origin Story](#origin)

</div>

## Three Modes

| Mode | Time | What It Does |
|------|------|-------------|
| **Check** | ~10 seconds | Five questions that gate whether a decision needs exploration. Most don't. Edison tells you when to just build. |
| **Explore** | 20-40 minutes | Research-first, progressively-deepening design exploration. Scans the real world, identifies priorities, runs three rounds of increasingly creative analysis. Produces a self-executing spec. |
| **Audit** | 5-15 minutes | Compares an existing spec against the codebase. An honest diff between "what we said we'd build" and "what we actually built." |

## What Makes Edison Different

> **Research, not interrogation.** Edison scans Reddit, forums, competitors, and user pain before proposing anything. It brings back intelligence you didn't have.

<details>
<summary><strong>Progressive deepening</strong> — three rounds that build on each other</summary>

- **Round 1 (Constraint Satisfaction)** — The Engineer. Finds the sensible, research-informed path for each priority.
- **Round 2 (Constraint Challenging)** — The Designer. Challenges Round 1's assumptions through analytical lenses (Archaeologist, Failure Analyst, End-User Materialist, Economist, Integrator).
- **Round 3 (Constraint Removal)** — The Provocateur. Tackles tensions *between* priorities. Finds ideas nobody asked for that might be brilliant.

Synthesis picks the best answer per-priority across all rounds. Round 1 might win for stability. Round 3 might win for the signature interaction.
</details>

<details>
<summary><strong>Self-executing specs</strong> — no bridge artifacts between spec and implementation</summary>

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

<details>
<summary><strong>Honest about cost</strong> — tells you when it's NOT the right tool</summary>

Edison estimates tokens upfront and offers depth options. If the Check scores 0-1, Edison says: "This doesn't need Edison — just build it." Every unnecessary run erodes trust and wastes your budget.
</details>

## Install

**Plugin marketplace** (recommended)
```bash
/plugin marketplace add kilnside/edison
```

<details>
<summary>Other install methods</summary>

**Manual install**
```bash
git clone https://github.com/kilnside/edison.git
cp edison/SKILL.md ~/.claude/skills/edison/SKILL.md
```

**Project-level (team sharing)**
```bash
cp edison/SKILL.md .claude/skills/edison/SKILL.md
git add .claude/skills/edison/SKILL.md
```
</details>

## Usage

```
/edison          # Start with the Check, escalate if needed
/deep-dive       # Go straight to Explore
/audit           # Compare spec vs. code
```

Or just describe a complex design decision — Edison self-triggers when it detects interconnected, precedent-setting, or irreversible decisions.

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
  |   +-- Phase 3:   Priority Identification (5-10 key decisions)
  |   +-- Phase 4:   Round 1 - Constraint Satisfaction
  |   +-- Phase 5:   Round 2 - Constraint Challenging (with lenses)
  |   +-- Phase 6:   Round 3 - Constraint Removal (tension-based)
  |   +-- Phase 7:   Final Synthesis
  |   +-- Phase 7.5: Review Gate (Adversary + New Hire)
  |   +-- Phase 8:   Handoff (bind spec to CLAUDE.md)
  |
  +-- Audit
      +-- Parse MUST/VERIFICATION fields from spec
      +-- Check DEVIATIONS.md for intentional divergences
      +-- Produce gap analysis
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

Score 2+ recommends Explore. Both Interconnected AND Irreversible = always Explore.
</details>

<details>
<summary><strong>Round 2 Analytical Lenses</strong></summary>

Each Round 2 agent applies a lens — a specific angle of attack, not a persona:

| Lens | Trigger Questions | Best For |
|------|-------------------|----------|
| **Archaeologist** | What precedents exist? What happened when others tried this? | Tradeoff, Conceptual |
| **Failure Analyst** | What breaks first? Under what load? At what edge? | Structural |
| **End-User Materialist** | What does the person actually do with their hands and eyes? | Conceptual/UX |
| **Economist** | What does this cost to maintain, migrate, or reverse? | Tradeoff, Structural |
| **Integrator** | What happens at the seam where this meets everything else? | Structural, default |
</details>

## Cost

Edison is token-intensive by design. The thesis: building the right thing once saves more than iterating on the wrong thing. Research shows rework costs **2.5-30x** more than getting design right.

| Depth | Estimated Tokens | When to Use |
|-------|-----------------|-------------|
| Check only | ~2-5K | Quick gate — most decisions |
| Focused (2 rounds) | ~150-250K | Moderate stakes, clear problem |
| Full (3 rounds) | ~350-550K | High stakes, interconnected decisions |
| Audit | ~10-30K | Checking spec vs. code alignment |

Edison always presents the estimate before starting and offers cheaper alternatives. Per-priority graduation means early-resolved priorities don't advance to later rounds, often reducing actual cost 30-50% below the estimate.

## Key Principles

| Principle | What It Means |
|-----------|--------------|
| Research before opinions | Scan the landscape. Bring back intelligence. Questions are a last resort. |
| Spare no expense | Token-intensive exploration saves tokens long-term. Warn the user, then go hard. |
| Specs must be self-executing | The spec carries its own MUST/VERIFICATION fields. No bridge artifacts. |
| Per-priority, not per-round | Synthesis picks the best answer from any round. The spec is a composite. |
| Graduated depth | Not every priority needs all 3 rounds. Resolve early, freeze, move on. |
| The user is always right | Every mode is advisory. "Just build it" = build it. |

## Origin

Edison was born from a real failure.

While building **[Kilnside](https://kilnside.com)** — a ceramics community app — we ran a deep design exploration that produced a thorough spec for the v3 redesign. 21 subagents, 3 rounds, a beautiful DEFINITIVE-SPEC.md. Then we built it with parallel implementation agents.

The result: **51% spec coverage. 4 structural contradictions.**

The mobile bottom nav directly contradicted the spec's "kill tab navigation" directive. An onboarding wizard existed that the spec explicitly said to remove. A share toggle component was built but never wired in. The spec was great. Nobody followed it.

That failure taught us two things:
1. **A spec that nobody follows is worse than no spec**
2. **AI's real value isn't writing code faster — it's researching what to build**

So we built Edison. Then we ran Edison on itself — 5 research agents, 7 priorities across 3 progressive rounds, 4 tension-based explorations, and 3 synthesis passes — to produce its own specification.

> The case study that started it all: [`development/case-study-gap-analysis.md`](development/case-study-gap-analysis.md) — 63 spec items audited against the codebase, showing exactly where and why the handoff failed.

---

<div align="center">

MIT License | Made by [Kilnside](https://kilnside.com)

</div>
