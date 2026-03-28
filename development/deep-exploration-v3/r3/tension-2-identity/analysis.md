# Tension 2: Edison's Identity -- Tenant vs. Citizen vs. Sovereign

**Lens:** The Provocateur -- Push boundaries on the hardest problems.
**Constraint removed:** Edison must be all three identities simultaneously.

---

## The Removed Constraint

R1 and R2 operated under an unexamined assumption: Edison can be a tenant of Claude Code's memory (P4), a citizen of the Agent Skills ecosystem (P6), and a sovereign owner of the decision gap (P7) -- all at the same time, without contradiction. The constraint was that all three roles are additive, that serving one serves all.

This is false. These identities create genuine friction:

- **Tenant obligations kill sovereignty.** A tenant deposits into the landlord's memory format, follows the landlord's loading rules, accepts the landlord's 200-line cap. A tenant cannot define the standard. A tenant cannot demand that other tools interoperate with it. A tenant's profile data is shaped by Claude Code's auto-memory schema, not by what Edison needs.

- **Citizen obligations dilute sovereignty.** A citizen follows AGENTS.md conventions, structures its output for cross-tool discovery, makes its bindings portable. This is diplomacy, not dominance. A tool that says "I follow your standard" cannot simultaneously say "I define the category."

- **Sovereignty obligations strain tenancy.** A sovereign defines the decision-record format. A sovereign expects other tools to read its output. A sovereign would demand that Claude Code's memory system index Edison observations with first-class support -- not just tolerate them as tagged text blobs.

R2 resolved the surface conflict by saying "be a tenant for memory, bind to AGENTS.md for portability." But that was a compromise, not a resolution. The question was never asked: **what if Edison picked one identity and committed?**

---

## The Four Scenarios

### Scenario 1: Pure Sovereign

Edison defines the "design decision" category. It owns the format. Other tools integrate with Edison's output, not the other way around.

**What this means concretely:**
- Edison defines a Decision Record format (`.edison/decisions/NNNN-title.md`) that becomes the standard other tools consume. Not ADRs. Not RFCs. Edison's format.
- Edison's binding is not "write to CLAUDE.md" or "write to AGENTS.md" -- it is "write to the decision record." If Claude Code wants to respect it, Claude Code reads `.edison/`. If Cursor wants to respect it, Cursor reads `.edison/`.
- Edison's memory is not deposited into Claude Code's system. It lives in `.edison/profile.md` because Edison's memory is Edison's, not the host's.
- Edison publishes a spec: "How to consume Edison decision records." Other tools (linters, CI, code generators) read this spec.

**What becomes possible:**
- Edison-aware CI. A GitHub Action that blocks merge if the PR touches files covered by a decision record that hasn't been updated. This is impossible if Edison is a tenant -- tenants don't have CI hooks.
- Decision record linking. A v0-style generator that reads Edison's decision records before generating code. "I see Edison decided on a card-based layout with progressive disclosure. Generating accordingly." This requires a stable, documented format that Edison owns.
- Decision archaeology. `git log --all -- .edison/decisions/` gives you the full history of every design decision in the project. No grepping through CLAUDE.md for tagged entries.
- Ecosystem gravity. If Edison's format becomes the standard, other decision-adjacent tools (architecture reviewers, tech debt trackers) integrate with Edison rather than inventing their own. Edison becomes the hub.

**What breaks:**
- Cold start. No tool reads `.edison/` today. Edison would need to bootstrap adoption, which is the same chicken-and-egg problem every standard faces.
- Memory isolation. Edison observations living outside Claude Code's memory means they don't benefit from Claude Code's automatic loading. Edison would need its own "read my profile at session start" instruction, which is the very infrastructure R2 said not to build.
- Hubris penalty. A tool that demands the ecosystem orbit it usually loses to a tool that fits into the ecosystem. USB won every format war by being compatible, not by being sovereign.

### Scenario 2: Pure Tenant

Edison is a Claude Code skill. Period. It does not aspire to cross-tool compatibility, does not define standards, does not position against anything. It is a feature of Claude Code's ecosystem, the way a VS Code extension is a feature of VS Code.

**What this means concretely:**
- Edison uses CLAUDE.md exclusively. No AGENTS.md. No portable format.
- Edison's memory goes into `~/.claude/projects/<project>/memory/` with no special structure. Just observations in the format Claude Code already understands.
- Edison's output is optimized for Claude Code's rendering, Claude Code's memory, Claude Code's context window. If it doesn't work in Cursor or Windsurf, that's fine.
- Edison's versioning follows whatever Claude Code establishes for skills. No independent SemVer.

**What becomes possible:**
- Deep integration. Edison can use Claude Code's memory system without abstraction layers. It can assume auto-memory loading. It can reference other skills by name (Superpowers, Brainstorm) because they share a host. No portability tax.
- Faster iteration. Every line of the spec serves Claude Code users. No conditional logic for "if host supports X, do Y, otherwise Z." The spec shrinks because it sheds cross-platform hedging.
- User clarity. "Edison is a Claude Code skill" is one sentence. "Edison is a portable design exploration framework that deposits observations into your AI coding tool's memory system via the Agent Skills standard while maintaining its own decision record format" is a paragraph that nobody will remember.
- First-class trust. Claude Code can eventually build Edison-specific features (dedicated memory buckets for skills, skill-to-skill communication) and Edison would be a natural first adopter. You don't get invited to the platform's roadmap if you're trying to be platform-independent.

**What breaks:**
- Ceiling. Claude Code is one tool. If Windsurf or Cursor or the next thing wins market share, Edison cannot follow the users. Being a tenant means your ceiling is your landlord's ceiling.
- No category ownership. A tenant cannot say "I am the only tool in the decision gap." A tenant says "I am a Claude Code skill that helps with decisions." The positioning becomes feature-level, not category-level.
- Dependency fragility. If Anthropic changes Claude Code's memory system, skill format, or loading behavior, Edison breaks. Tenants have no SLA.

### Scenario 3: Pure Citizen

Edison is a portable exploration methodology that happens to run on Claude Code today. It follows every community standard. It could run on any AI coding tool without structural changes.

**What this means concretely:**
- AGENTS.md is the only binding format. No CLAUDE.md-specific instructions.
- Edison's spec is host-agnostic. No references to Claude Code's memory, Claude Code's context window, or Claude Code's skills system.
- Decision records use a standard format (ADR-like) that any tool can read.
- The skill metadata uses whatever the Agent Skills standard specifies. Edison is just a compliant skill among many.

**What becomes possible:**
- Portability. When a user switches from Claude Code to Cursor, Edison works. The exploration methodology is the same. The binding mechanism changes but the spec doesn't.
- Community adoption. Being a model citizen of Agent Skills means being listed as a reference implementation, being mentioned in the standard's documentation, being the "if you want to see how a skill should work, look at Edison" example.
- Combinability. Citizens compose. If Edison is fully AGENTS.md-compliant, any other compliant tool can chain with it: a brainstorming skill feeds into Edison's Explore mode, Edison's output feeds into a code generation skill. No custom integration needed.
- Longevity. Standards outlive products. AGENTS.md at 60K+ repos and Linux Foundation backing could outlive Claude Code. A citizen survives the fall of its original host.

**What breaks:**
- Lowest common denominator. AGENTS.md must support all tools, so it supports the features all tools share. Edison's most powerful features (progressive deepening, parallel research agents, synthesis with memory deposition) may not map to AGENTS.md's vocabulary. The spec becomes generic to stay portable.
- No home field advantage. Edison on Claude Code should be better than Edison on Cursor, because Claude Code is Edison's native environment. Pure citizenship erases this advantage.
- Identity dilution. "A portable design exploration framework" is a description. "The tool that owns the decision gap" is an identity. Citizens have descriptions. Sovereigns have identities.

### Scenario 4: Contextual Identity (The Shapeshifter)

Edison is a tenant when it reads/writes memory, a citizen when it produces output, and a sovereign when it defines methodology. The identity is not a single thing -- it's a function of what Edison is doing at that moment.

**What this means concretely:**
- Memory: tenant. Use Claude Code's memory. Don't fight it.
- Binding: citizen. Output in AGENTS.md format so any tool can read decision records.
- Methodology: sovereign. The research-rounds-synthesis process is Edison's and Edison's alone. No other tool gets to define how Edison explores. The round structure, the progressive deepening, the persona assignment -- these are Edison's proprietary methodology.
- Positioning: sovereign. "The tool for the decision gap" is Edison's claim, regardless of what host it runs on or what standard it follows for output.

**What becomes possible:**
- Selective optimization. Tenancy for memory means zero infrastructure cost. Citizenship for output means maximum portability. Sovereignty for methodology means nobody can commoditize the process.
- Layered defense. If Claude Code changes its memory system, Edison adapts (tenant flexibility). If AGENTS.md evolves, Edison's output adapts (citizen flexibility). But the methodology -- the thing that makes Edison Edison -- never bends to external pressure.
- Coherent story. "Edison uses your tool's memory, speaks your ecosystem's language, and thinks its own thoughts." This is not incoherent. This is how humans operate: we live in a house we don't own (tenant), follow the laws of the country (citizen), and have our own beliefs and methods (sovereign).

**What breaks:**
- Complexity. Three identity modes means three sets of design decisions, three sets of compatibility concerns, three potential failure surfaces. The spec has to be legible about which mode applies where.
- Boundary disputes. Where does "methodology" end and "output format" begin? If Edison's synthesis format is part of its methodology (sovereign), but also needs to be AGENTS.md-compliant (citizen), the sovereignty claim is hollow. The seams between identities become contested territory.

---

## The Provocateur's Position

Scenario 4 is the right answer, but not because it's the reasonable compromise. It's the right answer because the other three scenarios misunderstand what identity means for a tool.

A tool's identity is not a single word. It's a stack:

```
Layer 4: Category   (sovereign) -- "I am the decision tool"
Layer 3: Method     (sovereign) -- "I explore this way"
Layer 2: Output     (citizen)   -- "My results speak your language"
Layer 1: Memory     (tenant)    -- "I live in your house"
```

This is how every successful platform component works. PostgreSQL is a tenant of your OS (uses your filesystem), a citizen of SQL (speaks the standard language), and a sovereign database (its MVCC implementation, its query planner, its extension system are its own). Nobody accuses PostgreSQL of identity incoherence.

The R2 tension was real but misdiagnosed. The friction is not between three identities. The friction is between three *layers* that were being collapsed into one choice. Once you see them as layers, the "conflict" disappears. You don't choose between tenant and sovereign. You're a tenant at layer 1 and a sovereign at layer 4.

The one thing Scenario 4 must add that the original compromise didn't: **explicit sovereignty claims.** R2 said "be a tenant" and "be a citizen" but never said "be a sovereign" with equal force. The methodology and the category claim need to be stated with the same conviction as the tenancy and citizenship commitments. Otherwise, Edison drifts toward pure tenancy by default, because tenancy is the path of least resistance.

---

## What This Changes About the Spec

### The spec needs a sovereignty section.

Not a long one. But somewhere in SKILL.md, Edison needs to say:

> Edison's exploration methodology -- research, progressive rounds, synthesis -- is Edison's own. It is not derived from or constrained by any host tool's conventions. The methodology may evolve through self-improvement (P3), but it evolves on Edison's terms, not the platform's.

This is not arrogance. This is the same claim every framework makes. React doesn't apologize for the virtual DOM. Rails doesn't apologize for convention over configuration. Edison shouldn't apologize for research-before-commitment.

### Decision records should be dual-format.

Write to both `.edison/decisions/` (sovereign format, for tools that understand Edison) and AGENTS.md-compatible binding (citizen format, for tools that understand the standard). This is not redundancy -- it's layered identity. The sovereign format is richer. The citizen format is portable. Users who only care about portability get portability. Users who want the full Edison experience get the full Edison experience.

### Memory stays tenant.

R2 was right about memory. Don't build your own. Use Claude Code's system. But tag observations with `[edison:methodology]` vs `[edison:preference]` to maintain sovereignty over what the observations mean, even if the storage is rented.

---

## Kernel Extraction

**Constraint removed:** Edison must choose a single identity (tenant, citizen, or sovereign).

**Finding:** Identity is not a scalar. It's a stack. Edison is a tenant at the infrastructure layer, a citizen at the output layer, and a sovereign at the methodology and category layers. This is not a compromise -- it's the natural architecture. The mistake was treating identity as a single choice rather than a layered property.

**Implication for the spec:**
1. Add an explicit sovereignty claim for the methodology. Not defensive, not apologetic. Just factual: this is how Edison thinks, and it thinks this way on purpose.
2. Decision records should be dual-format: sovereign (`.edison/decisions/`) for deep integration, citizen (AGENTS.md-compatible) for portability.
3. Memory stays tenant (Claude Code's system) with sovereign tagging (Edison's taxonomy).
4. Category positioning is sovereign: "the tool for the decision gap" is Edison's claim, not something granted by the ecosystem.

**The one-line version:** Be a tenant where you sleep, a citizen where you speak, and a sovereign where you think.
