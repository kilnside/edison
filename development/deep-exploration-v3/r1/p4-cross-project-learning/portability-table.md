# P4 Artifact: What Edison Learns vs. How It Ports

| What Edison Learns (per project) | Portable? | Proposed Mechanism |
|---|---|---|
| **Project identity** (name, domain, maturity) | No | Stays in `.edison/profile.md`. Too project-specific. |
| **Stack fingerprint** (framework, language, DB, deploy target) | Partially | Stack string written to `developer.md` Stack Playbook as a key. New projects with matching stack get relevant priors. |
| **Architecture pattern** (monolith, monorepo, microservices) | No | Project-specific. Not useful as a prior for a different project. |
| **Established code patterns** (hook conventions, data access) | No | Tied to specific directory structures and file paths. |
| **Active specs and their coverage** | No | Project-local. Specs reference project-specific components. |
| **Edison run history** (dates, modes, outcomes) | Partially | Aggregate stats (how often Check escalates to Explore, avg priorities per run) written to `developer.md` Preferences. Project-specific entries stay local. |
| **Check scores and escalation decisions** | Partially | The pattern of when the user overrides Edison's recommendation is portable. Written to `developer.md` Preferences as "override rate" and "preferred depth." |
| **Vision documents** | No | Project- and feature-specific. Not transferable. |
| **Research findings** (competitor analysis, technical patterns) | Partially | Stack-specific findings (e.g., "Supabase realtime has X limitation") written to Stack Playbook keyed by stack. Domain-specific findings (e.g., "recipe apps need X") are not portable. |
| **Research questions that yielded nothing** | Yes | Written to `developer.md` Edge Case Log. Prevents re-asking dead-end questions on similar projects. |
| **Priority classifications** (structural/tradeoff/conceptual) | Yes | Accuracy of classification (did the artifact type match the need?) feeds into `developer.md` Pattern Library. Improves future classification. |
| **R1 recommended paths and self-scores** | No | Too tied to specific priorities and project context. |
| **Tradeoff resolutions** (X vs Y, chose X because Z) | Partially | If the tradeoff is stack-level (e.g., "server components vs client components for auth flows"), written to Stack Playbook. If project-specific, stays local. |
| **Unchallenged assumptions from rounds** | Yes | Common unchallenged assumptions across projects written to `developer.md` Pattern Library. Helps future rounds challenge them earlier. |
| **R2 assumption verdicts** (confirmed/overturned/refined) | Yes | Verdicts on recurring assumptions are highly portable. Written to Pattern Library with "confirmed N times / overturned N times" counts. |
| **R3 tension kernels** | Partially | The kernel insight (abstracted from project specifics) can be portable. E.g., "security and developer experience are always in tension for auth" is reusable. Specific resolution is not. |
| **Fallback clause triggers** (P2 edge cases that fired) | Yes | Written to `developer.md` Edge Case Log with frequency counts. Feeds P3 self-improvement to promote frequently-triggered fallbacks. |
| **DEFINITIVE-SPEC.md** | No | Entirely project-specific. |
| **CLAUDE.md bindings** | No | Path-based, project-specific. |
| **Deviation records** (spec vs actual) | Partially | The *category* of deviation (e.g., "scope reduction during implementation") is portable as a pattern. The specific deviation is not. |
| **Audit gap analysis** | No | References specific components and file paths. |
| **User correction patterns** | Yes | When the user says "actually we migrated away from that" during Phase 0, the type of correction (stale assumption, wrong inference, outdated pattern) is portable. Written to Preferences. |
| **Exploration depth chosen vs. depth needed** | Yes | If the user consistently chooses Focused but the exploration needed Full, or vice versa, this calibrates future cost estimates. Written to Preferences. |

## Summary

Of ~22 categories of knowledge Edison generates per project:

- **6 fully portable** (research dead-ends, classification accuracy, assumption verdicts, fallback triggers, user corrections, depth calibration)
- **7 partially portable** (stack fingerprint, run history, check patterns, research findings, tradeoff resolutions, tension kernels, deviation categories)
- **9 not portable** (identity, architecture, code patterns, specs, visions, R1 paths, definitive specs, bindings, gap analyses)

The developer profile at `~/.claude/edison/developer.md` captures the 6 fully portable and the portable subset of the 7 partial categories. Everything else stays in `.edison/profile.md` where it belongs.
