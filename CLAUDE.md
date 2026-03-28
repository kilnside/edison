# Edison Skill Development

## What This Is

Edison is a Claude Code skill for design exploration. The live skill file is `SKILL.md`.

## Repository Structure

- `SKILL.md` — The skill itself. This is what users install.
- `README.md` — Public-facing documentation.
- `.claude-plugin/` — Plugin marketplace configuration.
- `development/` — Exploration artifacts from Edison's self-design process (Edison was designed by running Edison on itself).

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
