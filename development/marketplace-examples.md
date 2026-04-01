# Edison Marketplace Submission

## Description

Design decision skill — the phase between brainstorming and building. Edison researches alternatives, weighs tradeoffs, and produces self-executing specs before you write code. Three modes: Check (10-second gate for whether a decision needs exploration), Explore (research-first progressive deepening with parallel agents), and Audit (spec vs code gap analysis). Includes Edison Evolve companion skill that captures improvements and lets users contribute discoveries back to the community.

## Use Cases

**Example 1:** Type `/edison` when you're stuck between approaches. Describe the decision. Edison scores it, sends research agents to scan forums and docs in parallel, then runs three rounds of analysis. Each round challenges the last. Output is a spec with pass/fail requirements that bind to your codebase so implementation agents actually follow it.

**Example 2:** Edison also self-triggers. Start building something that touches several systems and it'll interrupt: "This scores 4/5 on the Check. Want me to research it first?" Say no and it backs off. Say yes and it runs a full exploration. It tells you the estimated token cost before starting.

**Example 3:** `/edison audit` after building. It reads your spec's MUST and VERIFICATION fields, diffs them against the code, and produces a gap list ordered by severity. Contradictions first, then missing pieces, then partial implementations.

**Example 4:** After runs, Edison notices your patterns (you always reprioritize UX over architecture, you skip Round 3 on smaller explorations) and offers to remember them. Separately, if it hits a bug in its own process, it asks whether you'd share the fix with the community.
