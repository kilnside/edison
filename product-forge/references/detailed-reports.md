# Detailed Report Templates

These reports are generated when Product Forge runs with `--detailed` or the user
requests full reports. They go in `.forge/reports/`.

---

## LEARNINGS.md

```markdown
# [Product Name] Project Learnings Report

## Executive Summary
2-3 paragraphs: Most surprising finding. What contradicts conventional wisdom.
What makes this opportunity real.

## Domain Learnings: [Primary Domain]
### [Key Finding 1 — the one that changes how you think about the space]
Evidence, citations, implications for the product.

### [Key Finding 2]
...repeat for each major finding...

## Domain Learnings: Market & Competitors
Who exists, what they do, what they got wrong, where the gap is.

## Domain Learnings: Technical Implementation
What approaches work, what doesn't, key architecture decisions and why.

## Domain Learnings: UX & Positioning
How users should experience this, brand positioning, key UX decisions.

## Pricing & Business Model Learnings
Pricing rationale, revenue model, path to financial independence.

## Key Risks
Numbered list with honest assessment of each.
```

Draw from: Edison RESEARCH-BRIEF.md, R1/R2 analyses, ME validation, and build phase learnings.

---

## META-ANALYSIS.md

```markdown
# Meta-Analysis: [Product Name] Development Session

## Executive Summary
Did it work? Quality assessment. Honest.

## What Was Effective
Name the exact insight, skill, and moment that produced genuine value.

## What Was Ineffective
What wasted time or produced low-quality output? Where did the process break?

## What Would Have Been Better With Human Help
Where did autonomous operation hurt quality?

## Skill Interaction Analysis
### What Worked Well Together
Skills that chained cleanly with output feeding input.
### What Didn't Connect Well
Where context was lost between skills. The seams.
### Gaps In The Skill Ecosystem
Skills needed but didn't exist.

## The Fundamental Question
What did AI do better than a human? What worse? Ideal human/AI split?
```

---

## IMPROVEMENTS.md

```markdown
# How To Improve The Process

## The Big Wins (highest impact)
Numbered. What to change, why, estimated time saved.

## Medium Wins
...

## Small Wins
...

## What To Keep Exactly The Same
What worked. Do not change.

## Session Statistics
- Timeline: table of timestamps
- Agents dispatched / avg duration / failure rate
- Skills used / utilization rate
- Integration bugs found / time to fix
- Estimated token usage
- Estimated cost at published pricing

## Proposed Process For Next Run
ASCII flowchart of the improved pipeline.
```
