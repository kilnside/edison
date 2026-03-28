# Edison Skill Development

## What This Is

Edison is a Claude Code skill for design exploration. The live skill file is `SKILL.md`.

## Repository Structure

- `SKILL.md` — The skill itself. This is what users install.
- `resources/` — Execution detail loaded on demand (explore-phases.md, audit-process.md).
- `README.md` — Public-facing documentation.
- `.claude-plugin/` — Plugin marketplace configuration.
- `development/` — Exploration artifacts from Edison's self-design process (Edison was designed by running Edison on itself).

## Active Design Specs

- **Edison v3**: `development/deep-exploration-v3/synthesis/DEFINITIVE-SPEC.md`
  - When editing `SKILL.md`, read the Spec Structure and Edge Case Hardening components FIRST
  - When editing `resources/`, read the Spec Structure component FIRST
  - When editing Phase 8 (Handoff), read Binding Portability and Interactive Artifact Review components FIRST
  - When editing Phase 0 or profile logic, read Cross-Project Learning component FIRST
  - When editing frontmatter or README, read Decision Gap Positioning component FIRST

## Contributing

1. Edit `SKILL.md`
2. Copy to `~/.claude/skills/edison/SKILL.md` for local testing
3. Test by running `/edison` in any project
4. Submit a PR with a description of what changed and why

## Design Principles

- Edison should research, not interrogate
- Be honest about when Edison is NOT the right tool
- Token cost is a feature, not a bug — but always be transparent about it
- The spec must be self-executing — no bridge artifacts
- The user is always right
- Identity stack: tenant (memory), citizen (output/binding), sovereign (methodology/category)
- Self-improvement is meta-behavior — externalize to companion skill, don't embed in execution spec
