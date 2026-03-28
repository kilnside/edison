# P2 Artifact: Edge Case Fix Map

## Complete Issue-to-Fix Table

| # | Issue | Severity | Fix Type | Spec Location |
|---|-------|----------|----------|---------------|
| 1 | All priorities MURKY after R2 | Breaks | Add fallback clause to R2 Synthesis | Phase 5, R2 Synthesis |
| 2 | Research finds nothing | Divergence | Add null-research handling to Phase 2, Step 3 | Phase 2, Step 3 |
| 3 | Late-arriving priorities | Cosmetic | Add priority injection mechanism | Phase 3 |
| 4 | Circular priority dependencies | Divergence | Add cycle detection to Phase 3 | Phase 3 + Phase 4 wave batching |
| 5 | Focused path references R3 | Breaks | Make Final Synthesis conditional | Phase 7 |
| 6 | "Just the research" undefined | Divergence | Define workflow as Phases 1-2 | Cost Estimation section |
| 7 | Phase 0 with no standard files | Divergence | Priority chain for file detection | Phase 0, Tier 1 table |
| 8 | Audit assumes Edison-format specs | Cosmetic | Graceful degradation for non-Edison specs | Audit, Step 2 |
| 9 | "Never block" vs. mandatory gates | Breaks | Clarify gates are explicit exceptions | Progress Visibility |
| 10 | Hard trigger redundancy | Cosmetic | Remove or redefine | The Check, Scoring |
| 11 | Research vs. Vision questions | Cosmetic | Clarifying note | Phase 1 |
| 12 | Self-score has no semantics | Divergence | Define score-to-status mapping | Phase 4 + R1 Synthesis |

---

## Before/After Spec Language — Top 5 Critical Fixes

### Fix 1: All Priorities MURKY After R2 (Issue #1)

**Location:** Phase 5 (Round 2), R2 Synthesis section

**BEFORE** (current spec, lines ~428-438):
```markdown
#### R2 Synthesis

- Per-priority: assumptions validated/overturned, updated confidence
- Updated graduation: RESOLVED / CONTESTED / MURKY
- **Tensions:** Pairs of priorities that pull against each other, each phrased as a
  design conflict
- "Most radical departure that still serves the vision"

Write `R2-SYNTHESIS.md`. Present checkpoint table.

**Early exit:** If all remaining priorities are now RESOLVED, skip to Final Synthesis.
```

**AFTER:**
```markdown
#### R2 Synthesis

- Per-priority: assumptions validated/overturned, updated confidence
- Updated graduation: RESOLVED / CONTESTED / MURKY
- **Tensions:** Pairs of priorities that pull against each other, each phrased as a
  design conflict
- "Most radical departure that still serves the vision"

Write `R2-SYNTHESIS.md`. Present checkpoint table.

**Early exit:** If all remaining priorities are now RESOLVED, skip to Final Synthesis.

**Fallback — no priorities resolved after R2:** If all priorities remain CONTESTED or
MURKY after two rounds, present the user with a checkpoint: "Two rounds of analysis
haven't converged on clear answers. Options: (a) proceed to Round 3 — I'll treat the
top tensions as constraint-removal problems, (b) force-resolve — pick the best-so-far
for each and move to synthesis, (c) narrow scope — drop the murkiest priorities and
re-run focused." For R3 entry, synthesize tensions from the CONTESTED priorities
(they have competing alternatives). For MURKY priorities with no viable alternatives,
frame them as "what constraint is preventing clarity?" and assign to R3 agents.
```

---

### Fix 2: "Never Block" vs. Mandatory Gates (Issue #9)

**Location:** Progress Visibility section

**BEFORE** (current spec, line ~384):
```markdown
- **Never block on user input** — steering available (skip round, reprioritize, stop
  and synthesize what you have) but never required
```

**AFTER:**
```markdown
- **Never block on user input between milestones** — steering is available (skip round,
  reprioritize, stop and synthesize what you have) but never required. The three
  gates (Vision confirmation, Priority confirmation, Handoff approval) are intentional
  blocking points — they exist because proceeding without alignment wastes everything
  downstream. Between gates, Edison runs autonomously.
```

---

### Fix 3: Focused Path References R3 (Issue #5)

**Location:** Phase 7, Final Synthesis

**BEFORE** (current spec, lines ~467-468):
```markdown
Per priority, pick the best answer from any round. Some priorities get R1's sensible
path. Some get R2's creative refinement. Some get a kernel from R3's wild ideas.
Most get a composite.
```

**AFTER:**
```markdown
Per priority, pick the best answer from the rounds that ran. Some priorities get R1's
sensible path. Some get R2's creative refinement. If Round 3 ran, some get a kernel
from R3's wild ideas. Most get a composite. For Focused (2-round) explorations,
synthesis draws only from R1 and R2 outputs.
```

---

### Fix 4: Self-Score Semantics (Issue #12)

**Location:** Phase 4, after "self-score 1-5" and in R1 Synthesis

**BEFORE** (current spec, lines ~352-355):
```markdown
Each agent produces:
- `analysis.md` — 500-800 words: priority understood, 2-3 approaches informed by
  research, recommended path with rationale, self-score 1-5
```

**AFTER:**
```markdown
Each agent produces:
- `analysis.md` — 500-800 words: priority understood, 2-3 approaches informed by
  research, recommended path with rationale, self-score 1-5

Self-score semantics:
- **5** — Clear winner, high confidence, no meaningful alternatives
- **4** — Strong recommendation with minor open questions
- **3** — Viable path identified but alternatives are competitive
- **2** — Multiple paths, none clearly better, needs challenging
- **1** — Unclear framing, priority may need restatement

Score-to-graduation heuristic (synthesis may override with justification):
- Score 4-5 → RESOLVED candidate
- Score 3 → CONTESTED
- Score 1-2 → MURKY
```

---

### Fix 5: Null Research Handling (Issue #2)

**Location:** Phase 2, Step 3 (Research Synthesis)

**BEFORE** (current spec, lines ~314-321):
```markdown
#### Step 3: Research Synthesis

Collate findings into `RESEARCH-BRIEF.md`:
- **Key findings** ranked by surprise value (what the user didn't already know)
- **Contradictions** between findings surfaced explicitly — most valuable output
- **Opportunity map** — where the vision aligns with unmet user needs
- **Risk flags** — where the vision conflicts with what users actually want

Present top findings to user. No approval needed — intelligence gathering, not a
decision point.
```

**AFTER:**
```markdown
#### Step 3: Research Synthesis

Collate findings into `RESEARCH-BRIEF.md`:
- **Key findings** ranked by surprise value (what the user didn't already know)
- **Contradictions** between findings surfaced explicitly — most valuable output
- **Opportunity map** — where the vision aligns with unmet user needs
- **Risk flags** — where the vision conflicts with what users actually want

Present top findings to user. No approval needed — intelligence gathering, not a
decision point.

**Low-evidence state:** If more than half of research questions returned "nothing
found," flag this explicitly in the brief: "Research coverage is thin — findings
below are directional, not definitive." Downstream effect: R1 agents should favor
conservative, reversible approaches for priorities where research was sparse.
Do not re-run research with rephrased questions unless the user requests it —
absence of evidence is itself a finding (novel territory, niche domain, or
poorly-framed questions).
```

---

## Unchallenged Assumptions

1. **The 12 issues are the complete set.** There may be additional undefined behaviors not identified by the initial research pass. The spec is ~730 lines; a systematic line-by-line audit might surface more.

2. **Different AIs interpret ambiguity differently.** I assumed this is true based on the framing, but it is possible that modern LLMs converge on similar "reasonable defaults" for most of these gaps, making the divergence theoretical.

3. **Fallback clauses are the right fix pattern.** I defaulted to "when X, do Y" language. An alternative approach is to restructure the spec to eliminate the edge cases entirely (e.g., remove the Focused depth option instead of patching Final Synthesis).

4. **The spec is meant to be executed literally.** Some of these issues only matter if the AI reads SKILL.md as a rigid protocol. If it is meant as a guide with latitude for judgment, many issues dissolve. But the spec's heavy use of MUST, gates, and explicit phase numbering suggests literal execution is the intent.

5. **Backward compatibility matters.** I assumed fixes should be additive (new clauses) rather than restructuring existing phases. This keeps the fix surface small but might miss opportunities for cleaner architecture.

6. **The user wants determinism across AI providers.** This is stated in the priority framing but may not be a real user need — most Edison users probably use it with one AI model consistently.
