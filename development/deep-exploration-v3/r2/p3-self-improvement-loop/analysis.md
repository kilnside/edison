# P3: Self-Improvement Loop -- R2 Analysis

**Lens:** The Economist -- What does this cost to maintain, migrate, or reverse?
**Priority type:** Structural (primary) / Conceptual (secondary)

---

## Assumption Verdicts

### #1: Edison runs often enough to generate useful self-improvement data

**Verdict: REFINED.** R1 assumes frequency drives value. The economic question is different: what is the *minimum viable sample* for each feedback tier?

- **Task-level** (profile lessons): Useful from run 1. "User reordered priorities" is actionable after a single observation. No frequency problem here.
- **Meta-level** (cross-project graduation): The 3-project threshold is arbitrary and *expensive to reach*. At one user running Edison perhaps weekly across 2-3 active projects, graduation takes months. During those months, the mechanism exists but produces nothing. That is carrying cost with zero return.
- **Spec mutations:** Require meta-observations, which require graduation, which require frequency. This is a three-stage pipeline where stage 1 (capture) works immediately but stage 3 (mutation) may never fire.

The fix is not to lower the threshold -- it is to decouple value from the pipeline's final stage. Task-level adaptation is the immediate ROI. Meta-level is speculative investment. The spec should treat them with proportional weight: 80% of the mechanism's spec lines on task-level, 20% on meta-level. R1 gave them roughly equal weight.

### #3: Can the self-referential element be specified concretely in ~20-30 lines?

**Verdict: OVERTURNED.** The PromptBreeder-inspired "improving how you improve" cannot be specified concretely in markdown. Here is why:

PromptBreeder works because it has a fitness function (task performance on a benchmark) and a mutation operator (LLM-generated prompt rewrites evaluated against that benchmark). Edison has neither. The "fitness function" is a bundle of proxy metrics (research hit rate, resolution round, user overrides) with no ground truth. The "mutation operator" is "Edison reads meta-observations and proposes a diff" -- but what makes one diff better than another? The self-referential claim collapses into "Edison sometimes suggests changes to itself, and a human decides." That is not Level 4 self-evolution. That is Level 2.5: automated suggestion with manual approval.

This is not a failure -- it is an honest assessment. Claiming PromptBreeder-level self-reference in a markdown spec is aspirational branding, not engineering. The spec should describe what it actually does: structured capture + periodic human-reviewed proposals. Drop the self-referential framing. It costs credibility and delivers nothing concrete.

### #7: Proxy metrics actually correlate with quality

**Verdict: REFINED.** R1 proposed three proxy families: process outcomes (resolution round, research hit rate), user signals (overrides, corrections), and audit results (gap percentages). The economic analysis:

- **User signals are gold.** Every override is direct evidence of a mismatch between Edison's model and the user's intent. Cost to capture: near zero (the events already happen). Signal quality: high. This is the best ROI metric.
- **Process outcomes are noisy.** A priority resolving in R1 might mean the spec was clear, or it might mean the R1 agent was overconfident. Research hit rate depends on question quality AND topic searchability -- a "nothing found" result on a novel domain is not a failure. Cost to compute: low. Signal quality: medium-low.
- **Audit results are lagging.** By the time an audit reveals spec-code gaps, the useful feedback window has closed. Cost: moderate (requires a full audit run). Signal quality: medium, but delayed.

The economic verdict: invest in capturing user signals aggressively (they are cheap and high-signal), capture process outcomes passively (they are cheap but noisy), and treat audit results as validation rather than training data.

---

## Structured Diff Against R1

### What STAYS

1. **Task-level adaptation in .edison/profile.md.** Sound economics. Immediate value, low cost (~2-5K tokens), no cold start problem. The Lessons section is the highest-ROI element of the entire proposal.
2. **Human gating for spec mutations.** Non-negotiable. An auto-evolving prompt is an unauditable prompt.
3. **Failure memory for rejected proposals.** Cheap to maintain, prevents wasted cycles. Good engineering.
4. **Fallback-trigger capture from P2.** The instrumentation is already being built. Connecting it to the improvement loop is free marginal value.

### What CHANGES

1. **Drop the PromptBreeder framing.** Call it what it is: structured learning with human review. The "Level 4 self-evolving spec" claim should become "Level 3: assisted evolution." The distinction matters because Level 4 implies autonomy that does not exist.

2. **Reduce meta-observations to a lightweight appendix, not a co-equal tier.** R1 gave meta-level and task-level equal architectural weight. The economics say: task-level delivers value on day 1; meta-level delivers value on month 6 (optimistically). Spec allocation should reflect this. Meta-observations get 5 lines, not 15.

3. **Replace the 3-project graduation threshold with user-triggered promotion.** The automated graduation mechanism ("same lesson in 3+ profiles") requires cross-project pattern matching on unstructured text -- an unreliable operation that adds complexity. Instead: the `/edison evolve` command reads ALL project profiles and presents candidate patterns. The human decides what graduates. This is simpler, more reliable, and respects the economic reality that the human is reviewing anyway.

4. **Prioritize user signals over process metrics in capture.** The event log should weight user overrides and corrections above resolution-round statistics. Concretely: user signals get structured fields in the log entry; process metrics get a summary line.

5. **Add a cost ceiling.** R1 estimated ~2-5K tokens per run for capture. That estimate should be in the spec as a hard ceiling with a fallback: "If lesson extraction would exceed 5K tokens, append raw event data and defer extraction to next run." This prevents the improvement mechanism from becoming a token sink on complex runs.

### What is NEW (gaps within gaps)

1. **Reversal cost is unaddressed.** What happens if a task-level lesson is wrong? "User always reorders UX priorities above technical" might be true for one project phase and false for the next. Lessons need expiry or confidence decay. R1 has no mechanism for un-learning. The Economist's question: what does it cost to reverse a lesson that has been silently shaping Edison's behavior for 3 months? If lessons lack timestamps and confidence, the answer is "you cannot even find it."

2. **Migration cost between Edison versions is undefined.** P5 resolved SemVer + Changelog. But if Edison evolves task-level lessons per-project, a SKILL.md upgrade might invalidate existing profile lessons (the lesson references a phase that was renamed, a metric that was removed). The upgrade path for `.edison/profile.md` is unspecified. This is a P3-P5 seam that neither priority addressed.

3. **The meta-observations file has no size governance.** R1's unchallenged assumption #6 flagged this. The economic question is sharper: meta-observations are read on every `/edison evolve` invocation. If they grow to 50 entries across 2 years of use, that is ~10K tokens of context consumed before Edison even starts proposing changes. Add a cap (20 active observations) with archival for older entries.

---

## Cross-Pollination

### From P5 (Versioning)

P5 flagged that SemVer may not suit a self-evolving document. The R2 verdict sharpens this: if Edison's task-level lessons cause it to behave differently across projects WITHOUT a version change, then version is not the right abstraction for behavior identity. The solution: version tracks the SKILL.md spec. Behavior variance from task-level lessons is explicitly *out of scope* for versioning -- it is personalization, not evolution. This distinction must be stated in the spec to prevent confusion.

CalVer remains worth considering for the meta-level mutations specifically. When a human approves a SKILL.md change from `/edison evolve`, the version could be `2026.03.28` rather than `2.1.0`. Date-stamped versions are more honest for changes driven by accumulated experience rather than planned features.

### From P2 (Hardening)

P2 established that the spec is optimistic-path only. The self-improvement mechanism inherits this flaw. R1 describes the happy path (capture -> learn -> graduate -> propose -> approve). The unhappy paths:

- Capture fails (Claude Code cannot write to `.edison/`): Silent data loss. No fallback.
- Lesson extraction produces garbage (hallucinated pattern): Persists in profile, silently biases future runs.
- `/edison evolve` reads corrupt or outdated meta-observations: Proposes nonsensical mutations.

Each needs a fallback clause. Minimum: "If capture fails, log to console and continue. If lesson extraction confidence is below threshold, store as raw event, do not extract. If meta-observations file is unreadable, skip and notify user."

---

## Kernel Extraction

Even if the dual-level architecture is rejected entirely, the insight that survives is: **user signals (overrides, corrections, rejections) are the only high-confidence, low-cost feedback Edison can collect.** Everything else -- process metrics, resolution speed, research hit rates -- is noise dressed as signal. A self-improvement mechanism built on nothing but "what did the user change?" would outperform one built on every metric R1 proposed.

---

RESEARCH_NEEDED: Can Claude Code reliably write to `~/.claude/skills/edison/` subdirectories during a skill invocation? Specifically: does the skill execution context have filesystem write access to the skill's own install directory, or is it sandboxed to the project directory?
