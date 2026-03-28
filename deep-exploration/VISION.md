# Edison Vision

## Core Principles
1. AI should do what humans can't — research, synthesize, bring back intelligence the user didn't have
2. Never ask a question you could research the answer to
3. Progressive deepening: each round builds on the last, getting more creative
4. Spare no expense — token-intensive exploration saves tokens long-term by getting it right the first time
5. The spec must be binding — handoff is the most important phase

## The Feeling
Using Edison should feel like having a world-class research team that disappears for a while and comes back with "here's what we found, here's what we think, and here's an idea you never would have had." Not like filling out a form or answering an interview.

## Target Users
Developers using Claude Code (or similar AI coding assistants) who have a vision for a feature or product and want to get the design right before building. They have taste and opinions but know the AI can see more of the landscape than they can.

## Entry Points
- `/edison` or `/deep-dive` — explicit invocation
- Self-trigger when AI detects a complex design decision being made inline
- `/audit` — when checking spec vs code alignment

## Anti-Targets
- This is NOT a project management tool
- This is NOT for simple decisions (use brainstorming for those)
- This is NOT a replacement for user testing (it's pre-build exploration, not post-build validation)
- This is NOT a way to avoid building things (if the check scores 0-1, just build)
