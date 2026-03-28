# P3: Self-Improvement Loop — Unchallenged Assumptions

1. **Edison runs often enough to generate useful data.** The entire mechanism assumes repeated runs across multiple projects. If a user runs Edison twice and moves on, the evolution log has two entries and the meta-observation graduation threshold (3+ projects) is never reached. The cold start problem may be worse than assumed.

2. **Lessons extracted from one run generalize.** "Research questions about authentication return nothing in this codebase" might be a codebase-specific fact, not a transferable lesson. The task-level vs. meta-level split assumes we can distinguish local quirks from universal patterns. That distinction might be harder than it looks.

3. **Claude Code can write to global paths reliably.** The meta-observations file lives at `~/.claude/skills/edison/.edison/meta-observations.md`. This assumes Claude Code has write access to its own skill directory across all invocation contexts (direct CLI, subagent, background). Untested.

4. **Users want Edison to evolve.** The vision says "the tool is getting smarter with every run." But some users may prefer a stable, predictable tool. A self-improving skill might feel unreliable — "why did it behave differently this time?" The assumption is that improvement is always welcome. It might not be.

5. **Self-assessment is possible.** All three approaches assume Edison can meaningfully evaluate its own performance (research hit rate, priority resolution speed, user override frequency). But these are proxy metrics. The real measure — "did the user build the right thing?" — is not observable by Edison. We are optimizing for what we can measure, not what matters.

6. **The improvement loop needs to be in the spec.** An alternative: Edison's improvement loop could live entirely outside SKILL.md — as a separate skill or workflow that periodically reviews Edison runs and proposes changes. Embedding it in SKILL.md assumes the loop must be part of Edison's identity, not a companion tool.

7. **Dual-level is the right granularity.** PromptBreeder uses dual-level (task + mutation). But Edison might need three levels: per-run (what happened), per-project (local patterns), and cross-project (global patterns). Or it might need only one (just accumulate observations). The two-level split mirrors PromptBreeder but may not mirror Edison's actual needs.

8. **Human gating is sufficient oversight.** The recommended approach presents diffs for human review. But if the diff is subtle (changing a threshold from 2 to 3, rewording a trigger condition), a human might approve without fully understanding the downstream consequences. Human oversight is necessary but may not be sufficient — the spec might also need automated regression checks.
