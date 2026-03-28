# Changelog

All notable changes to Edison are documented here. Format follows [Keep a Changelog](https://keepachangelog.com/).

## [3.0.0] - 2026-03-28

### Added
- Spec compression: body (~280 lines) + resources/ for execution detail (Agent Skills compliance)
- Edge case hardening: fallback clauses for 8 undefined behaviors (null research, all-MURKY, etc.)
- Self-improvement architecture: Run Metadata in CONVERGENCE.md + companion skill edison-evolve (separate)
- Cross-project learning: deposit observations to Claude Code memory during synthesis
- Binding portability: AGENTS.md primary, CLAUDE.md supplement
- Decision gap positioning: "Design decision skill — the phase between brainstorming and building"
- User signal integration: mandatory proxy signal research + Validation Plan in output
- .edison/ as canonical output directory for all modes
- Interactive artifact review: synthesis-first with drill-down on request
- Output contract: published schema for DEFINITIVE-SPEC.md task blocks
- Version field in frontmatter
- Self-score mapping: 1-2=MURKY, 3=CONTESTED, 4-5=RESOLVED

### Changed
- Output directory: deep-exploration/ → .edison/explorations/
- Binding target: CLAUDE.md only → AGENTS.md primary with CLAUDE.md supplement
- Frontmatter description: "Design exploration skill" → "Design decision skill"
- Check language: "exploration would save us" → "there's a design decision here"
- Vision Capture clarified as synthesis, not interrogation
- Final Synthesis conditional on available rounds (Focused path no longer references R3)
- Steering is non-blocking; Gates are blocking by design (clarified)

### Removed
- Redundant hard trigger rule (Interconnected + Irreversible already meets 2+ threshold)
- Inline self-improvement mechanism (externalized to companion skill)

## [2.0.0] - 2026-03-27

### Added
- Three-mode architecture: Check, Explore, Audit
- Research-first progressive deepening (3 rounds)
- Per-priority graduation (RESOLVED/CONTESTED/MURKY)
- Self-executing specs with MUST/VERIFICATION task blocks
- Analytical lenses for Round 2
- Tension-based Round 3
- Project scanning and profile system
- Review gate (Adversary + New Hire)

## [1.0.0] - 2026-03-27

- Initial Edison implementation (single Explore mode)
