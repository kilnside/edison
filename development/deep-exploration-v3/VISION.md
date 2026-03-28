# Edison v3 Vision: Self-Improving Design Exploration

## Core Principles
1. Edison should be capable of recursive self-improvement — a skill that can analyze and redesign itself
2. The v2 exploration was a one-off manual process. V3 should make self-improvement reproducible
3. Edison exists in an ecosystem now (published on GitHub, other skills exist) — it needs to play well with others
4. The distribution model matters — how people find, install, update, and customize Edison
5. Real-world usage feedback should flow back into improvement (not just the creator's opinion)
6. Software-first but not software-only — don't artificially prevent natural evolution to other domains

## The Feeling
Using Edison v3 should feel like the tool is getting smarter with every run. Not just executing a fixed process, but learning from what worked and what didn't — across projects, across users. Like Claude Code improving itself through dogfooding.

## Target Users
- Developers using Claude Code who want to get design right before building (v2 audience)
- Skill authors who might use Edison's architecture as a template for other exploration-type skills
- Teams who share Edison across projects and want consistency
- Returning users whose previous explorations should inform new ones

## Entry Points
- `/edison` or `/deep-dive` — explicit invocation (same as v2)
- Self-trigger on complex design decisions (same as v2)
- `/audit` — checking spec vs code alignment (same as v2)
- Returning users whose previous exploration context should be leveraged

## Anti-Targets
- NOT a general "AI improves AI" framework
- NOT a replacement for the skill marketplace/ecosystem itself
- NOT a replacement for user testing (still pre-build, not post-build)
- NOT expanding handoff/audit specifically for non-software (but don't block it)

## What Changed Since v2
- Published on GitHub under Kilnside org
- Plugin marketplace configuration exists
- Community awareness is nascent but growing (awesome lists, Agent Skills standard)
- The exploration artifacts from v2 exist and demonstrate the methodology
- No real-world usage feedback yet beyond the creator
