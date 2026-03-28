# P3: Self-Improvement Loop — R1 Analysis

**Character:** The Engineer
**Priority type:** Structural (primary) / Conceptual (secondary)

## The Problem

Edison is a prompt. It has no runtime, no database, no server. Its "code" is SKILL.md. Today, improving Edison means a human edits that file, tests it, and pushes a commit. This is Level 2 — static, manually-maintained. The vision is Level 4: Edison's own outputs feed back into its specification, making each version produce the next. No AI coding tool ships this. The mechanism must work within Claude Code's constraints: markdown files, no persistent processes, no arbitrary code execution.

## What Gets Captured

Before picking a mechanism, the right question is: what data does Edison already produce that could drive improvement? Three categories:

1. **Process outcomes.** Did priorities resolve in R1 (efficient) or drag to R3 (spec was unclear)? Did research find sources (good questions) or return nothing (bad questions)? Did the Review Gate flag issues (spec quality problem)?
2. **User signals.** User reorders priorities (Edison's ranking was wrong). User says "just build it" to a Check score of 3+ (over-triggering). User adds priorities Edison missed (research gap). User corrects Vision Capture (listening failure).
3. **Audit results.** Gap analysis percentages. Contradiction frequency. Which MUST/MUST NOT fields consistently fail (spec phrasing problem vs. implementation problem).

P2's edge case work is relevant here: when fallback clauses trigger, that is failure data. Every time Edison hits an undefined behavior and falls back, that event should be captured.

## Approach 1: Append-Only Event Log + Periodic Human Review

**Mechanism:** After each Edison run, append a structured event to `.edison/evolution-log.md`:

```markdown
## Run 2026-03-28 | Mode: explore | Project: my-app
- Priorities: 7 identified, 4 resolved R1, 2 resolved R2, 1 tension R3
- Research: 10/12 questions found sources (83%)
- User overrides: reordered P2 above P1, added P6 (missed by Edison)
- Fallbacks triggered: null-research handler (Q7, Q11)
- Review gate: SHIP IT (both reviewers)
- Audit (post-impl): 87% coverage, 2 contradictions
```

**Feedback path:** The log accumulates. Periodically (every N runs, or on explicit `/edison evolve`), Edison reads the log, identifies patterns, and proposes SKILL.md changes as a diff. The human reviews and merges.

**Human oversight:** Full gating. Edison never modifies itself without explicit approval. The diff is presented as "Based on 12 runs across 4 projects, I recommend these changes" with evidence.

**Strengths:** Simple. Works within existing file constraints. The log is human-readable and auditable. Matches Anthropic's pattern ("when Claude does something wrong, add it to CLAUDE.md") but automates the "add it" step.

**Weaknesses:** Passive. Requires the human to remember to run the evolution step. Log grows without bound. No mechanism for Edison to test whether proposed changes actually improve outcomes.

## Approach 2: Dual-Level Evolution (PromptBreeder-Inspired)

**Mechanism:** Two evolution targets, two cadences:

**Task-level (per-project, automatic):** `.edison/profile.md` already exists. Extend it with a `## Lessons` section that captures project-specific adaptations: "Research questions about authentication consistently return nothing in this codebase — skip auth research cluster" or "User always reorders UX priorities above technical priorities — adjust default ranking." This is local adaptation, not spec modification.

**Meta-level (cross-project, gated):** A separate file `.edison/meta-observations.md` (stored globally at `~/.claude/skills/edison/.edison/meta-observations.md`) aggregates patterns across projects. When the same lesson appears in 3+ project profiles, it graduates to a meta-observation. On explicit invocation, Edison reads meta-observations and proposes SKILL.md mutations.

The PromptBreeder insight: evolve both the task-prompts (how Edison explores THIS project) AND the mutation-prompts (how Edison generates improvements to itself). In practice this means the `## Lessons` format itself can evolve — if Edison notices its lessons are too vague to act on, it tightens the lesson template.

**Human oversight:** Task-level changes are advisory (profile updates, no approval needed). Meta-level mutations require explicit human review before merging into SKILL.md.

**Strengths:** Dual cadence matches reality — projects are different but patterns emerge across them. The PromptBreeder-inspired self-referential loop (improving how you improve) is genuinely novel. Natural bridge to P4 (cross-project learning).

**Weaknesses:** Complexity. Two evolution targets, two storage locations, a graduation mechanism. The meta-level observations file could grow large. Self-referential improvement is hard to reason about — how do you evaluate whether your improvement-process improved?

## Approach 3: OpenAI-Style 4-Stage Loop with Failure Memory

**Mechanism:** Formalize the self-improvement as an explicit cycle:

1. **Baseline:** Current SKILL.md is the baseline. Tag it with a version.
2. **Evaluate:** After N runs (or on demand), Edison audits itself. Read the evolution log. Compute metrics: average priorities resolved per round, research hit rate, user override frequency, audit coverage trends. Compare to previous baseline.
3. **Metaprompt:** Edison generates candidate SKILL.md mutations. But instead of one proposal, generate 3-5 variations (aiXplain Evolver-inspired). Each variation targets a different metric. Include a `## Failed Mutations` section that records previously-rejected changes and why — this prevents re-proposing dead ends.
4. **Replace:** Human picks the best variation (or none). The chosen variation becomes the new baseline. Increment version.

**Human oversight:** Stage 4 is the gate. The human sees: current metrics, proposed variations, expected impact, and failure history.

**Strengths:** Structured and measurable. The failure memory (recording what was tried and rejected) prevents cycling. Multiple variations give the human real choices. Version tagging creates a clear history.

**Weaknesses:** Heaviest mechanism. Generating 3-5 SKILL.md variations is token-expensive. Metrics require enough runs to be meaningful (cold start problem). The "evaluate" step assumes Edison can meaningfully self-assess — but the Research Brief notes that co-evolving evaluation criteria is an unsolved problem.

## Recommendation: Approach 2 (Dual-Level Evolution)

Approach 1 is too passive — it captures data but relies entirely on human initiative to act on it. Approach 3 is too heavy for a v3 launch — it requires enough run history to compute meaningful metrics, and the multi-variation generation is expensive. Approach 2 hits the sweet spot:

- **Task-level** adaptation starts working immediately (first run in any project enriches the profile). No cold start problem.
- **Meta-level** mutations accumulate naturally and only fire when patterns are strong (3+ projects). This is a natural filter against noise.
- The PromptBreeder-inspired self-referential element (improving the improvement process) is the genuine differentiator that puts Edison at Level 4. No other tool does this.
- It bridges cleanly to P4 (cross-project learning) because the meta-observations file IS the cross-project learning mechanism.
- It respects P1's compression work: task-level changes live in project files (no SKILL.md bloat), meta-level changes are infrequent and gated.

**Implementation cost within SKILL.md:** ~20-30 lines added to the spec. A new section after Phase 0 describing the dual-level capture, plus modifications to the profile update rules (currently "append-on-event" — extend with lesson extraction).

**Token cost per run:** ~2-5K additional tokens for lesson extraction (reading the run's outcomes, comparing to profile, appending lessons). Negligible relative to a full Explore (~350-550K).

## Self-Score: 3/5

Mid-confidence. The dual-level structure is sound and the mechanisms are concrete. But I am uncertain about three things: (1) whether Claude Code can reliably read/write a global file at `~/.claude/skills/edison/.edison/meta-observations.md` across different invocation contexts, (2) what "3+ projects show the same pattern" means operationally — pattern matching across unstructured lesson text is hard, and (3) the self-referential element (improving how you improve) sounds elegant but may be too abstract to specify concretely in 20-30 lines of markdown. These uncertainties are why this priority is classified as Structural + Conceptual — the structure is clear but the conceptual execution needs R2 scrutiny.
