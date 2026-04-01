# Edison Project Profile
Generated: 2026-03-28 | Updated: 2026-03-28

## Identity
- **Name:** Edison
- **Domain:** AI skill for design exploration
- **Stack:** Claude Code skill (SKILL.md markdown), no runtime dependencies
- **Maturity:** early (v2 shipped, published on GitHub, first public users)

## Architecture
- **Pattern:** Single-file skill (SKILL.md) + development artifacts
- **Key directories:** / (root: SKILL.md, README.md), development/ (exploration artifacts), development/deep-exploration/ (v2 design process), development/research/ (competitive/user research), .claude-plugin/ (marketplace config)
- **Data layer:** None — Edison is a prompt, not code. State via .edison/profile.md per-project.

## Active Specs
- SKILL.md: The skill itself IS the spec (self-referential — Edison's spec is Edison)

## Established Patterns
- Three-mode architecture: Check → Explore → Audit (SKILL.md)
- Self-executing specs with MUST/MUST NOT/VERIFICATION task blocks (SKILL.md §Explore Phase 7)
- Research-first approach: agents scan landscape before proposing (SKILL.md §Explore Phase 2)
- Per-priority graduation: RESOLVED/CONTESTED/MURKY (SKILL.md §Explore Phase 4)
- Dual-structure deliverables: narrative + embedded task blocks (SKILL.md §Explore Phase 7)

## Inconclusive (needs more data)
- Research hit rate 12/12 in Guidance run — excellent, but only 1 data point. Need cross-domain data to confirm question generation is universally well-calibrated. (Source: Guidance/cannabinoid-personalization, 2026-03-29)

## Edison History
- 2026-03-27 | Mode: explore | Result: v2 complete rewrite — 7 priorities, 3 rounds, self-executing specs, graduated depth
- 2026-03-28 | Mode: explore | Result: v3 complete — 8 priorities, 3 rounds, 3 tensions, 21 agents. Key decisions: spec compression to ~280 lines + resources/, self-improvement externalized to companion skill, AGENTS.md binding, identity stack model, output contract published.
- 2026-03-29 | Mode: explore | Project: Guidance/cannabinoid-personalization (CannaLens) | Result: 9 priorities, 2 rounds (R3 skipped — all resolved). Fully autonomous run. 4 universal discoveries submitted (kilnside/edison#1-4).
- 2026-03-30 | Mode: explore | Project: GlazeLN/annotation-v2 | Result: Fully autonomous. 2 universal discoveries submitted (kilnside/edison#5-6). R2 synthesis pattern identified.
