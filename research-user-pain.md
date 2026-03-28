# Edison Research Brief: Developer Pain with AI Design Decisions

**Date:** 2026-03-27
**Scope:** Reddit, Hacker News, developer blogs, industry reports (2025-2026)

---

## Finding 1: AI Assistants Are Too Eager -- They Never Stop to Think

The single most consistent complaint across every source: AI coding tools dive straight into generating code without asking what the developer actually wants.

Pete Hodgson's widely-cited analysis puts it bluntly: AI assistants are **"way too eager to please and impress you -- never challenges your ideas, rarely asks any clarifying questions before diving in."** He describes them as having zero context about your project -- it is **"their first hour on the team."** The result: they **"make design decisions at the level of a fairly junior engineer"** and rarely suggest alternative approaches.

On Hacker News, user **lz400** captured the same feeling: AI is like **"a very eager junior developer who is supremely confident, always says yes, does trivial work in seconds but makes very critical mistakes."**

## Finding 2: Building the Wrong Thing Is the Default Mode

When AI tools skip the exploration phase, they build confidently in the wrong direction. The "70% Problem" article (heavily discussed on HN and Reddit) documents how non-engineers hit a wall: they **"get 70% of the way there surprisingly quickly, but that final 30% becomes an exercise in diminishing returns."** The remaining work requires actual engineering judgment -- understanding architectural decisions and handling edge cases.

Developers report entering a frustrating loop: prompt, get a mediocre result, tweak, re-prompt, repeat. One developer blog describes this as the cycle where **"you try to fix a small bug... the AI suggests a change... this fix breaks something else... this creates two more problems."**

HN user **neilwilson** invoked Fred Brooks: AI tools **"really only help with the accidental tasks... AI can't do the essential work of complexity management."** The 70% it generates fast is the easy part. The 30% it gets wrong is the part that matters.

## Finding 3: Specs Drift from Implementation Within Hours

The spec-to-code pipeline is broken. Multiple sources document that AI agents generating code from specifications produce **"plausible-looking code that's fundamentally wrong"** -- it looks correct but contains structural errors that compound. One analysis of spec-driven development tools found that **"most spec-driven tools produce static documents that drift from implementation within hours."**

The TraycerAI team states plainly: AI agents **"drift, hallucinate, and generate confident garbage"** without structured guardrails, and that **"vague scope produces vague output."**

## Finding 4: Token Waste from Rework Is a Real Cost

The financial pain is measurable. One comparison found Claude Code used **5.5x fewer tokens than Cursor** for identical tasks, largely because it produced **30% less code rework** -- getting things right on the first or second iteration. Cursor users report the tool frequently ignoring `.cursorrules` files, acknowledging coding conventions and then generating code that violates them.

HN user **godelski** reframed the productivity promise entirely: **"Actually the big problem I have with coding with LLMs is that it increases my cognitive load, not decreases it."** The review-and-debug cycle from AI-generated code often costs more effort than writing it would have.

## Finding 5: The Industry Is Starting to Name This Problem

By early 2026, "spec-driven development" has emerged as a category name. Java Code Geeks published a piece calling the old approach **"prompt and pray."** Augment Code lists 6+ tools specifically designed to keep AI implementations anchored to specifications. IEEE Spectrum reported on **"silent failures"** in AI coding quality. The pattern is clear: the industry recognizes that the gap between "what should be built" and "what gets built" is the central unsolved problem.

---

## This Matters Because

Edison exists precisely in this gap. Every finding above maps to a specific Edison capability:

| Pain Point | Edison Response |
|---|---|
| AI never asks clarifying questions | Check mode: 5-question gate before any code |
| Building the wrong thing confidently | Explore mode: parallel agents examine alternatives before committing |
| Specs drift from implementation | Audit mode: compare spec against actual codebase |
| Wasted tokens from rework | Phase 8 handoff: specs become build contracts, not suggestions |
| "Prompt and pray" as default workflow | Edison fires automatically on design decisions -- low trigger threshold |

The developer community is loudly articulating a need for something between "just ask the AI" and "write a 20-page PRD yourself." They want the AI to slow down, think, explore alternatives, and produce a contract that survives contact with implementation. That is Edison's entire value proposition.

---

## Sources

- [The 70% Problem: Hard truths about AI-assisted coding](https://addyo.substack.com/p/the-70-problem-hard-truths-about) (Substack)
- [Why Your AI Coding Assistant Keeps Doing It Wrong](https://blog.thepete.net/blog/2025/05/22/why-your-ai-coding-assistant-keeps-doing-it-wrong-and-how-to-fix-it/) (Pete Hodgson)
- [How We Prevent AI Agent Drift & Code Slop](https://dev.to/singhdevhub/how-we-prevent-ai-agents-drift-code-slop-generation-2eb7) (DEV Community)
- [The AI Coding Trap](https://news.ycombinator.com/item?id=45405177) (Hacker News)
- [The 70% Problem discussion](https://news.ycombinator.com/item?id=42336553) (Hacker News)
- [Spec-Driven Development: Replacing "Prompt and Pray"](https://www.javacodegeeks.com/2026/03/spec-driven-developmentwith-ai-coding-agents-the-workflow-replacingprompt-and-pray.html) (Java Code Geeks)
- [AI Coding Degrades: Silent Failures Emerge](https://spectrum.ieee.org/ai-coding-degrades) (IEEE Spectrum)
- [Best Spec-Driven Development Tools for AI Coding 2026](https://www.augmentcode.com/tools/best-spec-driven-development-tools) (Augment Code)
- [Cursor Ate My Token Budget, Claude Code Gave It Back](https://levelup.gitconnected.com/cursor-ate-my-token-budget-claude-code-gave-it-back-982887b02670) (Level Up Coding)
