# Edison Priorities

7 key functionalities Edison's design hinges on, ordered by criticality.

---

## Priority 1: The Research Engine
**Why it's critical:** This is Edison's sole competitive differentiator. No other tool does primary research before designing. If the research phase produces generic or unreliable findings, Edison is just an expensive questionnaire.
**Research signal:** Every competitive analysis confirms this gap. User pain research shows "no research capability" as a top frustration.
**Tension:** Research quality depends on web search quality, which varies. Token cost of 5 parallel research agents is substantial before any design work even starts.

## Priority 2: Progressive Round Architecture
**Why it's critical:** The three-round structure (Literal → Creative → Wild) is the mechanism that produces genuinely different solutions. If rounds don't build meaningfully on each other, it's just three independent passes with extra cost.
**Research signal:** PLOS ONE study validates deepening over parallel exploration. A-HMAD confirms heterogeneous agents outperform homogeneous by 3.5%. Persona research shows Round 1 needs minimal framing (accuracy) while Round 3 needs strong creative constraints.
**Tension:** Iterative debate has diminishing returns (+0.006 F1 for 2x cost). The rounds must have genuinely distinct missions, not just different personas.

## Priority 3: Progress Visibility
**Why it's critical:** Users abandon black-box processes after ~10 minutes. Edison runs take 20-40 minutes. Without visible progress and intermediate value delivery, users will cancel mid-exploration.
**Research signal:** Attention span research (9.8 minutes average task focus). METR finding that developers believe they're faster with AI even when slower — perception management matters.
**Tension:** The vision says "spare no expense" but the research says users won't wait for a black box. These aren't contradictory — the solution is progressive value delivery, not speed.

## Priority 4: The Handoff Mechanism
**Why it's critical:** This is where Edison v1 failed. The Kilnside case study (51% spec coverage) proves that a brilliant spec with no binding is worse than no spec. The handoff must make the spec impossible to ignore during implementation.
**Research signal:** Spec drift is the #2 user pain point. Research recommends per-component contracts over monolithic specs. Augment Intent's "living spec" is the closest competitor approach. Machine-readable assertions could enable automated drift detection.
**Tension:** Current approach (link in CLAUDE.md + checklist) is simple and reliable. Per-component decomposition is more robust but more complex. How far to go?

## Priority 5: The Gate (Mode 1 Check)
**Why it's critical:** Token cost is a real psychological barrier (85% of companies miss AI spend forecasts). Mode 1 must be genuinely cheap and genuinely effective at filtering — escalating only when the exploration would actually save net tokens. If the gate is too sensitive, Edison burns tokens on simple decisions. Too insensitive, and it misses decisions that needed exploration.
**Research signal:** Rate limit complaints are the #1 Claude Code frustration. Developers actively tune "cost vs quality" per task. The gate is what makes the expensive explore acceptable.
**Tension:** The 5-question self-check is simple but subjective. Could it be more data-driven?

## Priority 6: Synthesis Quality
**Why it's critical:** Synthesis is where progressive deepening pays off — picking the best answer per-priority across all rounds. If synthesis is just "summarize everything," the three rounds add cost without value. Synthesis must make genuine judgment calls.
**Research signal:** A-HMAD shows "learned consensus improves final accuracy by 5% when agents disagree." First-round disagreement captures most value. The per-priority synthesis model (not per-round) is the right architecture.
**Tension:** How opinionated should synthesis be? The user wants a definitive spec, not a menu of options. But some priorities genuinely have no clear winner.

## Priority 7: Mockup vs. Spec Balance
**Why it's critical:** The current skill requires every agent to produce an interactive HTML mockup. Research shows developers prefer text-based specs over visual artifacts. For architectural priorities (data model, API design, state management), a mockup is meaningless overhead.
**Research signal:** "Developers prefer text-based syntax" over visual artifacts. Specs beat mockups beat code scaffolds in developer preference.
**Tension:** The vision says "prototypes over prose" — but the research contradicts this for non-visual priorities. The answer may be: mockups for UX priorities, specs for architectural ones.
