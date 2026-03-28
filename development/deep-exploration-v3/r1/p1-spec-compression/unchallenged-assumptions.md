# P1: Unchallenged Assumptions

1. **Claude Code will reliably read resource files when instructed.** The Agent Skills spec describes a `resources/` directory with on-demand loading, but I haven't verified that Claude Code's skill loader actually resolves relative paths from SKILL.md to sibling resource files during execution. If the loader only reads SKILL.md and ignores everything else, extraction is useless.

2. **The 500-line recommendation is the right target.** I took the Agent Skills standard at face value. It's possible that Edison is a legitimately complex skill that justifies exceeding the guideline — the standard may not have anticipated multi-mode skills of this scope. The "mega-skill anti-pattern" warning could apply, or Edison could be the exception that proves the rule.

3. **Context budget pressure is a real problem for Edison's users.** I assumed users install multiple skills and that Edison's 730 lines meaningfully hurts. If most Edison users only have 2-3 skills installed, the pressure may be negligible and compression is cosmetic.

4. **Prose tightening won't degrade agent behavior.** I assumed that a sufficiently capable model can infer intent from compressed instructions. But Edison's detailed prose may exist precisely because earlier testing showed agents need that specificity. Removing it could reintroduce failure modes that the verbose version solved.

5. **The body/resources split maps cleanly to dispatch/execution.** I assumed a clean two-audience model. In practice, some execution details (like the Check's hard trigger rule, or Phase 0's caching behavior) straddle both categories. The split may be messier than the analysis suggests.

6. **Resource files have no discovery cost.** I assumed reading a resource file mid-execution is essentially free. But it's an additional tool call, adds latency, and if the agent forgets to read it (or reads it too late), behavior degrades silently.
