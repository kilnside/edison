# Edison on Edison: Analysis from 2026-03-27

## What Edison Gets Right

**Divergence before convergence.** Multiple agents with different framings (direct, challenger, provocateur) produce genuinely different solutions. The meta-synthesis picks the best from each. This is real and valuable.

**The self-check is useful.** The 4 questions (interconnected, unexplored, brand-sensitive, spec exists) are a good filter.

## The Failure Modes (Discovered via Kilnside v3)

### 1. Great specs that nobody follows during implementation
The v3 deep dive produced DEFINITIVE-SPEC.md. Then milestones 4-8 were built by parallel agents given task-specific prompts ("build auth", "build animations") without checking the spec. Result: 51% coverage, 4 structural contradictions.

**Root cause:** Phase 8 (Handoff) says "transition to implementation planning" but doesn't specify HOW the spec becomes binding. No mechanism to inject the spec into implementation agents' context.

### 2. Too expensive for most decisions
300-500K tokens for 21 agents is justified for a full product redesign. But the self-check triggers on things like "you're about to create a new component file" -- too sensitive.

### 3. No "audit and realign" mode
Edison assumes you're designing something new. No mode for "we have a spec, we have code, and they've diverged."

### 4. Provocateur quality varies
Round 3's power depends on creative constraints. Good prompts ("What if there's no home page?") produce breakthroughs. Bland prompts produce Round 1 again.

## The Three-Mode Proposal

### Mode 1: Check (keep, tune sensitivity)
5 questions instead of 4. Add "will this output get used?" Lower trigger sensitivity -- fire on design decisions, not every new file.

### Mode 2: Explore (keep for major redesigns)
Same 8-phase process but Phase 8 REQUIRES binding the spec to CLAUDE.md Active Design Specs section + creating a verification checklist.

### Mode 3: Audit (NEW)
Compare spec vs codebase. No new exploration. Gap analysis table. Prioritized punch list. This is what we needed for Kilnside and didn't have.

## The Handoff Problem (The Real Fix)

1. After Edison produces a spec, link it in CLAUDE.md under "Active Design Specs"
2. Every implementation plan starts with "Read [spec] and verify this plan implements it"
3. After each phase, diff the code against the spec

## Revised Trigger Logic

```
Is there a design decision being made?
+-- No -> Just build
+-- Yes -> Does a spec exist?
    +-- Yes -> Does the code match?
    |   +-- Yes -> Build from spec
    |   +-- No -> Mode 3: Audit (then fix)
    +-- No -> How complex?
        +-- Simple (1-2 choices) -> Brainstorm
        +-- Complex (3+) -> Mode 1: Check
            +-- Score 0-1 -> Build
            +-- Score 2+ -> Mode 2: Explore
```

## Reference: V3 Deep Exploration Structure

The original Edison run on Kilnside v3 produced:
- 7 gaps x 3 rounds = 21 agents
- Directory: .superpowers/brainstorm/v3-deep-exploration/
  - gap-1-capture/ through gap-7-share-flow/ (Round 1)
  - r2/ (Round 2)
  - r3/ (Round 3)
  - synthesis/ (Round 1 synthesis)
  - meta-synthesis/ (CONVERGENCE.md, DEFINITIVE-SPEC.md, definitive-mockup.html)
- See case-study-gap-analysis.md for what happened when the spec wasn't followed
