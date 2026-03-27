# Edison Skill Development

## What This Project Is

This is the development workspace for the Edison skill -- a methodology for getting design decisions right before writing code. The live skill file lives at `~/.claude/skills/edison/SKILL.md`.

## Files

- `SKILL.md` -- working copy of the Edison skill (edit this, copy to ~/.claude/skills/edison/ when ready)
- `edison-on-edison.md` -- analysis of Edison's failure modes and the 3-mode proposal
- `case-study-gap-analysis.md` -- real example of what happens when Edison's handoff fails (Kilnside v3)

## Development Workflow

1. Edit `SKILL.md` in this directory
2. Test by running `/edison` in any project
3. When satisfied, copy to `~/.claude/skills/edison/SKILL.md`

## Key Design Principles

- Edison has 3 modes: Check (gate), Explore (deep dive), Audit (spec vs code)
- The handoff (Phase 8) is the most important phase -- specs must become build contracts
- Trigger sensitivity should be low -- fire on design decisions, not every new file
- The user is always right -- every mode is advisory
