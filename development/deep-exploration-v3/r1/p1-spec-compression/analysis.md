# P1: Spec Compression — R1 Analysis

## Priority Understood

Edison's SKILL.md is 730 lines. The Agent Skills standard recommends body under 500 lines, with supplementary material in `resources/`. Edison exceeds this by 46%. Every token in SKILL.md is loaded into context on every invocation — including deep Explore phase instructions that only matter during a full exploration run. This bloats context for users who just want a quick Check or an Audit, and hurts discoverability in a multi-skill environment where context budget pressure is real.

## Approach 1: Extract Execution Details, Keep Dispatch Inline

Move the detailed phase-by-phase instructions for Explore (phases 1-8, ~350 lines) and the detailed Audit process (~80 lines) into `resources/explore-phases.md` and `resources/audit-process.md`. The body retains: frontmatter, routing, the Check, Phase 0 summary, a compressed Explore overview (mode description + phase names + key gates), a compressed Audit overview (when to use + high-level steps), key principles, and scaling/relationships.

**Estimated body:** ~310-350 lines. Well under 500.

**Mechanism:** SKILL.md includes directives like "When running Explore, read `resources/explore-phases.md` for detailed phase instructions." Claude Code agents can be instructed to read files on demand — this is exactly how the Agent Skills progressive disclosure model works.

**Risk:** If Claude Code fails to read the resource file (path resolution, missing file after partial install), the agent would have routing but not execution detail. Mitigation: the body includes enough of a skeleton (phase names, gates, key constraints) that a capable agent could approximate the behavior even without the resource file.

## Approach 2: Aggressive Prose Compression, No Structural Change

Rewrite every section to be terser. Remove examples, collapse tables into inline lists, strip explanatory prose, eliminate redundancy. Many sections use 2-3 sentences where 1 would suffice. The Check's "What to Say" block (lines 119-129) is 11 lines of template text. The Progress Visibility section (lines 375-387) repeats patterns that a capable agent would naturally follow. Cost estimation tables could be compressed.

**Estimated body:** ~450-500 lines. Borderline compliant.

**Risk:** Loses the specificity that makes Edison reliable. Vague instructions produce inconsistent agent behavior — the exact problem P2 (Edge Case Hardening) is trying to solve. Compression through ambiguity is a false economy.

## Approach 3: Hybrid — Extract + Compress

Extract execution details to resources (Approach 1) AND do moderate prose tightening on what remains in the body. Don't strip to telegraphic style, but remove genuine redundancy: the "examples of should/should not trigger" block restates what the self-trigger rules already say; the "How the Profile Feeds Each Phase" section is explanatory rationale that aids understanding but isn't operational; the Key Principles section largely restates what the modes already enforce.

**Estimated body:** ~250-300 lines. Significant headroom for future additions (P3 self-improvement, P6 binding portability).

**Risk:** Over-compression removes the "why" that helps agents make judgment calls in ambiguous situations. Mitigation: keep the "why" in resources alongside the "how," so it's available when the agent is actually executing that mode.

## Recommendation: Approach 3 (Hybrid)

Approach 1 alone gets under 500 but leaves the body verbose for what it contains. Approach 2 alone risks the 500-line boundary and sacrifices clarity. The hybrid gives the best of both: a crisp dispatch layer in the body (~280 lines) with full execution detail preserved in resources.

The key insight is that SKILL.md serves two audiences at two times:
1. **Every invocation:** Which mode? Should I even run? (Routing + Check + Phase 0 detection)
2. **Specific mode runs:** How exactly do I execute this? (Explore phases, Audit steps, lenses, review gates)

Only audience 1 needs to be in the body. Audience 2 content loads on demand.

This also creates a clean separation that benefits P3 (self-improvement): the stable dispatch layer changes rarely, while execution details in resources can evolve independently.

## Self-Score: 4/5

High confidence this is the right structural approach. Docking one point because the exact line counts depend on how aggressively prose is tightened, and because the resource-loading mechanism needs validation (does Claude Code reliably read skill resource files mid-execution? The Agent Skills spec says yes, but I haven't verified Edison's install path handles it).
