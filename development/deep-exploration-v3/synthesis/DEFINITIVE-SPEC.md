# Edison v3 Definitive Specification

> **Start here:** Edison v3 compresses the spec for ecosystem compliance, hardens edge cases,
> externalizes self-improvement to a companion skill, uses Claude Code's memory for cross-project
> learning, binds to AGENTS.md for portability, and positions as "the design decision phase that
> AI skipped." All output lives in `.edison/`.

---

## Component: Spec Structure
IMPLEMENTS: P1 (Spec Compression)
DEPENDS ON: SKILL.md, resources/explore-phases.md, resources/audit-process.md
AGENT INSTRUCTION: Split SKILL.md into a ~280-300 line dispatch body and resources/ for execution detail. The body contains routing, triggers, the Check, Phase 0 detection, mode overviews, key principles, scaling, and output contract. Resources contain full Explore phase instructions and Audit steps.
MUST: Keep body under 500 lines (Agent Skills standard). Target ~280-300 for headroom.
MUST: Include explicit "Read resources/explore-phases.md" directives when entering Explore mode.
MUST: Include skeleton of each phase (name, gate, key constraint) in body even without resources — a capable agent should approximate behavior from the skeleton alone.
MUST NOT: Delete any content — relocate execution detail to resources/, not remove it.
MUST NOT: Compress prose to the point of ambiguity — specificity prevents divergent behavior.
VERIFICATION: Body line count < 500. Resources contain full phase detail. Edison runs correctly from body + resources together. Edison produces reasonable behavior from body alone (degraded but functional).

---

## Component: Edge Case Hardening
IMPLEMENTS: P2 (Edge Case Hardening)
DEPENDS ON: SKILL.md (all sections)
AGENT INSTRUCTION: Add fallback clauses at 8 locations in the spec. The root pattern: "When X is missing or unexpected, do Y."
MUST: Add fallback for all-MURKY after R2 → force R3 on top-3 MURKY priorities treated as tensions against each other, or escalate to user: "These priorities aren't resolving. Want to reframe them or proceed to synthesis with what we have?"
MUST: Add fallback for null research → if >50% of questions return nothing, compress to what exists, flag low-evidence state, bias R1 toward conservative approaches.
MUST: Make Final Synthesis conditional → "Pick the best answer from available rounds" not "from any round including R3." Focused (2-round) path must not reference R3.
MUST: Rename "never block on user input" → "Steering is non-blocking. Gates (Vision, Priority, Handoff) are blocking by design."
MUST: Define self-score mapping → 1-2 = MURKY, 3 = CONTESTED, 4-5 = RESOLVED (starting heuristic, synthesis can override based on cross-priority analysis).
MUST: Handle missing project files in Phase 0 → try each file in priority order, use what exists, note what's missing. Near-empty profile is valid.
MUST: Allow late priority injection → between rounds, with note about reduced coverage.
MUST: Handle non-Edison specs in Audit → if no task blocks found, treat narrative as unstructured assertions, best-effort comparison.
MUST: Remove redundant hard trigger rule (Interconnected + Irreversible already = 2, meeting threshold).
MUST: Clarify Vision Capture as synthesis of user input, not interrogation.
MUST NOT: Add more than 20 lines of fallback language total — keep patches surgical.
VERIFICATION: Run Edison mentally against 5 edge cases (null research, all MURKY, Focused path, missing files, non-Edison audit). Each should have a defined path.

---

## Component: Self-Improvement Architecture
IMPLEMENTS: P3 (Self-Improvement Loop)
DEPENDS ON: Phase 7 (Final Synthesis), .edison/profile.md, companion skill edison-evolve/SKILL.md
AGENT INSTRUCTION: Add 2 lines to Phase 7 output format for run metadata. Create companion skill spec separately. Task-level lessons in profile remain.
MUST: Append `## Run Metadata` to CONVERGENCE.md after synthesis: priority count, resolution rounds per priority, user modifications (reorders/additions/removals), fallbacks triggered, research hit rate.
MUST: Keep task-level lessons in .edison/profile.md Lessons section — project-specific adaptations captured after synthesis.
MUST: Create companion skill `edison-evolve/SKILL.md` that loads only on `/edison evolve` — reads .edison/ outputs, Claude Code memory, proposes SKILL.md diffs with evidence.
MUST: Companion skill prioritizes user signals (overrides, corrections, rejections) over process metrics.
MUST: Companion skill records proposed, accepted, and rejected mutations (failure memory).
MUST: Lessons in profile carry timestamps and decay — stale lessons (>6 months, never reused) can be evicted.
MUST NOT: Add self-improvement mechanism instructions to main SKILL.md — execution spec ≠ meta-behavior.
MUST NOT: Claim "self-evolving" or "Level 4" — Edison is "assisted evolution" (Level 2.5/3): structured capture + human-reviewed proposals.
MUST NOT: Exceed 5K tokens per run for lesson capture.
VERIFICATION: Main SKILL.md has ≤2 lines for self-improvement (the metadata directive). Companion skill exists as separate SKILL.md. Profile lessons have timestamps.

---

## Component: Cross-Project Learning
IMPLEMENTS: P4 (Cross-Project Learning)
DEPENDS ON: Claude Code memory system, Phase 7 (Final Synthesis), Phase 0 (Project Scan)
AGENT INSTRUCTION: Deposit observations into Claude Code's existing memory during synthesis. Read them during Phase 0 of future projects. No custom memory infrastructure.
MUST: Deposit tagged observations during Final Synthesis — `[edison:preference]`, `[edison:stack-pattern]`, `[edison:process-outcome]`, `[edison:edge-case]`, `[edison:domain-insight]`.
MUST: Read Edison-tagged memory entries during Phase 0 to inform project profile.
MUST: Hard cap at 50 Edison memory entries. Evict by staleness (oldest, lowest reuse).
MUST: Write observations as they occur (deposition), not extract them afterward.
MUST NOT: Build a custom memory system — be a tenant of Claude Code's memory.
MUST NOT: Store file paths, code snippets, or project-specific identifiers in cross-project observations.
VERIFICATION: After an Explore run, check Claude Code memory for new Edison-tagged entries. On a new project, Phase 0 should reference relevant prior observations.

---

## Component: Distribution & Versioning
IMPLEMENTS: P5 (Distribution & Versioning)
DEPENDS ON: SKILL.md frontmatter, CHANGELOG.md, .claude-plugin/marketplace.json
AGENT INSTRUCTION: Add version field to frontmatter. Create CHANGELOG. Sync version across frontmatter and marketplace.json.
MUST: Add `version: 3.0.0` to SKILL.md frontmatter.
MUST: Create CHANGELOG.md in repo root.
MUST: Use SemVer for SKILL.md (major: breaking process changes, minor: new features, patch: fixes).
MUST: Note in spec that task-level profile lessons are personalization, NOT version-scoped. Behavior may vary between projects at the same version — this is a feature.
MUST: Sync version between frontmatter and marketplace.json.
MUST NOT: Use CalVer for main SKILL.md (SemVer is ecosystem convention).
MUST NOT: Version companion skills at same cadence — they iterate independently.
VERIFICATION: `version` field in frontmatter. CHANGELOG.md exists with v3.0.0 entry. marketplace.json version matches.

---

## Component: Binding Portability
IMPLEMENTS: P6 (Binding Portability)
DEPENDS ON: Phase 8 (Handoff), AGENTS.md, CLAUDE.md
AGENT INSTRUCTION: Change Phase 8 binding from CLAUDE.md-only to AGENTS.md primary with CLAUDE.md supplement.
MUST: Phase 8 writes binding to AGENTS.md (or creates it) with directory-scoped triggers: `src/auth/AGENTS.md` references the spec's auth section.
MUST: If CLAUDE.md exists, add cross-reference: "See AGENTS.md for active design specs from Edison."
MUST: Keep Claude-specific behaviors in CLAUDE.md only: self-trigger rules, Edison history, memory directives.
MUST: Store sovereign output in `.edison/` — explorations, decisions, profile, evolution log.
MUST NOT: Abandon CLAUDE.md entirely — it remains the right place for Claude Code-specific instructions.
MUST NOT: Write identical content to both files — each serves a different purpose.
VERIFICATION: After handoff, AGENTS.md contains spec references. CLAUDE.md has cross-reference. Both files are well-formed.

---

## Component: Decision Gap Positioning
IMPLEMENTS: P7 (Decision Gap Positioning)
DEPENDS ON: SKILL.md frontmatter, README.md, Check language
AGENT INSTRUCTION: Update positioning language across all touchpoints.
MUST: Change frontmatter description from "Design exploration skill" to "Design decision skill — the phase between brainstorming and building."
MUST: Update README tagline to "The design decision phase that AI skipped."
MUST: Update Check language: "there's a design decision here that scores [X, Y]" not "exploration would save us."
MUST: Add Output Contract section to "Relationship to Other Skills": document IMPLEMENTS/MUST/MUST NOT/VERIFICATION as a published schema any downstream tool can consume.
MUST: Include sovereignty claim: Edison's methodology (research → rounds → synthesis) is Edison's own.
MUST NOT: Rename modes (Check, Explore, Audit stay as-is).
MUST NOT: Name specific competitors (FigJam, Miro, v0) in the skill description — the gap framing should stand without them.
VERIFICATION: Frontmatter says "decision." README says "decision phase." Check output mentions "design decision." Output Contract section exists.

---

## Component: User Signal & Validation Plan
IMPLEMENTS: P8 (User Signal Integration)
DEPENDS ON: Phase 2 (Research), Phase 7 (DEFINITIVE-SPEC.md output format)
AGENT INSTRUCTION: Add proxy signal research category and validation plan to spec output.
MUST: Research question generation (Phase 2) must include at least 1 question from "user signal" category: forum complaints, support tickets, analytics patterns, review sentiment.
MUST: DEFINITIVE-SPEC.md includes `## Validation Plan` section: "After building, test [assumption] with [method]" for each low-confidence decision.
MUST: Frame Edison as pre-prototype — proxy signals are the correct method for this phase.
MUST NOT: Require the developer to conduct user testing during Edison exploration.
MUST NOT: Present the lack of direct user testing as a gap — it's a scoping decision.
VERIFICATION: Research questions include at least 1 user-signal question. DEFINITIVE-SPEC.md has Validation Plan section.

---

## Component: .edison/ Directory Structure
IMPLEMENTS: User request (discoverable output home)
DEPENDS ON: All modes (Check, Explore, Audit)
AGENT INSTRUCTION: All Edison output lives in .edison/ at project root.
MUST: Use this structure:
```
.edison/
├── profile.md              (project identity + lessons)
├── explorations/           (timestamped exploration runs)
│   └── [date]-[feature]/
│       ├── VISION.md
│       ├── RESEARCH-BRIEF.md
│       ├── priorities.md
│       ├── r1/, r2/, r3/
│       ├── R1-SYNTHESIS.md, R2-SYNTHESIS.md
│       └── synthesis/
│           ├── CONVERGENCE.md
│           ├── DEFINITIVE-SPEC.md
│           └── [artifacts]
├── audits/
│   └── [date]-[feature].md
├── evolution-log.md
└── DEVIATIONS.md
```
MUST: Add .edison/ to .gitignore by default (exploration artifacts are development, not source).
MUST NOT: Use deep-exploration/ or any other output directory.
VERIFICATION: Edison creates .edison/ on first run. All outputs land inside it.

---

## Component: Interactive Artifact Review
IMPLEMENTS: User feedback (Kilnside experience)
DEPENDS ON: Phase 8 (Handoff)
AGENT INSTRUCTION: Phase 8 walks through artifacts interactively, not as a file dump.
MUST: Present the synthesized artifact first (DEFINITIVE-SPEC.md).
MUST: Offer to open each round artifact if the user expresses concern about a specific area: "The auth decision came from Round 2's challenge. Want to see the alternatives it considered?"
MUST: Collect feedback per-artifact when reviewing: "Any changes to this section?"
MUST NOT: Open all artifacts unprompted — start with the synthesis, drill down on request.
VERIFICATION: Phase 8 presents synthesis first. User can request per-priority drill-down.

---

## Component: Ecosystem Relationship
IMPLEMENTS: R3 Tension 3 kernel (output contract)
DEPENDS ON: "Relationship to Other Skills" section
AGENT INSTRUCTION: Document Edison's output schema as a published contract.
MUST: Add "Edison's Output Contract" subsection documenting task block fields: IMPLEMENTS, MUST, MUST NOT, VERIFICATION, DEPENDS ON, AGENT INSTRUCTION.
MUST: State: "Any skill that reads markdown with these fields can plan from an Edison spec. No Edison installation required to consume the output."
MUST: Note recommended companion skills (brainstorming for simple decisions, planning skills for implementation) without creating dependencies.
MUST: Include fallback for when referenced skills aren't installed (Edison handles inline).
MUST NOT: Create hard dependencies on any other skill.
MUST NOT: Build an inter-skill protocol — document the output format, let the ecosystem figure out composition.
VERIFICATION: Output Contract section exists. No skill is listed as required.
