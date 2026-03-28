# P5: Distribution & Versioning — R1 Analysis

## Priority Understood

Edison is published on GitHub with a marketplace.json declaring version "2.0.0", but there is no versioning strategy — no version in SKILL.md frontmatter, no changelog, no compatibility declaration, no update mechanism. The Agent Skills ecosystem has no versioning standard. This is both a risk (Edison could break silently for users) and an opportunity (Edison can establish patterns others adopt).

The research brief flags two relevant signals: ChatGPT plugins died in 13 months partly due to zero versioning (users couldn't trust stability), and the Agent Skills spec has no version field despite 334+ curated skills and 280K+ on SkillsMP. Meanwhile, VS Code extensions have a mature model (SemVer + engine compatibility + auto-update with pin) that proves versioning works for developer tools.

## Approach 1: SemVer in Frontmatter Only

Add a `version` field to SKILL.md's YAML frontmatter. Follow SemVer strictly:
- MAJOR: Breaking changes to Edison's behavior (removing a mode, changing output format)
- MINOR: New capabilities (new mode, new research strategy)
- PATCH: Bug fixes, wording improvements, edge case handling

The marketplace.json already has "2.0.0" — align SKILL.md to match. Version lives in one canonical place (the skill file itself), marketplace.json derives from it.

**Pros:** Zero infrastructure. Works today. Any skill can adopt the same convention. The version travels with the file — even a manual copy carries its version. Agent Skills parsers already handle frontmatter; adding a field is backward-compatible.

**Cons:** No enforcement. No compatibility declaration. No changelog. Users who manually copied SKILL.md to `~/.claude/skills/` have no way to know a new version exists. Version bumps are honor-system.

## Approach 2: SemVer + Changelog + Compatibility Declaration

Everything from Approach 1, plus:
- `CHANGELOG.md` in the repo following Keep a Changelog format
- `min_claude_code` field in frontmatter declaring minimum Claude Code version (or "any")
- `min_context` field declaring minimum context window needed (Edison is token-heavy; a 32K window won't work)

The changelog serves dual purposes: human-readable history and machine-parseable diff for automated update checks. Each entry maps to a SemVer bump with a rationale.

**Pros:** Users can make informed upgrade decisions. Compatibility fields prevent silent failures (running Edison on a model with insufficient context). The changelog creates a public contract — "we take stability seriously." Other skill authors get a template.

**Cons:** Maintenance overhead. Changelog discipline is hard to sustain (most projects fail at this). Compatibility fields require knowing what to check against — Claude Code doesn't expose a version that skills can query. The `min_context` field is meaningful but unenforceable by current tooling.

## Approach 3: Full VS Code Model (Registry + Auto-Update + Pinning)

Everything from Approach 2, plus:
- A `VERSIONING.md` standard proposal that any Agent Skill can adopt
- GitHub Releases with tagged versions (v2.0.0, v2.1.0, etc.)
- An update-check mechanism: Edison checks its own version against the latest release on first run and notifies the user
- Version pinning: users can lock to a specific version in their install config

This is the VS Code extension model adapted for Agent Skills: SemVer + engine compatibility + auto-update with opt-out pinning.

**Pros:** Full lifecycle coverage. Users always know when updates exist. Pinning prevents unwanted changes. GitHub Releases are free infrastructure. A published standard positions Edison as the versioning thought leader in the Agent Skills ecosystem.

**Cons:** Significant complexity. The update-check requires network access from within a skill (which SKILL.md can request but shouldn't depend on). Version pinning requires tooling that doesn't exist in Claude Code's skill loader. The standard proposal risks being ignored or contradicted if Anthropic later adds official versioning. Over-engineering for a skill with an audience currently measured in single digits.

## Recommendation: Approach 2 (SemVer + Changelog + Compatibility)

Approach 1 is too thin — a version number without a changelog is a label without meaning. Approach 3 is premature — it builds infrastructure for a scale Edison hasn't reached and depends on capabilities (network checks, version pinning) that don't exist in the runtime.

Approach 2 hits the sweet spot. It establishes Edison as versioning-conscious without over-investing. The key insight: **the changelog IS the versioning strategy.** A version number alone tells you nothing; the changelog tells you whether to upgrade. The compatibility fields are forward-looking — they're unenforceable today but ready for the day Claude Code adds skill version checking.

Concrete implementation:
1. Add `version: 2.0.0` to SKILL.md frontmatter
2. Add `min_context: 128k` to frontmatter (Edison needs large context for deep explorations)
3. Create CHANGELOG.md with a v2.0.0 entry capturing the v2 release
4. Use GitHub Releases to tag versions (free, zero-maintenance)
5. Document the convention in a brief section of README.md so other skill authors can adopt it

When the ecosystem matures and Anthropic adds official versioning, Edison will already be compliant or trivially adaptable. Leading by example, not by specification.

## Self-Score: 4/5

High confidence this is the right approach for Edison's current stage. The recommendation is pragmatic and low-risk. Docked one point because the compatibility fields (min_context, min_claude_code) are aspirational — they communicate intent but have no enforcement mechanism today. If Anthropic's official versioning looks different, Edison would need to adapt, but the migration cost from Approach 2 to any standard is minimal.

## Unchallenged Assumptions

1. **SemVer is the right model for skills.** Skills are documents, not APIs. SemVer was designed for code interfaces where "breaking change" means compile/runtime failure. For a skill, "breaking change" might mean "produces different output for the same input" — a fuzzier boundary. CalVer (date-based) might actually be more honest for something that evolves continuously.

2. **Users will read changelogs.** The entire Approach 2 thesis assumes changelogs are useful. In practice, most developers ignore changelogs and just update. For a skill with a small audience, the changelog might be performative.

3. **Version should live in the skill file.** The marketplace.json already has a version. Putting it in frontmatter too creates a dual-source-of-truth risk. We assume they'll stay synchronized but have no mechanism to enforce it.

4. **Edison's audience will grow.** The entire priority assumes distribution matters. If Edison remains a personal tool for its creator and a handful of users, versioning is overhead with no payoff.

5. **The Agent Skills ecosystem will standardize.** We assume a standard will emerge and Edison should be ready. It's also possible the ecosystem fragments or Anthropic imposes something entirely different.

6. **GitHub is the right distribution channel.** We took for granted that GitHub + marketplace is the path. A CDN-hosted skill, an npm package, or a dedicated skill registry could all be viable alternatives.
