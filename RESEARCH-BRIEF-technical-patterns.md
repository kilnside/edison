# Technical Patterns for Multi-Agent Exploration Systems

Research brief for Edison skill development. 2026-03-27.

---

## 1. Multi-Agent Architectures: What Works

The dominant production pattern is **orchestrator-worker**: a central agent decomposes tasks, delegates to specialized workers, collects results, and synthesizes. This maps directly to Edison's structure where the main agent launches per-priority subagents and then synthesizes across rounds. Microsoft AutoGen, AgentVerse, and LangGraph all converge on this topology.

**Heterogeneous agents outperform homogeneous ones.** The Adaptive Heterogeneous Multi-Agent Debate (A-HMAD) framework (Springer, 2025) showed that replacing specialized agents with identical ones drops performance by up to 3.5% on reasoning tasks, and learned consensus improves final accuracy by 5% when agents disagree. This validates Edison's Literal/Creative/Wild persona differentiation -- the value comes specifically from agents having *different* reasoning orientations, not just running the same prompt multiple times.

**Debate improves factuality but has diminishing returns.** Du et al. (2023) established that multi-agent debate significantly improves mathematical and strategic reasoning. However, a 2025 study on requirements engineering found that adding iterative debate rounds doubled token cost for only +0.006 F1 improvement. The first round of disagreement captures most of the value. Edison's three-round structure (Literal, Creative, Wild) works better than iterative debate precisely because each round has a *different mission* rather than re-debating the same question.

## 2. Progressive Deepening vs. Parallel Exploration

A controlled study with 148 participants (PLOS ONE, 2025) directly compared deepening (building on existing ideas) against exploration (introducing new perspectives) in human-AI creative collaboration. The deepening strategy significantly outperformed exploration in both trust-building (competence trust: 4.79 vs 4.04) and idea adoption (6.98 vs 5.22 ideas adopted).

**This matters because** Edison's progressive deepening (Round 1 establishes foundation, Round 2 refines, Round 3 provokes) is backed by evidence. The research suggests that building sequentially on prior rounds produces more trusted and adopted outputs than running three independent parallel explorations. The key mechanism: predictable, buildable-upon behavior creates trust, which drives adoption.

## 3. Persona Prompting: When It Helps, When It Hurts

Research from SearchEngineJournal (2025) and LearnPrompting shows a critical split: persona prompting consistently improves *alignment-dependent* tasks (writing, tone, creativity, format adherence) while *degrading* factual accuracy and reasoning benchmarks. Adding "you are an expert" activates instruction-following mode that prioritizes style over factual recall.

**This matters because** Edison's Round 1 (Engineer) needs factual accuracy about implementation tradeoffs, while Round 3 (Provocateur) needs creative divergence. The research suggests Round 1 agents should get minimal persona framing and heavy technical context, while Round 3 agents benefit from strong persona prompts with creative constraints ("What if there's no home page?"). Edison's own analysis in `edison-on-edison.md` already identified that Round 3 quality depends on creative constraints -- the research confirms this is a real phenomenon, not anecdotal.

## 4. Token Optimization Strategies

Multi-agent systems face steep cost multipliers. Research from Stevens (2025) found that unconstrained agent loops can consume 50x the tokens of a single pass, and enterprise agents cost $5-8 per task. Three strategies matter for Edison:

- **Prompt caching**: Reusing the vision document and research brief across agents reduces input costs by ~90%. Claude Code's subagent architecture already benefits from this when the same base context is passed to multiple parallel agents.
- **Hierarchical model routing**: Running the main orchestrator on Opus while subagents run on Sonnet cuts costs significantly. Claude Code's subagent system supports per-agent model selection via the `model` frontmatter field.
- **Context pruning**: Passing only the relevant synthesis to subsequent rounds, not all raw outputs. Edison already does this (R1-SYNTHESIS feeds Round 2, not all R1 analyses).

A financial document processing benchmark (arXiv, March 2026) found hierarchical architectures achieve 98.5% of best accuracy at 60.7% of cost -- validating the orchestrator-worker pattern Edison uses.

## 5. The Spec Drift Problem

InfoQ's coverage of Spec-Driven Development (2025) frames the core insight: in AI-assisted workflows, drift is no longer an edge case but the natural state. Specifications must shift from "passive reference material to active control surfaces." The recommended approach: executable specs with continuous enforcement through contract tests, schema validation, and drift detection.

**This matters because** Edison's Phase 8 handoff and Mode 3 audit directly address this. The Kilnside case study (51% spec coverage) confirms the problem is real. The research suggests Edison should go further: the spec itself could include machine-readable assertions, not just human-readable descriptions, enabling automated drift detection rather than manual audit.

## 6. Design-to-Implementation Handoff

UXPin and Miro research (2025-2026) converges on key principles: treat handoff as ongoing collaboration not one-time transfer, break into feature-based components rather than full deliverables, and ensure context travels with the work. The strongest recommendation: connect at the wireframe stage rather than after polished designs.

**This matters because** Edison's current handoff (link spec in CLAUDE.md, create checklist) is a good start but is still a one-time transfer. The research suggests the spec should be decomposed into per-component implementation contracts that implementation agents consume directly, not a monolithic document that agents must interpret.

## 7. Claude Code Subagent Capabilities

Claude Code's subagent system (documented at code.claude.com) provides the exact infrastructure Edison needs:
- **Parallel execution**: Multiple Agent tool calls in a single message execute concurrently
- **Per-agent model selection**: `model: sonnet` for research agents, `model: opus` for synthesis
- **Tool restrictions**: Read-only agents for research, full access for implementation
- **Persistent memory**: Subagents can accumulate knowledge across sessions via the `memory` field
- **Isolation**: The `isolation: worktree` option gives agents their own repo copy
- **Skills injection**: The `skills` field preloads domain knowledge into subagent context
- **Subagents cannot spawn subagents** -- this is a hard constraint. Edison's orchestrator must remain the main conversation.

The recommended ceiling is 3-4 specialized agents running in parallel. Edison's 5-10 per round may push this, though the tasks are well-scoped and independent.

---

## Key Takeaways for Edison

1. **The progressive deepening model is validated** by creativity research. Keep the sequential round structure.
2. **Heterogeneity is the value driver.** Make Round 1/2/3 prompts maximally different, not variations on a theme.
3. **Minimize persona framing in Round 1** (factual accuracy matters), maximize it in Round 3 (creative divergence matters).
4. **First-round disagreement captures most value.** Don't add iterative debate; the three distinct missions are more efficient.
5. **Model routing is free optimization.** Run research agents on Sonnet, synthesis on Opus.
6. **Spec handoff should be decomposed.** Per-component contracts beat monolithic specs for preventing drift.
7. **Consider machine-readable spec assertions** that enable automated drift detection beyond manual Mode 3 audits.

---

Sources:
- [A-HMAD: Adaptive Heterogeneous Multi-Agent Debate (Springer, 2025)](https://link.springer.com/article/10.1007/s44443-025-00353-3)
- [Deepening Ideas vs. Exploring New Ones (PLOS ONE, 2025)](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0340449)
- [Multi-Agent Debate for Requirements Engineering (ACL, 2025)](https://arxiv.org/html/2507.05981v1)
- [Improving Factuality through Multiagent Debate (Du et al., 2023)](https://arxiv.org/abs/2305.14325)
- [Benchmarking Multi-Agent LLM Architectures (arXiv, March 2026)](https://arxiv.org/html/2603.22651)
- [Spec Driven Development (InfoQ, 2025)](https://www.infoq.com/articles/spec-driven-development/)
- [Hidden Economics of AI Agents (Stevens, 2025)](https://online.stevens.edu/blog/hidden-economics-ai-agents-token-costs-latency/)
- [Role Prompting Research (SearchEngineJournal, 2025)](https://www.searchenginejournal.com/research-you-are-an-expert-prompts-can-damage-factual-accuracy/570397/)
- [Claude Code Subagent Documentation](https://code.claude.com/docs/en/sub-agents)
- [AI Design-to-Code Handoff (UXPin, 2025)](https://www.uxpin.com/studio/blog/how-ai-simplifies-design-to-code-handoff/)
