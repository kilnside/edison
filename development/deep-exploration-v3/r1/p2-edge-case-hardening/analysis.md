# P2: Edge Case Hardening — R1 Analysis

**Character:** The Engineer
**Priority type:** Structural (primary) / Tradeoff (secondary)

## The Problem

Edison's SKILL.md contains ~12 behaviors where two different AIs reading the same spec would do different things. This is not about style differences — it is about structural ambiguity that produces divergent outcomes. An AI running Edison on Claude vs. Gemini vs. GPT should produce the same *process*, even if the *content* quality varies.

## Severity Classification

### Tier 1: Breaks Edison (execution halts or produces wrong output)

**Issue 1 — All priorities MURKY after R2.** The spec says "Early exit: If all remaining priorities are now RESOLVED, skip to Final Synthesis." It never says what happens if zero priorities resolve across two rounds. An AI could loop forever, skip to R3 with all MURKY priorities (R3 expects tensions, not priorities), or just stop. Fix: define a fallback that forces R3 to treat the top-3 MURKY priorities as tensions against each other, or escalate to the user.

**Issue 5 — Focused 2-round path references R3 outputs.** Final Synthesis says "Some get a kernel from R3's wild ideas." But the Focused depth option explicitly skips R3. An AI running Focused could either crash looking for R3 artifacts or silently produce a Final Synthesis that references nonexistent material. Fix: Final Synthesis must be conditional — "from available rounds."

**Issue 9 — "Never block on user input" vs. 3 mandatory gates.** Progress Visibility says "Never block on user input." Phases 1, 3, and 8 have explicit gates that say "User confirms" or "User approves." A literal-minded AI will deadlock. Fix: clarify that gates are the exception — steering is non-blocking, gates are blocking by design.

### Tier 2: Causes Divergence (AIs make different choices)

**Issue 2 — Research finds nothing.** Research dispatch requires "Minimum 2 real sources per question (or explicit 'nothing found')." But there is no downstream handling. If 80% of research returns nothing, does Edison proceed with an empty RESEARCH-BRIEF.md? Does it re-scope questions? Different AIs will make different calls. Fix: if >50% of questions return nothing, compress to what was found, flag low-evidence state, and bias R1 toward conservative approaches.

**Issue 4 — Circular priority dependencies.** Priorities have "Depends on [other priority]" and "May invalidate [other priority]." Nothing prevents A depends on B depends on A. The wave-batching logic ("batched in waves of 3-4") has no cycle detection. Fix: topological sort with cycle detection; cycles become co-dependencies explored in the same wave.

**Issue 6 — "Just the research" has no workflow.** It is offered as a depth option ("Just the research — scan the landscape, I'll report findings, you decide whether to go deeper") but has no defined stopping point, deliverable format, or re-entry mechanism. Fix: define it as Phases 1-2 only, deliverable is RESEARCH-BRIEF.md, re-entry resumes at Phase 3.

**Issue 7 — Phase 0 with no standard files.** Tier 1 scan expects package.json/pyproject.toml/Cargo.toml and README.md. A project with none of these (e.g., a Zig project, a collection of shell scripts, a design system with only CSS) gets an incomplete profile. Fix: make Tier 1 file list a priority chain — try each, use what exists, note what is missing.

**Issue 12 — Self-score 1-5 has no defined semantics.** R1 agents produce a "self-score 1-5" but nothing maps scores to RESOLVED/CONTESTED/MURKY. The synthesis step classifies priorities into those categories but never references the score. Different AIs will interpret 3/5 differently. Fix: define the mapping (1-2 = MURKY, 3 = CONTESTED, 4-5 = RESOLVED) as a starting heuristic that synthesis can override.

### Tier 3: Cosmetic (noticeable but not harmful)

**Issue 3 — Late-arriving priorities.** User adds priorities after the confirmation gate. The spec has no mechanism for this. In practice, any reasonable AI will just add them. But it is technically undefined whether they get full R1 treatment or slot into the current round. Fix: allow priority injection between rounds with a note about reduced coverage.

**Issue 8 — Audit assumes Edison-format specs.** Audit Step 2 says "Extract these structured fields first" referring to MUST/MUST NOT/VERIFICATION blocks. A team using Edison for the first time might audit a spec they wrote by hand. Fix: add a graceful degradation — if no task blocks found, treat narrative requirements as unstructured assertions and do a best-effort comparison.

**Issue 10 — Hard trigger is mathematically redundant.** "If both Interconnected AND Irreversible are true, always recommend Explore regardless of total score." But Interconnected + Irreversible already = 2, which meets the threshold of 2+. The rule never changes the outcome. Fix: either remove it (reduces spec surface) or redefine it as lowering the threshold to 1 for these two signals.

**Issue 11 — "Research not interrogation" vs. Vision Capture.** Vision Capture structures what the user said into 5 categories and plays it back. This is listening and structuring, not interrogating. The tension is more apparent than real — Edison is not asking 5 questions, it is organizing what was already said. Fix: add a clarifying note that Vision Capture is synthesis of user input, not a questionnaire.

## Recommended Approach

Fix Tier 1 issues immediately — they cause execution failures. Fix Tier 2 issues in the same pass — they are the core of the "different AI, different Edison" problem. Tier 3 issues can be addressed as spec polish.

The fixes share a pattern: most edge cases need a **fallback clause** — a "when X is missing or unexpected, do Y" statement. The spec is optimistic-path only. Adding ~15-20 lines of fallback language across 8 locations would eliminate the divergence.

## Self-Score: 4/5

High confidence that the severity classification is correct and the fixes are tractable. Docked one point because I have not verified whether the "Focused path references R3" issue (Issue 5) actually manifests in practice — it is possible that AIs naturally skip the R3 reference when R3 did not run, making it a theoretical rather than practical bug.
