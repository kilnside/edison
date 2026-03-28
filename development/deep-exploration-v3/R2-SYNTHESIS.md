# Round 2 Synthesis: The Designer's Verdict

Both R2 agents reported. P3 through the Economist lens, P4 through the Archaeologist lens. Both produced genuine corrections to R1.

---

## Per-Priority Checkpoint (Updated)

| # | Priority | R1 Best | R2 Change | Confidence | Status |
|---|----------|---------|-----------|------------|--------|
| 1 | Spec Compression | ~270-line body + resources/ | (unchanged — R1 resolved) | 4/5 | RESOLVED |
| 2 | Edge Case Hardening | 15-20 lines of fallback clauses | (unchanged — R1 resolved) | 4/5 | RESOLVED |
| 3 | Self-Improvement Loop | Dual-level PromptBreeder-inspired | Drop PromptBreeder claim → "assisted evolution." User signals are gold. Task-level 80% / meta-level 20%. Add reversal cost + migration path + cost ceiling. | 4/5 | RESOLVED |
| 4 | Cross-Project Learning | Developer profile at ~/.claude/edison/ | Don't build own memory system — use Claude Code's existing memory. Deposition > extraction. Hard cap 50 entries / 3KB. Partially merge with P3. | 4/5 | RESOLVED |
| 5 | Distribution & Versioning | SemVer + Changelog + compat | (unchanged — R1 resolved) | 4/5 | RESOLVED |
| 6 | Binding Portability | AGENTS.md primary, CLAUDE.md supplement | (unchanged — R1 resolved) | 4/5 | RESOLVED |
| 7 | Decision Gap Positioning | "Missing phase between brainstorming and building" | (unchanged — R1 resolved) | 4/5 | RESOLVED |
| 8 | User Signal Integration | Proxy signals + validation plan | (unchanged — R1 resolved) | 4/5 | RESOLVED |

**All 8 priorities now RESOLVED.**

---

## Key R2 Innovations (What R1 Missed)

### 1. PromptBreeder Was Aspirational, Not Engineering
R1 claimed Level 4 self-evolution. R2 shows Edison lacks both a fitness function and a mutation evaluator. What's actually achievable: Level 2.5/3 — structured capture + human-reviewed proposals via `/edison evolve`. Honest and useful.

### 2. User Signals Are the Only Gold-Standard Feedback
Every other metric (resolution round, research hit rate, audit coverage) is noisy or lagging. User overrides, corrections, and rejections are high-confidence, near-zero cost, and immediately actionable. Build the system on "what did the user change?"

### 3. Don't Build Your Own Memory System
Claude Code already has three-tier memory (global, project, auto-memory). Edison should deposit tagged observations into the existing system, not maintain a parallel `~/.claude/edison/developer.md`. Be a tenant, not a landlord.

### 4. Deposition Beats Extraction
Writing observations as they occur (during synthesis) beats running a post-hoc extraction pipeline. Devin validates this pattern. awesome-cursorrules shows extraction fails in practice (28.7% duplication from whole-file copying).

### 5. P3 and P4 Partially Merge
One observation system, two read paths. Observations tagged by type: `[preference]`, `[stack-pattern]`, `[process-outcome]`, `[edge-case]`. Self-improvement reads process/edge-case tags. Cross-project learning reads preference/stack tags. Eliminates dual-storage problem.

### 6. Reversal Cost Was Unaddressed
What happens when a lesson is wrong? Lessons need timestamps, confidence decay, and expiry. An "un-learning" mechanism prevents stale lessons from silently biasing future runs.

### 7. Profile Migration on SKILL.md Upgrades
If Edison v3 → v4 changes phase names or metrics, existing profile lessons referencing old terminology break. The upgrade path for `.edison/profile.md` was a P3-P5 seam gap neither priority addressed.

---

## Assumptions Validated by Round 2

- ✅ Task-level adaptation in .edison/profile.md is high-ROI (immediate, low-cost)
- ✅ Human gating for spec mutations is non-negotiable
- ✅ Fallback-trigger capture from P2 provides free failure data
- ✅ Portable vs non-portable taxonomy from R1 is correct
- ✅ Privacy-by-locality is the right default

## Assumptions Overturned by Round 2

- ❌ PromptBreeder-level self-evolution is achievable → Level 2.5/3 "assisted evolution"
- ❌ Edison needs its own cross-project file → use Claude Code's existing memory
- ❌ Extraction is the right mechanism → deposition during synthesis
- ❌ Meta-level and task-level deserve equal weight → 80/20 task-level heavy
- ❌ Profile can grow without bounds → hard cap with staleness eviction

---

## Tensions for Round 3

### Tension 1: Spec Compression vs. Self-Improvement Completeness
P1 says compress to ~270 lines. P3 adds ~20-30 lines for self-improvement. P2 adds ~15-20 lines for fallback clauses. P5 adds version/changelog fields. P6 changes binding instructions. P8 adds validation plan to output format. The headroom is real (~230 lines) but these additions compete for it. **What if the spec had zero lines for self-improvement?** What if it were purely an external mechanism (a hook, a companion skill) rather than inline instructions?

### Tension 2: Edison's Identity vs. Ecosystem Tenancy
P4 says "be a tenant of Claude Code's memory system." P6 says "bind to AGENTS.md for cross-tool compatibility." P7 says "own the decision gap." These pull in different directions: tenant (subordinate to Claude Code), citizen (compatible with all tools), or sovereign (owns its own category). **What if Edison didn't try to be all three?**

### Tension 3: Superpowers Relationship
User identified that Edison's functionality may benefit from Superpowers being installed (task tracking, brainstorming fallback, implementation planning). Edison positions as standalone but the best experience may be the combo. **What if Edison explicitly declared its relationship to complementary skills?** Not a dependency, but a documented ecosystem.

---

*Round 2 complete. All 8 priorities now RESOLVED. 3 tensions identified. Proceeding to Round 3.*
