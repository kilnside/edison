# Edison v3 Convergence: Per-Priority Decisions Across Three Rounds

---

## P1: Spec Compression

| Round | Recommendation | Verdict |
|-------|---------------|---------|
| R1 | Hybrid: ~270-line dispatch body + resources/ | **Foundation — kept** |
| R3 | Self-improvement externalized = even more headroom | **Validates and strengthens R1** |

**Decision:** R1's two-audience model (dispatch body + execution resources/) plus R3's externalization of self-improvement. Body target: ~280-300 lines including all v3 additions. Resources hold execution detail for Explore phases, Audit steps, and reference material.

**What was left behind:** R2's inline self-improvement instructions (moved to companion skill per R3).

**Confidence: HIGH**

---

## P2: Edge Case Hardening

| Round | Recommendation | Verdict |
|-------|---------------|---------|
| R1 | 15-20 lines of fallback clauses at 8 locations | **Adopted as-is** |

**Decision:** Add fallback clauses for: all-MURKY after R2 (force R3 on top-3 as tensions), null research (compress what exists, flag low-evidence), Focused path (Final Synthesis conditional on available rounds), "never block" contradiction (rename: gates are blocking, steering is non-blocking), self-score mapping (1-2=MURKY, 3=CONTESTED, 4-5=RESOLVED as starting heuristic), missing project files (try each, use what exists), late priorities (allow between rounds with reduced coverage note), audit on non-Edison specs (graceful degradation to best-effort).

Remove redundant hard trigger. Clarify Vision Capture as synthesis, not interrogation.

**Confidence: HIGH**

---

## P3: Self-Improvement Loop

| Round | Recommendation | Verdict |
|-------|---------------|---------|
| R1 | Dual-level PromptBreeder-inspired evolution | **Superseded** |
| R2 | Assisted evolution. User signals are gold. 80/20 task/meta. | **Partially adopted** |
| R3 | Self-improvement is a category error in SKILL.md. Externalize to companion skill. 2 lines of metadata output, not 20 lines of mechanism. | **Kernel adopted — the key insight** |

**Decision:** R3 wins. Self-improvement does NOT belong in SKILL.md. Instead:

1. **In SKILL.md (2 lines):** After Final Synthesis, Edison appends a `## Run Metadata` section to CONVERGENCE.md: priority count, resolution rounds, user modifications, fallbacks triggered.
2. **Companion skill (separate):** `edison-evolve/SKILL.md` loads only on `/edison evolve`. Reads .edison/ outputs, Claude Code memory, analyzes patterns, proposes SKILL.md diffs.
3. **User signals remain gold (R2 kernel):** The companion skill prioritizes user overrides/corrections over process metrics.
4. **Task-level lessons stay in .edison/profile.md (R1/R2):** The profile Lessons section captures project-specific adaptations. This is cheap, immediate, no cold start.

**What was left behind:** PromptBreeder branding (R2 overturned), inline capture mechanism (R3 overturned), meta-observations file as co-equal tier (R2 demoted, R3 externalized).

**Confidence: HIGH** (R3's argument was decisive — the category error framing resolves the tension cleanly)

---

## P4: Cross-Project Learning

| Round | Recommendation | Verdict |
|-------|---------------|---------|
| R1 | Developer profile at ~/.claude/edison/developer.md | **Superseded** |
| R2 | Use Claude Code's existing memory. Deposition > extraction. Merge with P3. | **Adopted** |
| R3 | Edison's outputs are already self-improvement data. Missing piece is interpretation. | **Validates R2** |

**Decision:** R2's approach. Don't build a separate memory system — deposit observations into Claude Code's existing memory during synthesis. Tagged with `[edison]` for filterability. Hard cap at 50 entries. Staleness-based eviction.

Partially merged with P3: one observation system, two read paths. The companion skill (`edison-evolve`) reads process observations. Phase 0 reads preference/stack observations.

**What was left behind:** Custom developer profile file (R2 overturned), post-synthesis extraction pipeline (R2 replaced with deposition).

**Confidence: HIGH**

---

## P5: Distribution & Versioning

| Round | Recommendation | Verdict |
|-------|---------------|---------|
| R1 | SemVer + Changelog + compatibility declarations | **Adopted with R2/R3 nuance** |
| R2 | SemVer versions the spec. Task-level behavior variance is personalization, not evolution. | **Adopted — important distinction** |
| R3 | Companion skill iterates independently from SKILL.md version | **Validates separation** |

**Decision:** SemVer for SKILL.md (tracks spec changes). CalVer optionally for companion skill. Changelog in repo. Version field in frontmatter. Compatibility fields (min_context if Agent Skills adds support). Profile lessons are explicitly out of scope for versioning — they're personalization, not spec changes.

**Confidence: HIGH**

---

## P6: Binding Portability

| Round | Recommendation | Verdict |
|-------|---------------|---------|
| R1 | AGENTS.md primary, CLAUDE.md supplement | **Adopted** |
| R3 | Identity stack: citizen at output layer (AGENTS.md), tenant at memory, sovereign at methodology | **Enriches R1** |

**Decision:** R1's approach enriched by R3's identity stack. AGENTS.md for binding (citizen layer). CLAUDE.md for Claude-specific behaviors only (self-trigger, Edison history). `.edison/` for sovereign output (explorations, decisions, profile). Memory deposits into Claude Code's system (tenant layer).

**Confidence: HIGH**

---

## P7: Decision Gap Positioning

| Round | Recommendation | Verdict |
|-------|---------------|---------|
| R1 | Hybrid: name the gap + anchor in research capability | **Adopted** |
| R3 | Sovereignty claim needed. Edison defines the category, not just fills a gap. | **Enriches R1** |

**Decision:** R1's hybrid positioning plus R3's sovereignty claim. Edison is "the design decision phase that AI skipped." It owns this category. The spec format (DEFINITIVE-SPEC.md with task blocks) is a deliberate contract, not an accident of format.

Concrete changes:
- Frontmatter description: "Design decision skill — the phase between brainstorming and building"
- README tagline: "The design decision phase that AI skipped"
- Check language: "there's a design decision here" not "exploration would save us"
- Output contract documented: IMPLEMENTS, MUST, MUST NOT, VERIFICATION fields are a published schema

**Confidence: HIGH**

---

## P8: User Signal Integration

| Round | Recommendation | Verdict |
|-------|---------------|---------|
| R1 | Reframe: proxy signals are correct for pre-prototype phase. Add validation plan. | **Adopted** |

**Decision:** Edison operates pre-prototype where proxy signals (forums, analytics, support tickets) are the appropriate method. User testing comes after prototyping. Edison adds:
1. A mandatory "user signal" category in research questions (Phase 2)
2. A `## Validation Plan` section in DEFINITIVE-SPEC.md: "After building, test [specific assumption] with [specific method]"

**Confidence: HIGH**

---

## Cross-Cutting Decisions from User Feedback

### Interactive Artifact Review (from user's Kilnside experience)
Phase 8 (Handoff) should walk through artifacts one at a time, offering to open each and collect feedback, rather than dumping files in a directory. "Here's the mockup for [priority]. Want to open it? Any feedback?"

### .edison/ as Canonical Home
All Edison output lives in `.edison/`:
```
.edison/
├── profile.md
├── explorations/
│   └── [date]-[feature]/
├── audits/
│   └── [date]-[feature].md
├── evolution-log.md
└── DEVIATIONS.md
```

### Superpowers Relationship
Edison is standalone in capability, legible in output. Works without Superpowers. Works better with it. The "Relationship to Other Skills" section documents the output contract so any compatible skill can consume Edison's specs.

---

## Summary: Which Round Won Where

| Priority | Winner | Why |
|----------|--------|-----|
| 1. Spec Compression | R1 + R3 | Two-audience model + externalization frees headroom |
| 2. Edge Case Hardening | R1 | Clean solution, 15-20 lines of fallbacks |
| 3. Self-Improvement | R3 kernel | Category error: execution spec ≠ meta-behavior |
| 4. Cross-Project Learning | R2 | Be a tenant, not a landlord. Deposition > extraction |
| 5. Distribution | R1 + R2 | SemVer for spec, personalization out of scope |
| 6. Binding Portability | R1 + R3 | AGENTS.md citizen + identity stack model |
| 7. Positioning | R1 + R3 | Name the gap + sovereignty claim |
| 8. User Signal | R1 | Proxy signals + validation plan |
