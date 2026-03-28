# Edison

A Claude Code skill for getting design decisions right before writing code.

Named after Edison who tried 1000 materials before finding the right filament.
The lesson: systematic exploration before commitment produces results that
"just build it" never could.

## What Edison Does

Edison has three modes:

**The Check** (10 seconds) — Five questions that gate whether a design decision
needs exploration. Most decisions don't. Edison tells you when to just build.

**Explore** (20-40 minutes) — Research-first, progressively-deepening design
exploration. Edison scans the real world (forums, competitors, user pain),
identifies priorities, then runs three rounds of increasingly creative analysis.
Produces a self-executing spec with embedded implementation instructions.

**Audit** — Compares an existing spec against the codebase. No new exploration,
just an honest diff between "what we said we'd build" and "what we actually built."

## What Makes Edison Different

- **Research-first**: Edison scans Reddit, forums, competitors, and user pain
  before proposing anything. It brings back intelligence you didn't have.
- **Progressive deepening**: Three rounds that build on each other. Round 1 finds
  the sensible path. Round 2 challenges assumptions. Round 3 resolves tensions
  between competing priorities.
- **Self-executing specs**: The output carries its own implementation instructions
  (MUST/MUST NOT/VERIFICATION fields) so implementation agents can't ignore it.
- **Honest about cost**: Edison estimates token usage upfront, offers depth options,
  and tells you when it's NOT the right tool.

## Cost

Edison is token-intensive by design. The thesis: building the right thing once
saves more than iterating on the wrong thing.

| Mode | Estimated Tokens | When to Use |
|------|-----------------|-------------|
| Check only | ~2-5K | Quick gate — most decisions |
| Focused Explore (2 rounds) | ~150-250K | Moderate stakes |
| Full Explore (3 rounds) | ~350-550K | High stakes, interconnected decisions |
| Audit | ~10-30K | Checking spec vs. code alignment |

Edison always presents the estimate before starting and offers cheaper alternatives.
Per-priority graduation means early-resolved priorities don't advance to later rounds,
reducing actual cost below the estimate.

## Install

**Option A: Plugin marketplace**
```bash
/plugin marketplace add kilnside/edison
```

**Option B: Manual install**
```bash
git clone https://github.com/kilnside/edison.git
cp edison/SKILL.md ~/.claude/skills/edison/SKILL.md
```

**Option C: Project-level (team sharing)**
```bash
cp edison/SKILL.md .claude/skills/edison/SKILL.md
git add .claude/skills/edison/SKILL.md
```

## Usage

```
/edison          # Start with the Check, escalate if needed
/deep-dive       # Go straight to Explore
/audit           # Compare spec vs. code
```

Or just describe a complex design decision — Edison self-triggers when it detects
interconnected, precedent-setting, or irreversible decisions.

## How It Works

```
/edison
  │
  ├── The Check (5 questions, 10 seconds)
  │   ├── Score 0-1 → "Just build it"
  │   └── Score 2+ → Recommends Explore
  │
  ├── Explore
  │   ├── Phase 0: Project Scan (first run only, ~10 seconds)
  │   ├── Phase 1: Vision Capture (listen, structure, play back)
  │   ├── Phase 2: Research (1-5 agents scan the real world)
  │   ├── Phase 3: Priority Identification (5-10 key decisions)
  │   ├── Phase 4: Round 1 — Constraint Satisfaction (the sensible path)
  │   ├── Phase 5: Round 2 — Constraint Challenging (with analytical lenses)
  │   ├── Phase 6: Round 3 — Constraint Removal (wild ideas, tension-based)
  │   ├── Phase 7: Final Synthesis (per-priority, cross-round)
  │   ├── Phase 7.5: Review Gate (Adversary + New Hire spot-check)
  │   └── Phase 8: Handoff (bind spec to CLAUDE.md)
  │
  └── Audit
      ├── Find the spec
      ├── Parse MUST/VERIFICATION fields
      ├── Check DEVIATIONS.md for intentional divergences
      ├── Produce gap analysis
      └── Prioritize: Contradictions > Missing > Partial
```

## Key Principles

- **Research before opinions** — scan the landscape, don't interrogate the user
- **Spare no expense** — token-intensive exploration saves tokens long-term
- **Specs must be self-executing** — no bridge artifacts between spec and implementation
- **Per-priority, not per-round** — synthesis picks the best answer from any round
- **The user is always right** — every mode is advisory

## Origin

Edison was born from a real failure. While building [Kilnside](https://kilnside.com)
— a ceramics community app — we ran a deep design exploration that produced a
thorough spec for the v3 redesign. 21 subagents, 3 rounds, a beautiful
DEFINITIVE-SPEC.md. Then we built it with parallel implementation agents.

The result: **51% spec coverage. 4 structural contradictions.** The mobile
bottom nav directly contradicted the spec's "kill tab navigation" directive.
An onboarding wizard existed that the spec explicitly said to remove. A share
toggle component was built but never wired in. The spec was great. Nobody
followed it.

That failure taught us two things:
1. A spec that nobody follows is worse than no spec
2. AI's real value isn't writing code faster — it's researching what to build

So we built Edison. Then we ran Edison on itself to produce its own spec — 5
research agents, 7 priorities across 3 progressive rounds, 4 tension-based
wild explorations, and 3 synthesis passes. The exploration artifacts are
preserved in `development/`.

The case study that started it all is at
[`development/case-study-gap-analysis.md`](development/case-study-gap-analysis.md) —
63 spec items audited against the codebase, showing exactly where and why the
handoff failed.

## License

MIT
