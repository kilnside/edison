# Competitive Landscape: Design-Before-Code Tools

Research brief produced 2026-03-27 for the Edison skill.

---

## 1. Spec-Driven IDEs

**Kiro** (AWS, launched mid-2025) is Edison's closest philosophical competitor. Kiro turns natural-language prompts into structured specs using EARS notation (GIVEN/WHEN/THEN acceptance criteria), then generates an architecture document, then creates sequenced implementation tasks. The entire pipeline is version-controlled markdown. What it does well: specs are first-class artifacts that persist and guide implementation. Where it falls short: the exploration is single-path -- Kiro generates one set of requirements, one architecture, one task list. There is no parallel exploration, no progressive deepening, and no research phase that scans what users actually want. It is a specification tool, not an exploration tool.

**Augment Intent** (Augment Code, 2025-2026) is the most direct multi-agent competitor. Intent uses a three-agent architecture (Coordinator, Specialists, Verifier) where a coordinator drafts a spec, fans work to parallel implementor agents, then a verifier checks results against the spec. Its key innovation is the "living spec" -- a bidirectional document that updates when requirements change AND when agents complete work. What it does well: living specs solve Edison's handoff problem (Phase 8) by keeping the spec synchronized with reality automatically. Where it falls short: Intent is an implementation orchestrator, not a design explorer. It does not run multiple rounds of progressively deeper exploration or research user pain points. The spec is written once by a coordinator, not discovered through 3 rounds of literal/creative/wild takes.

## 2. Planning-First Workflows in Coding Tools

**Cursor Plan Mode** (Cursor 2.0, October 2025) lets users generate an editable markdown plan before any code is written. The plan includes architecture, data flow, and a task list. Users iterate on the plan, save it to the repo, then execute it. What it does well: separates thinking from building, and the plan persists as a repo artifact. Where it falls short: the plan is a single linear document -- no parallel exploration, no research phase, no progressive deepening. It is closer to Edison's Mode 1 (Check) than Mode 2 (Explore).

**GitHub Copilot Workspace** generates a current-state/desired-state specification, then a file-level implementation plan. Users can edit both before code generation begins. What it does well: two steering points (spec and plan) give users control without writing code. Where it falls short: the specification describes what to change, not what to build. It is a change-management tool, not a design exploration tool. No user research, no competitive analysis, no alternative generation.

## 3. Full-Lifecycle Spec Frameworks

**BMAD-METHOD** (open source, actively developed) is the most comprehensive spec-driven framework. It orchestrates a full pipeline: Analyst creates a brief, PM creates a PRD, Architect designs the system, UX Designer creates user flows, Scrum Master generates stories. It offers three tracks (Quick, Standard, Enterprise) and uses YAML-based workflow orchestration. What it does well: role-based agent specialization and the full documentation pipeline from concept to sprint stories. Where it falls short: the pipeline is sequential and single-path. Each role produces one artifact. There is no mechanism for parallel exploration of alternatives, no progressive deepening, and no research phase that scans real user pain or competitive gaps.

**GitHub Spec Kit** (open source, September 2025) provides templates and tooling for spec-driven development that works across agents (Copilot, Claude Code, Gemini CLI). It is a lightweight toolkit, not an opinionated methodology. What it does well: agent-agnostic, composable, low-friction. Where it falls short: it provides structure but not intelligence -- no research, no exploration, no synthesis.

## 4. Prototyping Tools (v0, Bolt.new, Lovable)

These tools generate working UI from prompts. Bolt.new has an explicit "reasoning tokens" phase before code generation. v0 generates components from descriptions. What they do well: rapid tangible output that can be evaluated visually. Where they fall short: they skip the design decision entirely. The user must already know what they want. No exploration of alternatives, no user research, no spec binding. They are execution accelerators, not design tools.

## 5. Multi-Agent Parallel Development

**VS Code Multi-Agent** (February 2026) and **Codex subagents** (OpenAI) both support spawning parallel agents for implementation. These are infrastructure capabilities, not design methodologies. They parallelize coding, not thinking.

---

## How Edison Differs

No tool found combines all three of Edison's distinctive elements:

1. **Research phase that scans the real world.** Edison's Phase 2 launches parallel agents to scan user pain, competitive landscape, niche gaps, technical patterns, and user expectations. No competitor does primary research before designing. Kiro, BMAD, and Intent all start from the developer's prompt -- they structure what the developer already knows but do not bring back intelligence the developer did not have.

2. **Progressive deepening across rounds.** Edison's three rounds (Literal, Creative, Wild) build on each other. Round 1 finds the sensible path. Round 2 challenges assumptions. Round 3 inverts them. Per-priority synthesis picks the best answer from any round. Competitors generate a single spec from a single pass.

3. **Binding specs to implementation with audit capability.** Edison's Phase 8 handoff writes the spec into CLAUDE.md and creates a verification checklist. Mode 3 (Audit) can later diff spec vs. code. Intent's living spec is the closest alternative, but it is automatic and bidirectional -- which means the spec drifts with the code rather than holding the code accountable to the design.

## This Matters Because

The competitive landscape has converged on "spec-driven development" as the answer to vibe coding. Kiro, BMAD, Spec Kit, and Intent all represent this thesis. But they all share a blind spot: they structure the developer's existing intent without challenging it. Edison is the only tool that treats design exploration as a research problem -- scanning the world for what users actually want before proposing what to build. The risk is that Edison's token cost (400-700K per exploration) prices it out of casual use. The opportunity is that for high-stakes design decisions, no competitor offers anything close to Edison's depth.

---

Sources:
- [Kiro: Agentic AI development](https://kiro.dev/)
- [Kiro and the future of AI spec-driven development](https://kiro.dev/blog/kiro-and-the-future-of-software-development/)
- [Intent: A workspace for agent orchestration (Augment Code)](https://www.augmentcode.com/blog/intent-a-workspace-for-agent-orchestration)
- [How to Write Living Specs for AI Agent Development (Augment Code)](https://www.augmentcode.com/guides/living-specs-for-ai-agent-development)
- [GitHub Spec Kit](https://github.com/github/spec-kit)
- [Spec-driven development with AI (GitHub Blog)](https://github.blog/ai-and-ml/generative-ai/spec-driven-development-with-ai-get-started-with-a-new-open-source-toolkit/)
- [Copilot Workspace (GitHub Next)](https://githubnext.com/projects/copilot-workspace)
- [BMAD-METHOD (GitHub)](https://github.com/bmad-code-org/BMAD-METHOD)
- [Understanding Spec-Driven Development: Kiro, spec-kit, and Tessl (Martin Fowler)](https://martinfowler.com/articles/exploring-gen-ai/sdd-3-tools.html)
- [VS Code Multi-Agent Development](https://code.visualstudio.com/blogs/2026/02/05/multi-agent-development)
- [Cursor 2.0 Guide](https://atalupadhyay.wordpress.com/2025/10/30/cursor-2-0-the-ultimate-guide-to-ai-powered-coding/)
- [AI coding tools face 2026 reset towards architecture](https://itbrief.news/story/ai-coding-tools-face-2026-reset-towards-architecture)
- [Best Spec-Driven Development Tools (Augment Code)](https://www.augmentcode.com/tools/best-spec-driven-development-tools)
- [How AI Prototyping Tools Actually Work (Bolt architecture)](https://amankhan1.substack.com/p/how-ai-prototyping-tools-actually)
