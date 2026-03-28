# Edison Research Brief: Synthesized Findings

**Date:** 2026-03-27
**Sources:** 5 parallel research agents covering user pain, competitive landscape, niche gaps, technical patterns, and user expectations.

---

## Key Findings (Top 10)

### 1. AI is too eager to code — and everyone knows it
The single loudest complaint across Reddit, HN, and developer blogs: AI tools "dive in without thinking." Pete Hodgson: AI is on "their first hour on the team," making "design decisions at the level of a fairly junior engineer." The 70% Problem is widely discussed — AI gets you 70% fast, the remaining 30% (actual design decisions) becomes a costly rework spiral.

### 2. Spec-driven development is now an industry movement
GitHub Spec Kit, AWS Kiro, Tessl ($500M valuation), Augment Intent — the industry has converged on "specs first" as the antidote to vibe coding. But every tool focuses on generating code FROM specs. None help you arrive at the RIGHT spec through exploration. Edison's Mode 2 is the missing upstream phase.

### 3. Progressive deepening beats parallel exploration (empirically)
A 148-participant study (PLOS ONE) found deepening strategies significantly outperform parallel exploration for both trust (4.79 vs 4.04) and idea adoption (6.98 vs 5.22). Building sequentially on prior rounds produces more trusted and adopted outputs than running independent parallel explorations.

### 4. Heterogeneous agents are the value driver
The A-HMAD paper shows homogeneous agents drop performance by 3.5%. Edison's Literal/Creative/Wild differentiation is architecturally sound — the key is making prompts *maximally different*, not variations on a theme. Round 1 should minimize persona framing (factual accuracy); Round 3 should maximize it (creative divergence).

### 5. Trust in AI is falling even as adoption rises
84% of devs use AI but only 29% trust its accuracy (Stack Overflow 2025). Edison's framing as "researcher bringing back findings" rather than "oracle giving answers" matches how developers already think about AI: a fast, fallible collaborator.

### 6. Attention spans cap at ~10 minutes for black-box processes
Users will abandon a process they can't see progressing. Edison's exploration must deliver intermediate value — findings, priorities, round results — not go dark for 30 minutes. Progress signals are table stakes.

### 7. Rework costs 2.5-30x more than getting it right in design
IBM: fixing post-release costs 30x more than during design. 30-50% of project effort goes to rework. A company spent $180K on a chatbot that failed in 3 days because they "didn't invest time to clearly identify desired business outcomes." This is Edison's core thesis, confirmed by data.

### 8. Solo developers need exploration most but have it least
1 in 3 indie founders use AI for 70%+ of work. No team discussion to surface alternatives. Edison's multi-agent exploration simulates the missing team.

### 9. The Claude Code skill ecosystem is large (334+) but shallow
Most skills are capability uplifts or encoded preferences. Edison is a rare *workflow* skill with multi-phase orchestration, gates, and persistent artifacts. The combination of explore + bind + audit is unique in the ecosystem.

### 10. Spec drift is the natural state, not an edge case
Specs go stale within weeks. Edison's CLAUDE.md binding is the correct persistence strategy (survives session boundaries), but research suggests going further: per-component contracts and machine-readable assertions for automated drift detection.

---

## User Pain Ranking (by evidence volume and intensity)

1. **Building the wrong thing confidently** — the 70% Problem, "prompt and pray"
2. **Specs that drift from implementation** — hours, not days
3. **Token waste from rework cycles** — 5.5x differences measured between tools
4. **AI never challenges or explores alternatives** — "eager junior developer"
5. **Cognitive load increase, not decrease** — review-and-debug costs more than writing
6. **No research capability** — tools structure what you know, don't discover what you don't
7. **Inconsistency across sessions** — same feature built differently each time

---

## Opportunity Map: Where Vision Meets Unmet Needs

| Vision Element | Market Need | Strength of Fit |
|---|---|---|
| Research-first (scan forums, competitors, users) | "No tool does primary research before designing" (competitive landscape) | **Unique** — no competitor does this |
| Progressive deepening (3 rounds) | Empirically validated over parallel exploration | **Validated** — PLOS ONE study |
| Priorities not gaps | Developers prefer specs over mockups (user expectations) | **Aligned** |
| Spare no expense | Rework costs 2.5-30x more than design (multiple studies) | **Justified** — the math works |
| Binding handoff (CLAUDE.md) | Spec drift is the #2 pain point | **Critical** — must keep |
| Audit mode | GitHub, AWS, Tessl all targeting this space | **Table stakes** — validates importance |
| 5-question gate (Mode 1) | Token cost is a real psychological barrier (85% miss forecasts) | **Essential** — cheap gate protects expensive explore |

---

## Risk Flags

1. **Token cost vs. attention span tension.** 400-700K tokens takes time. Users abandon black-box processes after ~10 minutes. Edison MUST deliver intermediate value progressively.

2. **Subagent limits.** Claude Code ceiling is ~3-4 parallel agents recommended. Edison's 5-10 per round may push limits. Need to monitor and potentially batch.

3. **Round 3 quality is prompt-dependent.** Research confirms persona prompting helps creativity but hurts factual accuracy. Round 3 prompts must be carefully crafted creative constraints, not generic "be wild."

4. **Monolithic specs are fragile.** Research recommends per-component implementation contracts over single DEFINITIVE-SPEC.md documents. The handoff may need decomposition.

5. **Mockup value is lower than expected.** Developers prefer text-based specs over visual artifacts. Edison's requirement for mockup.html per agent may be overhead for some priorities (especially architectural ones).

---

## Surprising Discoveries

1. **Developers were 19% SLOWER with AI but BELIEVED they were 24% faster** (METR study). The productivity illusion means tools that slow you down deliberately (like Edison) face a perception problem — even though they save time net.

2. **Iterative debate has diminishing returns.** Adding debate rounds doubled token cost for +0.006 F1 improvement. Edison's three distinct missions per round are more efficient than re-debating the same question.

3. **The spec-as-source movement (Tessl) proposes humans NEVER write code — only specs.** At $500M valuation, this isn't fringe. Edison could position as the exploration layer that feeds spec-as-source pipelines.

4. **"Interpretation drift" across AI sessions** is a named problem with no tooling solution. Different sessions implement the same spec differently. Edison's binding mechanism is one of the only approaches that addresses this.

5. **Augment Intent's "living spec" updates bidirectionally** — when code changes, the spec updates too. This is the opposite of Edison's philosophy (spec holds code accountable). Both approaches have merit. Edison should acknowledge that spec updates are sometimes correct (when implementation reveals the spec was wrong).

---

*Research complete. 5 agents, 60+ sources scanned. Proceeding to Priority Identification.*
