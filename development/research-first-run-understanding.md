# Research Brief: First-Run Project Understanding in AI Coding Tools

Generated 2026-03-27 for Edison skill development.

---

## How Current Tools Handle First-Run

**Cursor** indexes your entire codebase into embeddings automatically on first open. It chunks code into segments, calculates embeddings (local or private cloud), and builds a semantic search index -- all in the background within 5-10 minutes for medium repos. The user does nothing. When you later prompt, Cursor searches this index for relevant snippets and packages them into the LLM context window. The key design choice: indexing is invisible and non-blocking. You can start working immediately while it runs.

**GitHub Copilot** (in VS Code) automatically indexes every workspace you open using a remote index built from the committed state of the repo. It uses a hybrid approach: remote index for committed code, local file tracking for uncommitted changes, plus VS Code's language intelligence (IntelliSense, LSP) for symbol resolution and cross-file references. Like Cursor, this is invisible to the user. Copilot Workspace (the task-planning product, now sunset) took a different approach -- it read issue context + repo structure to build a "session plan" before writing code.

**Augment Code** goes deepest. Its Context Engine semantically indexes your codebase, commit history, external docs, tickets, and "tribal knowledge." It understands cross-repo relationships and runs multiple embedding searches on every keystroke. The tagline: "context is the new compiler." They also ship a Context Engine MCP server, making their index available to any AI tool.

**Kiro** (AWS) uses "steering files" -- developer-authored markdown that bootstraps the agent with project structure, tech stack, and conventions. Onboarding a new project means creating these files. This is the opposite of automatic indexing: it requires human effort upfront but produces higher-signal context. Kiro then uses specs (requirements to stories to acceptance criteria to tasks) as the ongoing context backbone.

**BMAD-METHOD** takes a persona-based approach where each agent has defined role boundaries and explicit access permissions to context. Bootstrap is file-based context passing -- structured handoffs between specialized agents rather than a single indexing step.

**GSD** (Claude Code skill) uses `/gsd:new-project` -- a guided process that asks questions, starts research agents, defines requirements, and generates a roadmap. It explicitly says "come prepared with a detailed description" and warns that the more specific you are upfront, the fewer follow-ups needed. GSD also uses `/gsd:map-codebase` to analyze code with parallel mapper agents producing structural documents.

## What Developers Actually Expect (and Hate)

The 2025 Stack Overflow survey found 45% of developers cite "almost-right but not-quite" AI output as their top frustration. The root cause is inadequate context. Critically, **54% of developers who manually select context say the AI still misses relevance**, but this drops to **33% with autonomous context selection** and **16% when context persists across sessions**.

The METR study revealed a perception gap: developers believed AI sped them up 20% when it actually slowed experienced developers by 19%. The friction comes from the learning curve of teaching the tool about your project -- 1-2 weeks of struggling before payoff.

What frustrates developers most about tools that lack project understanding: refactoring tasks fail hardest because they depend on broad codebase awareness. The more a task requires understanding relationships between components, the more likely AI is to miss the mark.

## How Much Context Is Actually Needed?

Sourcegraph's research on building Cody found that **quality of context retrieval matters more than quantity**. More data does not mean better understanding -- as context grows, accuracy can drop. What matters:

1. **Architectural awareness** -- API contracts, dependency graphs, service boundaries
2. **Pattern recognition** -- how existing code solves similar problems
3. **Relationship mapping** -- how files connect across the system

The practical minimum: structured information about architecture, dependencies, and conventions. Not a full index -- a map.

## Research Papers

"Understanding Codebase like a Professional" (arxiv 2504.04553, 2025) studied how code auditors -- professionals who routinely onboard to new codebases -- develop comprehension. Their CodeMap system mirrors the human approach: build a structural map first, then drill into specifics. The paper notes that while LLMs are good at explaining code snippets, **limited research has explored full codebase understanding**, which is the harder and more valuable problem.

---

## This Matters Because

Edison's first-run problem sits at a specific intersection: it is not an IDE (no embedding infrastructure), not a persistent service (no background indexing), and not a project scaffolder (projects already exist). Edison is a Claude Code skill invoked on demand. That constrains the design:

1. **No silent indexing.** Edison cannot run embeddings in the background. Whatever context it gathers must happen in-session, visibly, within the token budget.

2. **The spectrum runs from "ask nothing" to "ask everything" -- and both extremes fail.** Cursor/Copilot ask nothing (automatic indexing). Kiro/GSD ask a lot (steering files, detailed descriptions). The research says autonomous context selection beats manual selection (33% vs 54% frustration), but persistent context beats both (16%). Edison should gather context once, persist it, and reuse it.

3. **A map beats a full index.** Sourcegraph's finding that context quality beats quantity aligns with Edison's token-conscious design. Edison does not need to understand every file. It needs: tech stack, architecture shape (monolith/microservices/monorepo), key conventions, existing specs, and where decisions live. That is a 200-line document, not a 200K-token index.

4. **The first-run moment is a trust moment.** The perception gap (developers think AI helps when it does not) means first impressions matter enormously. If Edison's first action is asking 10 questions, it feels like an interrogation. If it silently scans and produces a wrong assumption, trust breaks. The CodeMap research suggests the right move: scan structure first (fast, visible, non-blocking), then present what you found and ask only about what you could not determine.

5. **Kiro's steering files are the closest analog.** Edison should produce something like a steering file on first run -- a persistent project context document that subsequent invocations read. The difference: Edison generates it from scanning rather than requiring the developer to write it.

**Recommended pattern for Edison first-run:** Scan (glob structure, read CLAUDE.md, check package.json/config files, find existing specs) -> Synthesize (produce a project context summary) -> Confirm (show the user, ask only for corrections) -> Persist (save to a known location for future invocations). Total cost: under 50K tokens. Total user effort: confirming a summary. Total time: under 30 seconds.

---

## Sources

- [Cursor Features](https://cursor.com/features)
- [Cursor AI Integration Guide 2026](https://monday.com/blog/rnd/cursor-ai-integration/)
- [How Copilot Understands Your Workspace](https://code.visualstudio.com/docs/copilot/reference/workspace-context)
- [GitHub Next: Copilot Workspace](https://githubnext.com/projects/copilot-workspace)
- [Augment Code Context Engine](https://www.augmentcode.com/context-engine)
- [Augment: Context Lineage](https://www.augmentcode.com/blog/announcing-context-lineage)
- [Deep Context Threading for Enterprise Codebases](https://www.augmentcode.com/guides/deep-context-threading-for-enterprise-codebases)
- [On Kiro and the AI-Driven Development Lifecycle](https://medium.com/@micheldirk/on-kiro-and-the-ai-driven-development-lifecycle-3459c2c19751)
- [Comprehensive Guide to Spec-Driven Development](https://medium.com/@visrow/comprehensive-guide-to-spec-driven-development-kiro-github-spec-kit-and-bmad-method-5d28ff61b9b1)
- [GSD Framework for Claude Code](https://dev.to/alikazmidev/the-complete-beginners-guide-to-gsd-get-shit-done-framework-for-claude-code-24h0)
- [GSD: Anatomy of Claude Code Workflows](https://www.codecentric.de/en/knowledge-hub/blog/the-anatomy-of-claude-code-workflows-turning-slash-commands-into-an-ai-development-system)
- [Stack Overflow 2025 Developer Survey](https://stackoverflow.blog/2025/12/29/developers-remain-willing-but-reluctant-to-use-ai-the-2025-developer-survey-results-are-here/)
- [Qodo: State of AI Code Quality 2025](https://www.qodo.ai/reports/state-of-ai-code-quality/)
- [METR: AI Impact on Developer Productivity](https://metr.org/blog/2025-07-10-early-2025-ai-experienced-os-dev-study/)
- [Augment: Why AI Tools Make Experienced Developers 19% Slower](https://www.augmentcode.com/guides/why-ai-coding-tools-make-experienced-developers-19-slower-and-how-to-fix-it)
- [Sourcegraph: Lessons from Building AI Coding Assistants](https://sourcegraph.com/blog/lessons-from-building-ai-coding-assistants-context-retrieval-and-evaluation)
- [Swimm: AI Coding With vs Without Context](https://swimm.io/blog/the-critical-role-of-context-in-ai-coding)
- [Martin Fowler: Context Engineering for Coding Agents](https://martinfowler.com/articles/exploring-gen-ai/context-engineering-coding-agents.html)
- [Understanding Codebase like a Professional (arxiv 2504.04553)](https://arxiv.org/html/2504.04553v2)
- [Challenges and Paths Towards AI for Software Engineering (arxiv 2503.22625)](https://arxiv.org/html/2503.22625v1)
- [VentureBeat: Why AI Coding Agents Aren't Production-Ready](https://venturebeat.com/ai/why-ai-coding-agents-arent-production-ready-brittle-context-windows-broken)
