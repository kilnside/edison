# Edison v3 Research Brief
Generated: 2026-03-28 | 4 research agents, 11 questions, 40+ sources

---

## Key Findings (ranked by surprise value)

### 1. Edison occupies a gap NO other tool fills
**Surprise: HIGH** | Confidence: verified

Every design/brainstorming tool (FigJam, Miro, Notion) helps with pre-decision brainstorming. Every AI generation tool (v0, Galileo) helps with post-decision execution. NOTHING helps with the actual decision-making phase — weighing tradeoffs, researching alternatives, understanding consequences. Edison is the only tool focused on the decision itself.

### 2. A March 2026 paper validates Edison's core thesis
**Surprise: HIGH** | Confidence: verified

Monperrus (arXiv, March 2026) demonstrated that "the specification, not the implementation, is the stable artifact of record." Improving an agent means improving its specification. This is exactly Edison's philosophy — DEFINITIVE-SPEC.md with embedded MUST/VERIFICATION fields IS the program. Academic validation of what Edison intuited.

### 3. No AI coding tool ships self-evolving specs
**Surprise: HIGH** | Confidence: verified

The self-improvement landscape has clear levels:
- Level 0 (Aider, bolt.new): No memory
- Level 1 (Copilot, Windsurf): Session-level context
- Level 2 (Cursor rules, CLAUDE.md): Static, manually-maintained
- Level 3 (Devin knowledge base): Persistent, semi-automated
- Level 4 (NOBODY): Self-evolving specifications

Edison could be the first Level 4 tool.

### 4. Edison's SKILL.md is 730 lines — Agent Skills spec says max 500
**Surprise: MEDIUM** | Confidence: verified

The Agent Skills standard (agentskills.io) recommends body under 500 lines with supplementary material in resources/. Edison exceeds this by 46%. This matters because progressive disclosure loads ~100 tokens per skill for metadata, then <5,000 tokens for the body. Oversized skills consume context budget.

### 5. 13.4% of Claude Code skills have critical security issues
**Surprise: HIGH** | Confidence: verified

Snyk's ToxicSkills audit found 76 confirmed malicious payloads in 3,984 skills. OWASP created an "Agentic Skills Top 10." Edison's reputation depends on being trustworthy — no shell commands, no arbitrary file access beyond exploration artifacts.

### 6. The spec has ~12 edge cases that cause undefined behavior
**Surprise: MEDIUM** | Confidence: verified

Critical gaps found in direct spec analysis:
- All priorities MURKY after R2 (no fallback path)
- Research finds nothing (no null-research handling)
- Self-score 1-5 has no defined semantics (different AIs diverge)
- "Focused" 2-round path references R3 outputs in Final Synthesis
- "Never block on user input" contradicts 3 mandatory gates
- Hard trigger rule is mathematically redundant

### 7. Every design methodology includes user testing — Edison has none
**Surprise: LOW** | Confidence: verified

GV Sprint tests with 5 real users. IDEO does ethnographic research. Double Diamond emphasizes user involvement throughout. Edison only researches what users said elsewhere — never involves an actual user. This is the single biggest methodological gap vs. established frameworks.

### 8. Claude Code writes 70-90% of its own code via dogfooding
**Surprise: HIGH** | Confidence: verified

Anthropic's feedback loop: 70-80% of technical staff use Claude Code daily. 60-100 internal releases per day. The rule: "When Claude does something wrong, add it to CLAUDE.md." Edison already passed the self-hosting test (designed itself). The next step: formalize the feedback loop so each version produces the next.

### 9. AGENTS.md is becoming the universal standard
**Surprise: MEDIUM** | Confidence: verified

Linux Foundation backed, adopted by 16+ tools (Cursor, Codex, Gemini CLI, etc.), 60K+ repos. Claude Code still uses CLAUDE.md (3,000+ upvote issue requesting AGENTS.md). Edison's output format (CLAUDE.md binding) may need AGENTS.md compatibility in the future.

### 10. PromptBreeder's dual-level evolution maps to Edison
**Surprise: MEDIUM** | Confidence: verified

PromptBreeder evolves both task-prompts AND mutation-prompts (how it generates improvements). Edison could evolve both SKILL.md (meta-level: how explorations work) and per-project profiles (task-level: how to explore this specific project). The self-referential aspect is the breakthrough.

---

## Contradictions Between Findings

1. **"Keep it under 500 lines" vs. "spare no expense."** The Agent Skills spec wants conciseness. Edison's philosophy is thoroughness. These conflict directly — the skill body must compress while the exploration output remains deep.

2. **"Self-evolving specs" vs. "security matters."** Self-modification is powerful but also the #1 attack vector in malicious skills. An Edison that modifies its own SKILL.md must do so transparently and with user approval.

3. **"No user testing" vs. "software-first scope."** Adding user testing would make Edison more methodologically complete but less automated. Edison's value is that it replaces the need for a team — adding "go talk to a user" step reintroduces human dependency.

4. **"Cross-platform compatibility" vs. "CLAUDE.md binding."** Edison's handoff binds to CLAUDE.md, which is Claude Code specific. Agent Skills standard is tool-agnostic. Full cross-platform support would mean abstracting the binding mechanism.

---

## Opportunity Map

| Vision Element | Research Support | Opportunity |
|---------------|-----------------|-------------|
| Self-improvement | Strong (Anthropic dogfooding, PromptBreeder, Monperrus 2026) | First Level 4 self-evolving skill |
| Ecosystem play | Strong (Agent Skills standard, 334+ skills, unique niche) | Edison is the only design-decision tool in the ecosystem |
| Distribution | Strong (open standards win, SkillsMP exists) | Ride the Agent Skills standard, add versioning proactively |
| Cross-project learning | Strong gap (no tool does this natively) | .edison/profile.md → portable lessons learned |
| Beyond software | Moderate (methodology is domain-agnostic, binding is software-specific) | Don't prevent it, don't target it |

---

## Risk Flags

1. **Spec size exceeds standard.** 730 lines vs. 500 line recommendation. Need to compress or split.
2. **Security perception.** In a landscape where 13.4% of skills are malicious, Edison must be above reproach.
3. **Self-improvement scope creep.** The research shows exciting possibilities (PromptBreeder, DSPy, meta-learning) but implementing all of them would make Edison a research project, not a tool. Pick one mechanism, do it well.
4. **No versioning standard exists.** Edison can lead here but must not invent something incompatible if Agent Skills adds versioning later.
5. **Context window pressure.** Edison is already token-intensive. Adding self-improvement mechanisms (failure logs, outcome tracking, profile evolution) adds more tokens. Must be budget-conscious.
