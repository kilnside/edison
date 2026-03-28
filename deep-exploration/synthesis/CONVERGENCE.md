# Edison Convergence: Per-Priority Decisions Across Three Rounds

---

## Priority 1: The Research Engine

| Round | Recommendation | Verdict |
|-------|---------------|---------|
| R1 | Targeted query decomposition: 3 agents with falsifiable questions | **Foundation — kept** |
| R2 | Add on-demand research protocol + adaptive sizing (1-5) + contradiction detection | **Adopted — fills real gaps** |
| R3 | (Addressed via Tension 2: telescoping) Gate questions are research at low resolution | **Kernel adopted — see Gate convergence** |

**Decision:** R1's targeted query decomposition + R2's on-demand research and contradiction detection. Research starts with specific questions derived from the vision, dispatched to 1-5 agents based on question count. Priority agents can request follow-up research via `RESEARCH_NEEDED` signals. Findings carry confidence tags (verified/inferred/speculative). Contradictions between findings are surfaced explicitly.

**What was left behind:** R1's fixed 3-agent count (adaptive is better). R3's full telescoping (too radical for research alone, but the kernel feeds into the Gate redesign).

---

## Priority 2: Progressive Round Architecture

| Round | Recommendation | Verdict |
|-------|---------------|---------|
| R1 | Mechanical constraints per round (Constraint Satisfaction/Challenging/Removal) | **Foundation — kept** |
| R2 | Per-priority graduation (RESOLVED/CONTESTED/MURKY) + tension-based R3 | **Major improvement — adopted** |
| R3 | (Addressed via Tension 3: dependency graph) Priorities are nodes, not a list | **Kernel adopted — dependency matrix in Phase 3** |

**Decision:** R1's mechanical differentiation (each round has distinct rules, not just personas) + R2's per-priority graduation (only unresolved priorities advance) + R2's tension-based Round 3 (agents tackle cross-priority conflicts, not per-priority inversions). R3's dependency matrix added to Phase 3.

Round structure:
- **R1 (Constraint Satisfaction):** All priorities. Find the sensible path. Must cite research. Output: recommendation + unchallenged assumptions list.
- **R2 (Constraint Challenging):** Only CONTESTED/MURKY priorities. Must reference specific R1 assumptions. Output: diff against R1 + cross-priority tensions.
- **R3 (Constraint Removal):** One agent per tension (not per priority). Must name the removed constraint and produce a kernel extraction.

**What was left behind:** R1's uniform 3-round progression for all priorities. R3's full topological ordering of exploration (too complex, but dependency matrix captures the essential insight).

---

## Priority 3: Progress Visibility

| Round | Recommendation | Verdict |
|-------|---------------|---------|
| R1 | Stream-first progressive delivery, one-line findings, coarse steering | **Foundation — kept** |
| R2 | Living summary block + welcome-back moment + completion notification + emotional pacing | **Adopted — fills the async gap** |
| R3 | (Not directly addressed — R2 was already strong here) | N/A |

**Decision:** R1's stream-first delivery + R2's living summary. Concrete mechanism:
- Stream one-line findings as agents complete (synchronous user)
- Maintain a rewritable "story so far" block after each milestone (async user)
- "Welcome back" catchup when user returns after >3 min gap
- Clear "EXPLORATION COMPLETE" block with summary, surprises, and invitation
- Never block on user input; steering available but never required
- Checkpoint table after each round (priority, answer, confidence, status)

**What was left behind:** Nothing significant. R1 + R2 converged cleanly.

---

## Priority 4: The Handoff Mechanism

| Round | Recommendation | Verdict |
|-------|---------------|---------|
| R1 | 4 artifacts: spec + contracts/ + checklist + CLAUDE.md | **Superseded** |
| R2 | 5 artifacts: + DEVIATIONS.md + dual-format + path-based triggers + dependency graph | **Partially adopted** |
| R3 | Collapse artifacts: embed execution metadata in the spec itself. Specs fail because they're far away (proximity problem). | **Kernel adopted — the key insight** |

**Decision:** R3's kernel wins here. Instead of proliferating bridge artifacts (R1: 4, R2: 5), invest that complexity into making the spec self-executing:

1. **DEFINITIVE-SPEC.md** — Dual-structure: narrative sections (human-readable why) + embedded per-component task blocks with AGENT INSTRUCTION, DEPENDS ON, VERIFICATION, and MUST/MUST NOT keywords.
2. **CLAUDE.md integration** — Path-based triggers from R2: "When working on files in src/X/**, read the [Component X] section of DEFINITIVE-SPEC.md FIRST."
3. **DEVIATIONS.md** — Kept from R2. Intentional divergences logged here with rationale.

The per-component contracts/ directory is dropped — the spec itself carries that decomposition via its task blocks. The separate checklist is dropped — VERIFICATION fields in each task block ARE the checklist.

**What was left behind:** R1/R2's separate contracts/ directory (replaced by embedded task blocks). R3's fully embedded-in-source-files idea (too radical — spec annotations in tsx files have poor developer ergonomics). But the proximity insight is preserved: the spec is structured so agents can extract exactly their section without reading the whole document.

---

## Priority 5: The Gate (Mode 1 Check)

| Round | Recommendation | Verdict |
|-------|---------------|---------|
| R1 | Weighted scoring, 5 revised questions, threshold 3/7 | **Partially superseded** |
| R2 | Drop weights, unweighted 2-of-5, hard trigger combo, rename Q3+Q5 | **Adopted for simplicity** |
| R3 | Collapse gate into exploration: telescoping depth governed by budget | **Kernel noted but not fully adopted** |

**Decision:** R2's simpler approach wins for the gate itself. R3's telescoping insight is captured as a design principle but not a structural change (yet — it may be right for Edison v3).

**The 5 questions (R2 final):**
1. **Interconnected?** — Touches 3+ features (heavy hitter)
2. **Precedent-setting?** — Future code copies this pattern
3. **Opinionated?** — Someone with authority will react (broadened from "brand-sensitive")
4. **Irreversible?** — Expensive to change post-ship (heavy hitter)
5. **Multi-stakeholder?** — Affects different user types or teams differently

Unweighted, threshold 2-of-5. **Hard trigger:** Interconnected AND Irreversible both true = always recommend Explore.
Pre-check: contradiction sniff against CLAUDE.md Active Design Specs.
Exemptions: established patterns, CRUD, tests/config, "just build" instruction.
Positive examples added for calibration.

**R3 kernel preserved as design principle:** "The gate is the exploration at low resolution." Future versions may collapse the boundary. For now, the discrete gate is simpler to implement and explain.

---

## Priority 6: Synthesis Quality

| Round | Recommendation | Verdict |
|-------|---------------|---------|
| R1 | Classify priorities (structural/tradeoff/conceptual), weight rounds, always pick one | **Foundation — kept** |
| R2 | Add declared dependencies + unified classification (primary+secondary) + one record three consumers | **Adopted — the unification is key** |
| R3 | (Addressed via Tension 3: dependency propagation) | **Kernel feeds into Phase 3** |

**Decision:** R2's unified model. One classification step in Phase 3, consumed by synthesis (round weighting), artifacts (format selection), and handoff (task block shape).

Synthesis rules:
- Always pick one answer per priority. No menus.
- Low-confidence decisions get reversal triggers: "Use X, but if [assumption] is wrong, switch to Y."
- Decisions with external dependencies get declared assumptions: "This assumes [fact Edison can't verify]."
- Cross-priority consistency check in final synthesis, informed by Phase 3's dependency matrix.
- Per-round checkpoint tables for early exit possibility.

---

## Priority 7: Mockup vs. Spec Balance

| Round | Recommendation | Verdict |
|-------|---------------|---------|
| R1 | Conditional artifacts: specs always, mockups only for visual priorities | **Foundation — kept** |
| R2 | Verification-driven selection + agent chooses format + decomposable artifacts | **Adopted — stronger heuristic** |
| R3 | (Not directly addressed) | N/A |

**Decision:** R2's verification-driven heuristic. The question is not "is this priority visual?" but "how will you verify the implementation matches?" If verification requires eyes → visual artifact. If verification requires code inspection → spec.

- Every agent always produces a structured spec (analysis.md)
- Agents choose their additional artifact type: diagram (Mermaid), static mockup, or interactive prototype
- Uses the unified classification from P6 to guide selection
- Final deliverable is format-agnostic (not hardcoded as `definitive-mockup.html`)

---

## Summary: Which Round Won Where

| Priority | Winner | Why |
|----------|--------|-----|
| 1. Research Engine | R1 + R2 | R1's mechanism was right, R2 added essential flexibility |
| 2. Round Architecture | R2 + R3 kernel | Graduation + tensions + dependency matrix |
| 3. Progress Visibility | R1 + R2 | Clean convergence, async gap filled |
| 4. Handoff | R3 kernel | Stop adding bridge artifacts; self-executing spec |
| 5. Gate | R2 | Simpler is more reliable; R3 kernel noted for future |
| 6. Synthesis | R2 | Unified classification is the key innovation |
| 7. Artifacts | R2 | Verification-driven beats domain-driven |
