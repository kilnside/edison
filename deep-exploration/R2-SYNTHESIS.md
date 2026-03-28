# Round 2 Synthesis: The Designer's Verdict

All 7 Round 2 agents reported. Average self-score: 4.0/5. Round 2 found genuine gaps in Round 1 across every priority.

---

## Per-Priority Checkpoint (Updated)

| # | Priority | R1 Best | R2 Change | Confidence | Status |
|---|----------|---------|-----------|------------|--------|
| 1 | Research Engine | Targeted query decomposition, 3 agents | Add on-demand research protocol + adaptive agent sizing (1-5) + contradiction detection | High | RESOLVED — mechanism clear |
| 2 | Round Architecture | Mechanical constraints per round | Per-priority graduation (RESOLVED/CONTESTED/MURKY) + tension-based R3 | High | RESOLVED — major refinement |
| 3 | Progress Visibility | Stream-first progressive delivery | Add living summary block + welcome-back moment + completion notification | High | RESOLVED — async gap filled |
| 4 | Handoff Mechanism | 4 artifacts (spec + contracts + checklist + CLAUDE.md) | Add DEVIATIONS.md + dual-format contracts (narrative + MUST/VERIFY) + path-based CLAUDE.md triggers + cross-cutting dependency graph | High | CONTESTED — 5 artifacts is getting complex |
| 5 | Gate (Mode 1) | Weighted scoring, 5 questions | Drop weights, unweighted 2-of-5 + hard trigger combo. Rename Q3→"Opinionated?", Q5→"Multi-stakeholder?" | Medium | CONTESTED — R1 and R2 disagree on weights |
| 6 | Synthesis Quality | Classify priorities, weight rounds, always pick one | Add declared dependencies on external assumptions + unified classification (primary+secondary) across P2/P6/P7 | High | RESOLVED — unified model |
| 7 | Mockup vs Spec | Conditional artifacts by priority type | Verification-driven selection (eyes vs code inspection) + agent chooses artifact type + decomposition for handoff | High | RESOLVED — stronger heuristic |

---

## Key Round 2 Innovations (What R1 Missed)

### 1. On-Demand Research (P1)
Research isn't just upfront — priority agents can emit `RESEARCH_NEEDED` signals for targeted questions that emerge during exploration. Lightweight single-question agents. Key constraint: on-demand must be narrower than upfront.

### 2. Per-Priority Graduation (P2)
Not every priority needs all 3 rounds. After each round: RESOLVED (freeze), CONTESTED (continue), MURKY (continue). Only unresolved priorities advance. Saves tokens, increases focus.

### 3. Tension-Based Round 3 (P2)
Instead of assigned inversions per-priority, R3 agents each tackle a *tension between two priorities* from R2. Fewer agents, harder problems, more genuine creativity.

### 4. Living Summary + Welcome Back (P3)
A persistent "story so far" block that gets rewritten (not appended). When user returns after absence, brief catchup. Progress is narrative, not loading bar.

### 5. Dual-Format Contracts + DEVIATIONS.md (P4)
Contracts have narrative (why) + structured MUST/MUST NOT/VERIFY (what). Cross-cutting concerns get `depends_on` fields. New DEVIATIONS.md tracks intentional spec divergences during implementation.

### 6. Path-Based CLAUDE.md Triggers (P4)
Instead of passive "see these files" links, CLAUDE.md says: "When working on files in src/auth/**, read contracts/auth.md FIRST." Automatic context injection.

### 7. Decisions with Declared Dependencies (P6)
Not just "pick one + reversal trigger" but "pick one + declare the external assumption it depends on." Load-bearing assumptions become first-class outputs.

### 8. Unified Priority Classification (P6)
One classification (primary+secondary type) done once, consumed by synthesis (round weighting), artifacts (format selection), and handoff (contract shape). One record, three consumers.

### 9. Verification-Driven Artifact Selection (P7)
Don't ask "is this visual?" — ask "how will you check if the implementation matches?" Eyes = mockup. Code inspection = spec. Stronger heuristic that handles edge cases.

---

## Assumptions Validated by Round 2

- ✅ Round 1's core mechanisms are sound (targeted queries, mechanical round differentiation, stream-first delivery, per-component contracts, contradiction sniff)
- ✅ The 5 questions are mostly right (Interconnected and Irreversible are the heavy hitters)
- ✅ Synthesis should always pick one answer (but with declared dependencies)
- ✅ Three rounds is the right default (but per-priority graduation means not all priorities use all three)

## Assumptions Overturned by Round 2

- ❌ Research happens only upfront → on-demand research protocol
- ❌ Weighted scoring improves the gate → simpler unweighted + hard trigger is more reliable
- ❌ "Ambiguous?" is a good gate question → "Multi-stakeholder?" is more objective
- ❌ Mockup vs spec is about priority domain → it's about verification method
- ❌ Three rounds for every priority → per-priority graduation
- ❌ Round 3 inversions assigned per-priority → tension-based (pairs of conflicting priorities)

---

## Tensions for Round 3

These are pairs of priorities that pull against each other. Each is a genuine design conflict where resolving one may compromise the other.

### Tension 1: Handoff Complexity vs. Progress Speed
P4 now proposes 5 artifacts (spec, contracts, checklist, CLAUDE.md, deviations). P3 says users abandon after 10 minutes. The handoff is getting heavyweight. **What if the handoff were instant?** What if the spec IS the implementation instruction, not a separate document that must be translated?

### Tension 2: Research Depth vs. Gate Simplicity
P1 wants deep, adaptive research with on-demand agents. P5 wants a 10-second gate that's cheap and simple. The boundary between "quick check" and "full explore" is blurring. **What if there were no gate at all?** What if research itself could be graduated?

### Tension 3: Per-Priority Graduation vs. Synthesis Coherence
P2 says resolve priorities independently and freeze them early. P6 says final synthesis must ensure cross-priority consistency. **What if early-resolved priorities are WRONG because they didn't account for later-round discoveries in other priorities?**

### Tension 4: Spec Authority vs. Implementation Reality
P4 says specs are authoritative and deviations must be logged. But the Augment Intent "living spec" insight is real: sometimes the code discovers things the spec couldn't anticipate. **What if the spec isn't a contract but a hypothesis?**

---

*Round 2 complete. 4 tensions identified. Proceeding to Round 3: each tension gets one agent.*
