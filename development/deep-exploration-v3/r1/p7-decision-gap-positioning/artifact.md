# P7 Artifact: Proposed Positioning Update

## Proposed Skill Frontmatter

```yaml
---
name: edison
description: >
  Design decision skill — the phase between brainstorming and building. Research-first,
  progressively-deepening analysis that explores alternatives before you commit. (1) Check —
  5-question decision gate before coding. (2) Explore — multi-round deep dive with parallel
  research agents, from practical to creative to wild. (3) Audit — compare an existing spec
  against the codebase to find drift. Triggers on: /iterate, /edison, /deep-dive, /audit,
  "explore all the options", "are we missing anything?", "what happened to the spec?", or any
  situation where a design decision needs research before code. Also self-triggers before
  implementing interconnected, unexplored, or brand-sensitive features. Do NOT use for simple
  bug fixes, typos, or config changes.
---
```

Key changes from current:
- "Design exploration skill" → "Design decision skill"
- Added "the phase between brainstorming and building" — names the gap
- "research-first" moved earlier in the description
- "explores alternatives before you commit" — action-oriented, echoes the Edison metaphor
- "parallel research agents" — names the differentiating capability
- "design decisions need validation" → "design decision needs research" — research framing

## Proposed Marketplace Description

```json
{
  "description": "Design decision skill — the phase between brainstorming and building. Research-first, progressively-deepening analysis for exploring alternatives before you commit."
}
```

## Proposed Positioning Statement

For GitHub, awesome lists, and the plugin marketplace:

> **Edison is the design decision phase that AI skipped.** Brainstorming tools help you diverge. Code generation tools help you converge. Nothing helps you actually decide — weigh tradeoffs, research alternatives, understand consequences. Edison fills that gap. It dispatches parallel research agents, runs progressively-deepening rounds of analysis (from practical to creative to wild), and produces a self-executing spec with built-in verification. Named after Edison's 1,000 filament materials: systematic research before commitment produces results that "just build it" never could.

## Proposed README Tagline

Current:
> **Get design decisions right before writing code.**

Proposed:
> **The design decision phase that AI skipped.**

Alternative (less provocative):
> **Systematic research before commitment — the missing phase between brainstorming and building.**

## Proposed Check Language

Current output when Check fires:
> "Before I build [feature], this [scores on questions X, Y]. I think exploration would save us from building the wrong thing."

Proposed:
> "Before I build [feature], there's a design decision here [scores on X, Y]. I think researching this first would save us from building the wrong thing."

The word "exploration" becomes "researching" — grounding the value proposition in capability, not process.
