# Niche Gaps Research Brief: Edison Skill

**Research date:** 2026-03-27
**Mission:** Identify underserved needs in AI-assisted design exploration and decision-making.

---

## 1. The Spec-to-Code Handoff Is Now a Recognized Industry Problem

Spec-driven development (SDD) has emerged as a named methodology in 2025-2026, with GitHub releasing Spec Kit (open-source, v0.1.4 as of Feb 2026) and Tessl raising $125M at a $500M+ valuation to build "spec-as-source" development where humans maintain specs and AI generates all code. An ArXiv paper ([2602.00180](https://arxiv.org/abs/2602.00180)) formalizes the concept. Amazon launched Kiro (July 2025) as an AI-native IDE with built-in SDD support.

**The gap Edison fills:** These tools focus on *generating* code from specs. None of them address the *exploration* phase -- how you arrive at the right spec in the first place. Spec Kit assumes you already know what to build. Edison's Mode 2 (Explore) is the missing upstream phase, and Mode 3 (Audit) is the missing downstream verification loop. The combination of explore-then-enforce is unique.

## 2. Design Consistency Over Long Projects Is an Unsolved Problem

Multiple sources confirm that specifications become outdated within weeks because implementation moves faster than documentation. "Interpretation drift" -- where different agents or sessions implement the same requirements inconsistently -- is a recognized pattern with no widely adopted tooling solution. The InfoQ article on SDD notes that enforcement requires "contract tests, schema validation, and architectural drift detection" but no tool packages these for AI-agent workflows.

**The gap Edison fills:** Edison's CLAUDE.md binding (Phase 8) and Audit mode (Mode 3) directly attack drift. The Kilnside v3 case study is a textbook example: 51% spec coverage, 4 structural contradictions. No other Claude Code skill or SDD tool provides a built-in audit-and-realign loop.

## 3. Non-Traditional "Design Decisions" Are Invisible to Current Tools

The industry conversation about AI design tools is overwhelmingly focused on visual design (Figma AI, v0, frontend components). Architecture decisions, data modeling, API surface area, error handling strategies, and state management patterns are rarely framed as "design" -- yet they benefit enormously from systematic exploration. The State of AI in Design report confirms 84% of AI usage happens in early exploration phases, but this is measured in visual/UX design contexts, not software architecture.

**The gap Edison fills:** Edison's trigger logic fires on *any* design decision -- including architectural ones. The 5-question Check (Mode 1) asks "is this interconnected?" and "is this the first of its kind?" -- questions equally relevant to a database schema as to a button color. This framing is genuinely novel in the skill ecosystem.

## 4. Solo Developers Need Exploration More, Not Less

Survey data shows 1 in 3 indie SaaS founders use AI for 70%+ of their workflows. Solo developers practice "ruthless prioritization" and MVP thinking. But the risk is higher for solo developers: there is no team to catch bad architectural decisions early, and 96% of designers learn AI tools through self-teaching with no structured process.

**The gap Edison fills:** Edison's cost warning ("400-700K tokens") may scare solo developers, but the 2-round scaling option (skip Round 3 for moderate stakes) makes it accessible. More importantly, solo developers lack the team discussion that naturally surfaces design alternatives -- Edison's multi-agent parallel exploration simulates that team discussion. No other tool provides this for a solo context.

## 5. The Claude Code Skill Ecosystem Is Large but Shallow

The ecosystem has grown from ~50 skills in mid-2025 to 334+ indexed skills (85,000+ across platforms) by March 2026. Most fall into two categories: "capability uplift" (giving Claude new abilities) and "encoded preferences" (making Claude follow specific patterns). Skill activation reliability is a known problem -- optimization can improve activation from 20% to 90%. Context budget constraints (2% of context window, ~16K char fallback) limit skill complexity.

**The gap Edison fills:** Edison is neither a simple capability uplift nor an encoded preference. It is a *workflow* skill -- a multi-phase process with gates, parallel agents, and persistent artifacts. Very few skills in the ecosystem attempt this level of orchestration. The closest comparisons are GSD (the project management skill visible in this workspace) and Superpowers' brainstorming skill, but neither combines research, progressive deepening, and spec-binding.

## 6. Skill Authors Face Real Structural Limitations

Key frustrations reported by the community:
- Skills do not improve over time on their own; they produce inconsistent outputs as context varies
- Rate limits constrain token-intensive skills (Max 5x users report burning through limits in 90 minutes)
- No built-in mechanism for skills to persist state across sessions
- Editor support is limited to VS Code and JetBrains
- Activation reliability requires careful description engineering

**What this means for Edison:** The token cost of Mode 2 (30+ subagents, 400-700K tokens) collides directly with rate limit frustrations. Edison needs to be worth the cost every time it fires, which reinforces the importance of Mode 1's gate (only escalate when the Check scores 2+). The lack of cross-session state persistence also means Edison's CLAUDE.md binding strategy is the *correct* architectural choice -- it uses the one persistence mechanism that reliably survives session boundaries.

---

## This Matters Because

Edison occupies a genuinely underserved position in the AI development tool landscape. The industry is converging on spec-driven development as the answer to AI code quality, but the exploration phase (how you get to the right spec) and the audit phase (verifying the spec was followed) are both gaps. GitHub Spec Kit, Kiro, and Tessl all assume you know what to build. Edison is the tool for when you do not yet know -- and for verifying afterward that what you built matches what you decided.

The competitive moat is the combination: explore (upstream) + bind (handoff) + audit (downstream). No single tool or skill currently packages all three.

---

## Sources

- [GitHub Spec Kit](https://github.com/github/spec-kit)
- [Spec-driven development with AI - GitHub Blog](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)
- [ArXiv: Spec-Driven Development paper](https://arxiv.org/abs/2602.00180)
- [Spec-Driven Development - InfoQ](https://www.infoq.com/articles/spec-driven-development/)
- [State of AI in Design Report 2025](https://www.stateofaidesign.com/)
- [Stack Overflow Developer Survey 2025](https://stackoverflow.blog/2025/12/29/developers-remain-willing-but-reluctant-to-use-ai-the-2025-developer-survey-results-are-here/)
- [AI-Assisted Development in 2026 - DEV Community](https://dev.to/austinwdigital/ai-assisted-development-in-2026-best-practices-real-risks-and-the-new-bar-for-engineers-3fom)
- [Best Claude Code Skills 2026 - OpenAIToolsHub](https://www.openaitoolshub.org/en/blog/best-claude-code-skills-2026)
- [10 Must-Have Skills for Claude 2026 - Medium](https://medium.com/@unicodeveloper/10-must-have-skills-for-claude-and-any-coding-agent-in-2026-b5451b013051)
- [Claude Code Skill Activation Guide - GitHub Gist](https://gist.github.com/mellanon/50816550ecb5f3b239aa77eef7b8ed8d)
- [awesome-claude-skills - GitHub](https://github.com/travisvn/awesome-claude-skills)
- [Anthropic Official Skills Repository](https://github.com/anthropics/skills)
- [Claude Code Rate Limit Complaints - MacRumors](https://www.macrumors.com/2026/03/26/claude-code-users-rapid-rate-limit-drain-bug/)
- [AI-First SDLC for Indie Hackers - Calmops](https://calmops.com/indie-hackers/ai-first-software-development-lifecycle-for-indie-hackers/)
- [The 2026 Skill Economy - Stormy AI](https://stormy.ai/blog/2026-skill-economy-claude-mcp-marketing-skills)
- [Tessl / Spec-as-Source - Thoughtworks](https://thoughtworks.medium.com/spec-driven-development-d85995a81387)
