# Round 1: The Research Engine -- Literal Analysis

**Character: The Engineer.** Find the sensible path.

## The Priority as Understood

Edison's research phase (Phase 2 of Mode 2) is the sole feature that separates it from every other design tool. The claim: AI should bring back intelligence the user didn't have, rather than asking questions. If the research produces generic platitudes ("users want fast load times"), Edison is an expensive questionnaire. If the research produces specific, surprising findings ("potters on r/ceramics overwhelmingly hate glaze calculators that hide unity formula behind paywalls -- 47 threads in 2 years"), Edison earns its token cost.

The tension is real: web search quality varies, 5 parallel agents are expensive before any design work starts, and the current spec gives each agent a broad mission ("search Reddit, forums, Hacker News") without guidance on what makes a finding actionable versus decorative.

## Three Implementation Approaches

### Approach A: Targeted Query Decomposition (Recommended)

Instead of 5 agents with broad mandates, decompose the research into **specific, falsifiable questions** derived from the vision document. After Phase 1 (Vision Capture), the system generates 8-12 concrete research questions like:

- "What do users of [competitor X] complain about most?"
- "What's the standard technical approach for [core feature Y]?"
- "Has anyone built [the thing the user described]? What happened?"

Then launch 3 agents (not 5), each handling 3-4 questions. Each agent's output is structured as: **Question -> Sources Found -> Specific Findings -> Implication for This Project**. The synthesis step becomes mechanical: collate findings, rank by relevance to stated priorities, flag surprises.

**Why 3 agents, not 5:** The subagent ceiling research says 3-4 parallel is recommended. Five agents with broad mandates produce overlap (User Pain and User Expectations will search the same forums). Three agents with specific questions produce distinct, non-overlapping research.

**Why questions, not missions:** "Search Reddit for user pain" is an open-ended instruction that invites generic summaries. "Find what users of Glazy.org complain about in r/ceramics and r/pottery" is a specific instruction that produces specific findings. The vision document contains enough information to generate targeted queries -- it names the space, the competitors, and the user type.

### Approach B: Two-Pass Research (Broad then Deep)

First pass: 2 agents do broad landscape scanning (competitive landscape + user sentiment). Takes maybe 60 seconds. Second pass: based on what the broad scan finds, generate targeted deep-dive queries and launch 2-3 more agents on the most promising threads. This adapts to what's actually out there rather than guessing what to search for.

**Advantage:** Adapts to reality. If the competitive landscape is barren, the second pass can redirect toward adjacent domains instead of wasting agents on empty searches.

**Disadvantage:** Sequential. The two-pass structure adds wall-clock time. Users abandon black-box processes after ~10 minutes, and this approach front-loads the waiting.

### Approach C: Research Mission Templates (Current Spec, Refined)

Keep the 5-agent structure but make each agent's mission far more specific by providing templates that include: exact search query patterns, required output fields, minimum source count (3+), and a "this matters because" section that must reference the vision document. Essentially, take the current spec and add rigor.

**Advantage:** Minimal change from current spec. Easy to implement.

**Disadvantage:** Still 5 agents with inherent overlap. Still broad mandates. Templates help quality but don't solve the "generic findings" problem at its root.

## Recommended Path: Approach A (Targeted Query Decomposition)

**Rationale:**

1. **Specificity drives quality.** The single biggest risk to research quality is vague instructions. "Find user pain" produces summaries. "Find what users of [X] say about [Y] on [Z]" produces evidence. Generating targeted questions from the vision document is a cheap intermediate step (one LLM call) that dramatically improves downstream quality.

2. **3 agents is the right number.** The research says 3-4 parallel subagents is the ceiling. Five agents with broad mandates will produce overlapping searches and redundant findings. Three agents with distinct question sets produce non-overlapping intelligence.

3. **Falsifiable questions create accountability.** When an agent's mission is "answer these 3 questions with sources," the synthesis step can assess: did it find real sources? Are the findings specific or generic? Does the "implication" actually connect to the project? This is harder to assess when the mission is "explore user pain."

4. **The question generation step is cheap and high-leverage.** One LLM call to turn the vision document into 8-12 specific research questions costs maybe 2K tokens. The improvement in research quality is disproportionate.

**Concrete structure:**

```
Phase 1: Vision Capture (existing)
     |
Phase 1.5: Query Generation (NEW, ~5 seconds)
  - Input: Vision document
  - Output: 8-12 specific, searchable research questions
  - Grouped into 3 non-overlapping clusters
     |
Phase 2: Research Execution (3 parallel agents)
  - Each agent gets 3-4 questions
  - Each question answered with: sources, findings, project implication
  - Minimum 2 real sources per question (or explicit "nothing found")
     |
Phase 2.5: Research Synthesis (existing, but now mechanical)
  - Collate findings by relevance to vision
  - Rank by surprise value (findings the user likely already knew get deprioritized)
  - Flag contradictions between findings and vision
```

**Quality guardrails:**

- Each finding must cite at least one specific source (URL, forum thread, product name)
- "Nothing found" is a valid and valuable answer -- it means the space is truly unexplored
- Findings are scored by surprise value: did this tell us something we couldn't have guessed?
- The synthesis explicitly separates "confirms what we expected" from "changes what we should build"

**What this costs:** Roughly 150-200K tokens for research (down from the implied 250K+ of 5 broad agents), with higher signal-to-noise ratio. The question generation step adds ~5 seconds and ~2K tokens.

## Self-Score: 4/5

This recommendation serves the vision well. It preserves Edison's core differentiator (primary research before design) while making it more reliable and slightly cheaper. The question decomposition step is a direct response to the "generic findings" risk. The reduction from 5 to 3 agents is research-backed.

I score it 4 not 5 because this is the conservative path. It optimizes the existing concept rather than reimagining it. A Round 2 or Round 3 agent might find something more ambitious -- like having research agents actually test competitor products rather than just reading about them, or having the research phase produce a "contrarian brief" that deliberately argues against the user's vision. The sensible path leaves room for those ideas to improve it.
