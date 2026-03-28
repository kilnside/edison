# Privacy policy

Edison is a Claude Code skill. It runs locally on your machine as markdown instructions interpreted by your AI coding assistant. Edison has no server, no analytics, no telemetry, and no account system.

## What stays on your machine

- `.edison/profile.md` (project context and preferences)
- `.edison/explorations/` (design exploration artifacts)
- `.edison/audits/` (spec vs code gap analyses)
- `.edison/evolution-log.md` (run history)
- Observations deposited into Claude Code's local memory system

Edison does not transmit any of this data. These files live in your project directory and your local Claude Code configuration. They are not synced, uploaded, or shared.

## What leaves your machine

Edison uses your AI coding assistant's built-in web search to research design decisions during the Explore phase. These searches go through whatever search provider your AI assistant uses. Edison does not control or log these searches.

The Edison Evolve companion skill can optionally submit a GitHub issue to the Edison repository (github.com/kilnside/edison) when you choose to share a universal improvement. This only happens when you explicitly say yes. The issue contains the improvement description and supporting evidence from your exploration. It is submitted using your own GitHub credentials via the `gh` CLI. Edison does not have access to your GitHub token.

## What Edison does not do

- Collect usage analytics or telemetry
- Phone home to any server
- Access files outside your project directory and `~/.claude/`
- Store or transmit API keys, credentials, or secrets
- Run background processes when not invoked
- Share data between users

## Third-party services

Edison itself has no third-party service dependencies. Your AI coding assistant (Claude Code, Cursor, etc.) has its own privacy policy that governs how it processes the skill's instructions and your project data.

## Changes

If this policy changes, the change will be noted in CHANGELOG.md with the version that introduced it.

## Contact

Questions: open an issue at github.com/kilnside/edison
