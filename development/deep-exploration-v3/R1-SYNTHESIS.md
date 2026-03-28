# Round 1 Synthesis: The Engineer's Verdict

All 8 priority agents reported. Average self-score: 3.75/5.

---

## Per-Priority Checkpoint

| # | Priority | R1 Recommendation | Confidence | Status |
|---|----------|-------------------|------------|--------|
| 1 | Spec Compression | Hybrid: ~270-line dispatch body + resources/ for execution detail. Two-audience model (dispatch vs execution). | 4/5 | RESOLVED |
| 2 | Edge Case Hardening | 15-20 lines of fallback clauses at 8 locations. Root cause: optimistic-path only. | 4/5 | RESOLVED |
| 3 | Self-Improvement Loop | Dual-level evolution: task-level in profile (automatic) + meta-level in global file (human-gated). PromptBreeder-inspired. | 3/5 | CONTESTED |
| 4 | Cross-Project Learning | Developer profile at ~/.claude/edison/developer.md. Portable patterns extracted after synthesis. | 3/5 | CONTESTED |
| 5 | Distribution & Versioning | SemVer + Changelog + compatibility declarations in frontmatter. | 4/5 | RESOLVED |
| 6 | Binding Portability | AGENTS.md primary, CLAUDE.md supplement. Directory-scoped binding. | 4/5 | RESOLVED |
| 7 | Decision Gap Positioning | Hybrid: name the gap ("missing phase between brainstorming and building") + anchor in research capability. | 4/5 | RESOLVED |
| 8 | User Signal Integration | Reframe: Edison operates pre-prototype where proxy signals are correct. Formalize proxy research + add validation plan to spec output. | 4/5 | RESOLVED |

---

## Cross-Priority Findings

### Strong Consensus
- **P1 (Compression) enables P3 (Self-Improvement).** The split into body + resources/ creates a stable dispatch layer that changes rarely, while execution details in resources/ can evolve. ~230 lines of headroom for new features.
- **P3 (Self-Improvement) feeds P4 (Cross-Project Learning).** The meta-observations file IS the cross-project mechanism. They are one system, not two.
- **P6 (Binding) validates P7 (Positioning).** Moving to AGENTS.md makes Edison tool-agnostic, which reinforces the "decision phase" positioning as universal rather than Claude-specific.
- **P2 (Hardening) + P3 (Self-Improvement).** When fallback clauses trigger, that's failure data. Hardening creates the instrumentation that self-improvement needs.
- **P8 (User Signal) reframes as non-gap.** Edison operates pre-prototype where proxy signals are the right method. This is a positioning clarity issue (P7), not a missing capability.

### Tensions Between Priorities
- **P1 (Compression: move to resources/) vs. P3 (Self-Improvement: need context to capture outcomes).** If execution details are in resources/, the self-improvement capture step must read those resources to know what happened. Resource-loading reliability becomes load-bearing.
- **P3 (Self-Improvement: dual-level evolution) vs. P5 (Versioning: SemVer).** If Edison evolves itself, what does a "version" mean? The SKILL.md may drift through meta-level mutations between tagged releases. Version becomes less meaningful.
- **P6 (Binding: AGENTS.md primary) vs. P3 (Self-Improvement: write to profile.md).** If binding moves to AGENTS.md, where does Edison's self-improvement state live? AGENTS.md is for agent instructions, not for tool state. Edison needs a clear separation between spec binding (AGENTS.md) and tool state (.edison/).

### Shared Dependencies
- **`.edison/` directory** — P1 (compressed output home), P3 (evolution log, lessons), P4 (developer profile), P8 (validation plans). This directory is becoming central to everything. User's request to make it discoverable is validated by 4 priorities converging on it.
- **Resource-loading mechanism** — P1 (execution details), P3 (self-improvement needs those details). If Claude Code can't reliably read resources/, both priorities are affected.

---

## Unchallenged Assumptions (for Round 2)

1. **Claude Code reliably reads skill resource files mid-execution.** P1's entire strategy depends on this. P3's capture mechanism needs it too. Not verified.
2. **Edison runs often enough to generate useful self-improvement data.** Both P3 and P4 scored 3/5 partly because of this. Current user base: one person.
3. **AGENTS.md will achieve CLAUDE.md parity in Claude Code.** P6's recommendation becomes hollow if Claude Code treats AGENTS.md as secondary.
4. **"Decision" is the right framing.** P7 notes Edison is really "structured exploration that produces decisions." The word "decision" may set wrong expectations.
5. **SemVer is appropriate for documents.** P5 flagged CalVer as potentially more honest for a skill that's a prompt, not an API.
6. **The two-audience model (dispatch vs execution) doesn't degrade behavior.** P1 assumes agents executing Explore will read resources/ as reliably as inline instructions.

---

## Conventional Choices Worth Questioning

1. **Per-project .edison/ directory.** Every priority converges on it, but should exploration artifacts live in the project at all? They could be in ~/.claude/edison/projects/ to keep repos clean.
2. **Markdown for everything.** The self-improvement loop, cross-project learning, and binding could all benefit from structured data (YAML, JSON). Markdown is human-readable but hard to parse programmatically for pattern extraction.
3. **SKILL.md as the sole entry point.** With resources/ extraction, maybe the skill should use a plugin structure with hooks (pre-write triggers for binding, post-run triggers for capture) instead of a single instructions file.
4. **Human-gated meta-level changes only.** P3 assumes humans must approve SKILL.md changes. But if the changes are small and backed by evidence (e.g., "adjusted self-score threshold from 3→4 based on 5 runs"), could they be auto-applied?

---

## Late-Arriving Input: .edison/ as Canonical Home

User requested that `.edison/` be the discoverable directory for all Edison output. This is validated by cross-priority convergence — P1 (output structure), P3 (evolution log), P4 (profile), P8 (validation plans) all need a home. Proposed structure:

```
.edison/
├── profile.md              (project identity + lessons)
├── explorations/           (timestamped exploration runs)
│   └── 2026-03-28-feature-name/
│       ├── VISION.md
│       ├── RESEARCH-BRIEF.md
│       ├── priorities.md
│       ├── r1/, r2/, r3/
│       ├── R1-SYNTHESIS.md, R2-SYNTHESIS.md
│       └── synthesis/
│           ├── CONVERGENCE.md
│           ├── DEFINITIVE-SPEC.md
│           └── [artifact]
├── audits/                 (audit results)
│   └── 2026-03-28-feature-name.md
├── evolution-log.md        (self-improvement capture)
└── DEVIATIONS.md           (intentional spec divergences)
```

---

*Round 1 complete. 6 priorities RESOLVED, 2 CONTESTED (P3: Self-Improvement, P4: Cross-Project Learning). Proceeding to Round 2 on CONTESTED priorities only.*
