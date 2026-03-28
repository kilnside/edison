# Edison v3 Priorities
Confirmed: 2026-03-28

## Priority List

### P1: Spec Compression (Structural)
730 lines exceeds 500-line Agent Skills standard. Blocks ecosystem adoption.
- Dependencies: None
- Research: Agent Skills spec, progressive disclosure architecture

### P2: Edge Case Hardening (Structural)
~12 undefined behaviors mean different AIs run Edison differently.
- Dependencies: None
- Research: Direct spec analysis found contradictions, missing fallbacks

### P3: Self-Improvement Loop (Structural + Conceptual)
The v3 vision's core feature. No competitor has it. First-mover at "Level 4."
- Dependencies: Depends on P1 (compressed spec is easier to evolve)
- Research: Anthropic dogfooding, PromptBreeder, Monperrus 2026

### P4: Cross-Project Learning (Conceptual)
No tool transfers lessons between projects. .edison/profile.md is a starting point.
- Dependencies: Depends on P3 (learning feeds improvement)
- Research: Every tool is project-scoped only

### P5: Distribution & Versioning (Tradeoff)
Published but no version strategy. Ecosystem has no standard — Edison can lead.
- Dependencies: None
- Research: ChatGPT plugins died without it, VS Code model works

### P6: Binding Portability (Tradeoff)
Handoff only works with CLAUDE.md. AGENTS.md becoming universal (16+ tools).
- Dependencies: May invalidate P2
- Research: 60K+ repos, Linux Foundation, 3K+ upvote issue

### P7: Decision Gap Positioning (Conceptual)
Edison is the ONLY tool in the decision space. Needs to own it explicitly.
- Dependencies: None
- Research: FigJam = pre-decision, v0 = post-decision, Edison = the decision

### P8: User Signal Integration (Tradeoff + Conceptual)
Every design methodology includes user testing. Edison has none.
- Dependencies: May invalidate P7 (human dependency vs solo-practitioner)
- Research: GV Sprint, IDEO, Double Diamond all test with users
