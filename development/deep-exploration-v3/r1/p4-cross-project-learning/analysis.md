# P4: Cross-Project Learning -- R1 Analysis

**Character:** The Engineer
**Priority type:** Conceptual (primary) / Structural (secondary)

## The Problem

Edison generates valuable knowledge during every exploration: what stack patterns work, which tradeoff resolutions hold up, what research questions yield real signal, what fallback clauses get triggered. All of it stays in `.edison/profile.md` and `deep-exploration/`, locked to a single project. When the same developer starts a new project, Edison starts from zero. The developer's own judgment carries lessons forward. Edison does not.

No competing tool solves this either. Cursor rules are duplicated manually (28.7% line duplication across repos). Copilot, Windsurf, and Aider are entirely session- or project-scoped. Devin's knowledge base is persistent but still project-local. The gap is real and universal.

## What Is Portable vs. What Is Not

Before proposing mechanisms, the taxonomy matters. Edison learns things at different levels of abstraction, and portability follows abstraction height:

- **Highly portable:** Developer preferences (exploration depth tolerance, preferred artifact types), recurring tradeoff patterns (e.g., "this developer always favors simplicity over flexibility"), stack-level lessons ("Next.js App Router + Supabase: auth middleware goes in middleware.ts"), fallback clause trigger frequency (which edge cases actually happen).
- **Partially portable:** Research findings about libraries/patterns (useful if the new project shares stack), priority classification accuracy (did structural/tradeoff/conceptual labels predict the right artifact type?).
- **Not portable:** Project-specific specs, architecture decisions, directory structures, profile identity/domain fields, CLAUDE.md bindings.

The dividing line: anything that references a file path, a domain concept, or a project-specific constraint is not portable. Anything that describes a *pattern of decision-making* is.

## Approach 1: Developer Profile at ~/.claude/edison/developer.md

A single file that lives outside any project, in the user's global Claude config. Edison reads it on every first-run scan (Phase 0) and writes to it after every completed exploration. The file captures developer-level patterns, not project-level facts.

Structure:
- **Preferences:** Exploration depth default, artifact type preferences, signal about how often the user overrides Edison's recommendations.
- **Stack Playbook:** Per-stack snippets of what Edison has learned. Keyed by stack fingerprint (e.g., "next-supabase-clerk"), so a new project with a matching stack gets relevant priors.
- **Pattern Library:** Tradeoff resolutions that recurred. "When choosing between X and Y in context Z, the resolution was W, and it held up / did not hold up."
- **Edge Case Log:** Which fallback clauses (from P2) were actually triggered, across all projects. Feeds back into P3's self-improvement loop.

**Mechanism:** After Final Synthesis (Phase 7), Edison extracts portable entries from the exploration and appends them to developer.md. On the next project's Phase 0, Edison reads developer.md alongside the project profile and weaves relevant entries into research and round prompts.

**Privacy:** The file is local-only, under the user's control, never transmitted. The user can delete it or edit it. Stack playbook entries reference stack patterns, not project names or proprietary details.

**Token cost:** Reading developer.md adds ~200-500 tokens to Phase 0. Writing to it adds a post-synthesis step of ~100-300 tokens. Negligible relative to a full exploration.

**Risk:** Stale entries. A lesson learned in 2024 with Next.js 14 might be wrong for Next.js 16. Mitigation: entries carry a date and a stack version. Edison can flag entries older than 6 months or from a different major version as "possibly stale."

## Approach 2: Portable Exploration Summaries

Instead of extracting patterns into a structured profile, Edison writes a one-page summary after each exploration -- a "lessons learned" document -- and stores it in a global index at `~/.claude/edison/explorations/`. Each summary is named by project + date and contains: the priorities explored, the resolution for each, the confidence level, key research findings, and what surprised Edison.

A new project's Phase 0 would scan this index, find explorations with similar stack or domain, and include relevant summaries in the research brief.

**Advantage:** Preserves more context than extracted patterns. A developer can browse past explorations.

**Risk:** Scales poorly. After 20 explorations, the index is large and most entries are irrelevant to the current project. Matching "similar stack or domain" is fuzzy and token-expensive. Also, summaries are more likely to contain project-specific details that leak context.

## Approach 3: Cross-Project via Skill Evolution Only

Skip the developer profile entirely. Instead, rely on P3's self-improvement loop to bake recurring lessons directly into SKILL.md (or its resources/). If Edison consistently finds that a certain class of priority resolves in R1, the spec evolves to handle that class more efficiently. If a fallback clause fires often, it gets promoted from fallback to primary path.

**Advantage:** Zero additional files. No privacy concerns. The skill itself gets smarter, benefiting all users, not just the one developer.

**Risk:** Loses individual developer preferences. Two developers using Edison would get the same behavior even if they have different exploration styles. Also, skill evolution (P3) is itself unproven -- depending on it for cross-project learning stacks risk on risk.

## Recommendation: Approach 1 (Developer Profile)

Approach 1 is the engineering answer. It separates portable from non-portable cleanly, uses a simple file-based mechanism that matches Edison's existing patterns (.edison/profile.md is project-local, ~/.claude/edison/developer.md is developer-local), and has a clear read/write lifecycle tied to existing phases.

Approach 2 is more ambitious but the scaling and relevance-matching problems are real. Approach 3 is elegant but insufficient -- it improves Edison generically but cannot capture "this developer prefers focused explorations" or "this developer's stack always hits the same auth tradeoff."

The developer profile also creates a natural integration point with P3 (self-improvement): the edge case log section of developer.md is exactly the signal P3 needs to know which spec sections to evolve. And with P1 (spec compression): the developer profile lives outside the skill, adding zero lines to SKILL.md. The Phase 0 scan just gains one more file to read.

## Self-Score: 3/5

The mechanism is clear and implementable. Docking two points because: (1) P3 (self-improvement loop) does not exist yet, and the write-back cycle depends on it -- the developer profile is only as good as the extraction logic that populates it, and that logic is undesigned. (2) I have not validated whether ~/.claude/ is a reliable cross-project location across all Claude Code installation methods. (3) The "stack playbook" concept sounds useful but the matching heuristic (stack fingerprint) is hand-wavy -- what counts as "same stack" needs sharper definition.

## Unchallenged Assumptions

1. **Developers use Edison across multiple projects.** The current user base is one person. Cross-project learning assumes repeated use across repos. If Edison is typically used once per project, the developer profile never accumulates useful data.

2. **~/.claude/ is stable and writable.** Edison assumes this directory exists and persists. If Claude Code changes its config location, or if the user works across multiple machines, the developer profile does not sync.

3. **Pattern extraction can be automated.** The analysis assumes Edison can reliably identify which parts of an exploration are portable. This is a non-trivial NLP/classification task that gets delegated to "a post-synthesis step" without specifying how.

4. **Stale entries are detectable.** The mitigation for stale lessons assumes version numbers and dates are sufficient. But some lessons go stale for reasons that are not version-related (e.g., a community best practice shifts).

5. **Privacy is solved by locality.** The analysis assumes local-only storage eliminates privacy concerns. But if a developer works on proprietary projects, even stack-level patterns ("uses internal-auth-library v3") could leak proprietary information into a profile that persists across contexts.

6. **The developer profile is small enough to read every time.** The analysis estimates 200-500 tokens. Over dozens of projects and hundreds of pattern entries, this could grow significantly. No pruning or archival mechanism is proposed.
