# P1: Proposed SKILL.md Outline (Body vs. Resources)

## SKILL.md Body (~280 lines target)

```
---
frontmatter (name, description, triggers)                    ~10 lines
---

# Edison                                                      ~15 lines
  - Three modes tagline
  - Three core insights (compressed to 3 lines each)

## Routing: Which Mode Do I Need?                             ~35 lines
  - Decision tree (KEEP as-is — this is the dispatch core)
  - Trigger phrases table (KEEP — must be inline for routing)
  - Self-trigger rules (COMPRESS — remove examples block,
    keep rules + hard trigger)

## The Check (10 seconds)                                     ~35 lines
  - 5 questions (COMPRESS — name + signal only, drop headers)
  - Scoring + hard trigger (KEEP)
  - Pre-check contradiction sniff (KEEP — 3 lines)
  - "What to Say" (COMPRESS to 2 lines of template)
  - "When NOT the right tool" (COMPRESS to 1 sentence)

## Phase 0: Project Scan                                      ~30 lines
  - Detection rule (.edison/profile.md check — KEEP)
  - UX rule (parallel, no blocking — KEEP, 2 lines)
  - Tier 1 scan list (KEEP as compact table)
  - Tier 2 mention: "If Explore triggers, also read [list]"
  - Profile format: MOVE to resources/project-profile.md
  - "How Profile Feeds Each Phase": MOVE to resources/
  - Update rules: COMPRESS to 3 lines
  - Greenfield rule: KEEP (2 lines)

## Explore (Overview)                                         ~50 lines
  - "Research-first, progressively-deepening" description
  - Cost estimation table (KEEP — user sees this before commit)
  - Cost presentation template (COMPRESS to 5 lines)
  - Phase list with one-line descriptions:
      Phase 1: Vision Capture — listen, structure, play back
      Phase 2: Research — generate questions, dispatch agents, synthesize
      Phase 3: Priority Identification — 5-10 priorities, classified
      Phase 4: Round 1 — Constraint Satisfaction (Engineer)
      Phase 5: Round 2 — Constraint Challenging (Designer)
      Phase 6: Round 3 — Constraint Removal (Provocateur)
      Phase 7: Final Synthesis — CONVERGENCE.md + DEFINITIVE-SPEC.md
      Phase 7.5: Review Gate — Adversary + New Hire stress-test
      Phase 8: Handoff — present, approve, bind to CLAUDE.md
  - Key rules that apply across all phases:
      - Per-priority graduation (resolved = frozen)
      - Early exit on all-resolved
      - Never block on user input
      - Preserve everything
  - Directive: "Read resources/explore-phases.md for detailed
    phase instructions before executing any Explore phase."

## Audit (Overview)                                           ~25 lines
  - When to use (COMPRESS to 4 bullets)
  - High-level process: find spec -> parse task blocks ->
    check deviations -> gap analysis -> prioritize -> present -> bind
  - Gap levels: None / Partial / Missing / Contradiction (compact)
  - Directive: "Read resources/audit-process.md for detailed
    step-by-step instructions before executing an Audit."

## Key Principles                                             ~20 lines
  - COMPRESS: merge redundant principles, cut to 6 lines
  - Research before opinions, progressive deepening,
    specs must be self-executing, spare no expense,
    preserve everything, user is always right

## Scaling                                                    ~10 lines
  - Table (KEEP — compact and useful)

## Anti-Patterns                                              ~10 lines
  - COMPRESS: 6 most important, one line each

## Relationship to Other Skills                               ~5 lines
  - COMPRESS to 4 one-liners

TOTAL BODY: ~245-280 lines
```

---

## resources/ Directory

### resources/explore-phases.md (~400 lines)

Full execution detail for each Explore phase:
- Phase 1: Vision Capture — full field list, gate description
- Phase 2: Research — question generation rules, coverage check,
  dispatch mechanics, synthesis format (RESEARCH-BRIEF.md)
- Phase 3: Priority Identification — classification types,
  dependency notation, gate
- Phase 4: Round 1 — agent briefing format, artifact selection
  by classification, R1 synthesis format, graduation criteria
- Phase 5: Round 2 — analytical lenses table, trigger questions,
  assignment heuristic, on-demand research protocol, R2 synthesis
- Phase 6: Round 3 — tension-based (not priority-based),
  kernel extraction requirement
- Phase 7: Final Synthesis — CONVERGENCE.md format,
  DEFINITIVE-SPEC.md dual-structure (narrative + task blocks),
  definitive artifact
- Phase 7.5: Review Gate — Adversary + New Hire specifications,
  skip condition
- Phase 8: Handoff — present/approve/bind steps,
  CLAUDE.md integration format, directory structure
- Progress Visibility — streaming, living summary,
  welcome-back, checkpoint table, completion block

### resources/audit-process.md (~100 lines)

Full step-by-step Audit execution:
- Step 1: Find the Spec (using profile, fallbacks)
- Step 2: Parse Task Blocks (format specification)
- Step 3: Check Deviations (DEVIATIONS.md handling)
- Step 4: Gap Analysis (full table format, gap levels)
- Step 5: Prioritize (5-tier priority list)
- Step 6: Present (scoreboard format)
- Step 7: Bind Updates (verification, spec updates, profile updates)

### resources/project-profile.md (~50 lines)

- Full profile template format
- "How Profile Feeds Each Phase" explanatory section
- Detailed update rules (append-on-event triggers)

---

## What This Achieves

| Metric | Current | Proposed |
|--------|---------|----------|
| SKILL.md body | 730 lines | ~270 lines |
| Under 500-line target | No (46% over) | Yes (46% under) |
| Total content | 730 lines | ~820 lines (body + resources) |
| Content lost | N/A | None — relocated, not deleted |
| Headroom for P3/P5/P6 | None | ~230 lines |

The body is a complete, functional dispatch layer. An agent reading only
SKILL.md can route correctly, run the Check, detect first-run, and
understand what each mode does. Detailed execution instructions load on
demand when a specific mode is actually triggered.
