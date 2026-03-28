# P6: Binding Portability — R1 Analysis

**Character:** The Engineer
**Self-score:** 4/5 (high confidence — clear winner, low implementation risk)

## Priority Understood

Edison's Phase 8 handoff binds specs to CLAUDE.md with path-based triggers. This works because Claude Code reads CLAUDE.md before every action. But AGENTS.md — now under the Linux Foundation's Agentic AI Foundation — is supported by 16+ tools and adopted by 60K+ repos. Edison's binding is Claude Code-specific, which means:

1. Specs produced by Edison are invisible to Cursor, Copilot, Codex, Gemini CLI, etc.
2. Teams using multiple tools get inconsistent behavior — some agents see the spec, others don't.
3. Edison's own positioning as "the decision phase" (P7) is undermined if the output only works in one tool.

The binding mechanism is the last step. If it's portable, everything upstream (research, rounds, synthesis) benefits every tool. If it's not, Edison's value is artificially capped.

## Approaches

### Approach A: Abstract Binding Layer with Platform Detection

Write a binding abstraction that detects which config files exist and writes to all of them. Edison would output to CLAUDE.md, AGENTS.md, and .cursor/rules/ simultaneously. The binding step becomes: "detect platform files → write equivalent triggers to each."

**Pros:** Maximum compatibility. Users of any tool get binding automatically. No user decision required.
**Cons:** Maintenance burden — every new tool format needs a template. Risk of subtle semantic differences between platforms (AGENTS.md directory scoping vs. CLAUDE.md flat sections vs. Cursor's .mdc glob patterns). Edison has to understand each format's idioms, which is fragile.

### Approach B: AGENTS.md as Primary, CLAUDE.md as Supplement

Make AGENTS.md the primary binding target. It's standard Markdown, directory-scoped, and read by 16+ tools including (reportedly) Claude Code itself. Use CLAUDE.md only for Claude-specific instructions that AGENTS.md can't express (like Claude Code hook configuration or memory directives).

**Pros:** One target to maintain. AGENTS.md's directory scoping is a natural fit for Edison's path-based triggers — put an AGENTS.md in `src/auth/` that references the auth section of the spec. Aligns with the ecosystem direction. Future-proof.
**Cons:** Claude Code's AGENTS.md support is not yet confirmed as equivalent to CLAUDE.md. If Claude Code treats AGENTS.md as secondary, binding loses priority. AGENTS.md has no formal schema — "just Markdown" means less structure for machine-readable triggers.

### Approach C: Don't Worry About It Yet

Keep CLAUDE.md binding. Edison is a Claude Code skill. Its users are Claude Code users. When AGENTS.md support matures in Claude Code, migrate then.

**Pros:** Zero work now. No risk of premature abstraction. Focus effort on higher-priority items (P1 compression, P3 self-improvement).
**Cons:** Contradicts the v3 vision's ecosystem awareness. Cross-platform users already exist (people use Cursor AND Claude Code). The 3,000+ upvote issue suggests AGENTS.md support in Claude Code is imminent — by the time Edison v3 ships, it may already be live. Waiting means retrofitting later.

## Recommendation: Approach B — AGENTS.md Primary, CLAUDE.md Supplement

The math is straightforward. AGENTS.md is standard Markdown with directory scoping — Edison already thinks in terms of path-based triggers, and AGENTS.md's hierarchical model (root file + subdirectory overrides) maps directly to Edison's binding pattern. Writing `src/auth/AGENTS.md` with a reference to the spec's auth section is *more natural* than cramming path-glob rules into a flat CLAUDE.md section.

The migration path is clean:
1. Phase 8 Step 3 generates an AGENTS.md (or appends to existing) with spec references and directory-scoped instruction files.
2. If CLAUDE.md exists, add a one-line cross-reference: "See AGENTS.md for active design specs."
3. For Claude-specific behaviors (self-trigger rules, Edison history), keep those in CLAUDE.md where they belong.

This is a tradeoff priority, and the tradeoff is clear: slight risk that Claude Code deprioritizes AGENTS.md content vs. guaranteed compatibility with 16+ tools. The ecosystem direction is unambiguous.

## Unchallenged Assumptions

1. **AGENTS.md will remain the standard.** It could fragment or be superseded. The Linux Foundation stewardship reduces this risk but doesn't eliminate it.
2. **Directory-scoped AGENTS.md files are read by all supporting tools.** Some tools may only read root-level AGENTS.md. Need to verify per-tool behavior.
3. **Edison users want cross-tool compatibility.** Some may be pure Claude Code users who don't care. But even they benefit from the cleaner directory-scoping model.
4. **Claude Code will eventually support AGENTS.md at parity with CLAUDE.md.** The 3K+ upvote issue and Linux Foundation involvement suggest yes, but it's not guaranteed.
5. **Path-based triggers are the right abstraction.** Maybe some platforms prefer tag-based, glob-based, or context-window-based triggering. We're assuming path = universal.
