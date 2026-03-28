# P7 Analysis: Decision Gap Positioning

**Priority:** P7 — Decision Gap Positioning (Conceptual)
**Agent:** Round 1 — The Engineer
**Self-score:** 4/5

---

## The Problem

Edison's current positioning is accurate but generic. "Get design decisions right before writing code" describes what Edison does but not where it lives in the user's workflow or why nothing else fills that space. The phrase sounds like a linter with opinions. It does not communicate the unique gap Edison occupies.

The research is unambiguous: FigJam and Miro own brainstorming (pre-decision), v0 and Galileo own execution (post-decision), and nothing owns the decision itself. Edison is the only tool that sits in that gap. But the current language — "design exploration skill," "three modes for getting design decisions right" — buries this positioning under feature descriptions.

## Three Approaches

### Approach A: "Decision Engine" Framing

Rename the category. Stop calling Edison a "design exploration skill." Call it a "decision engine" or "design decision tool." The description leads with the gap: "The missing phase between brainstorming and building." The Check becomes "the decision gate," Explore becomes "the decision process," Audit becomes "the decision audit."

**Strengths:** Sharp, memorable, differentiating. When someone scans a skill marketplace, "decision engine" stands apart from "code generator" or "design tool." It names a category that does not yet exist.

**Weaknesses:** "Decision engine" sounds enterprise-y and abstract. The Edison metaphor (trying 1000 materials) is about exploration, not decision-making per se. This framing might lose the research-first identity that makes Edison distinctive.

### Approach B: "The Missing Phase" Framing

Keep the current identity but reposition around the gap. The tagline shifts from "get design decisions right" to something like "the phase between brainstorming and building." The description explicitly names the tools on either side — "FigJam helps you brainstorm. v0 helps you build. Edison helps you decide." The Check, Explore, and Audit modes stay named as they are, but they are contextualized as components of the decision phase.

**Strengths:** Positions Edison relationally, which is how people actually think about tools ("I use X for Y, but I need something for Z"). Naming the gap explicitly helps the user self-identify. Does not require renaming anything internal.

**Weaknesses:** Defining yourself in relation to other tools is inherently fragile — if those tools expand into the decision space, the positioning evaporates. Also, most Edison users are Claude Code developers, not FigJam users. The comparison may not resonate.

### Approach C: "Research Before Commitment" Framing

Double down on what Edison already does best — research — and frame it as the reason decisions get made well. The tagline becomes something like "systematic research before commitment." This leans into the Edison metaphor (1000 materials before the filament) and the research-first philosophy. The gap is implied: nobody else does research before building; they either brainstorm (divergent, unstructured) or generate (convergent, no research).

**Strengths:** Authentic to what Edison actually is. The research phase is Edison's genuine differentiator — no other tool dispatches parallel research agents. The Edison/filament metaphor already communicates this. This framing survives competitive shifts because it is about capability, not positioning relative to others.

**Weaknesses:** "Research" sounds academic and slow. Does not explicitly name the decision gap, which means the user must infer it. Less punchy for marketplace listings where you have one line to differentiate.

## Recommended Path: Hybrid of B and C

The positioning should do two things: (1) name the gap explicitly so users can self-identify, and (2) anchor it in Edison's genuine capability (research) rather than an abstract category claim.

**Concrete recommendation:**

1. **Tagline/description:** Lead with the gap, anchor in the method. "The missing phase between brainstorming and building — systematic research before commitment." This is Approach B's gap-naming plus Approach C's authenticity.

2. **Marketplace description:** Replace "Design exploration skill" with "Design decision skill." The word "exploration" suggests wandering; "decision" suggests arriving somewhere. Keep "research-first" and "progressively-deepening" as qualifiers.

3. **The Check's language:** When the Check fires, it should frame itself as a decision gate, not an exploration gate. Current: "Before I build [feature], this scores on questions X, Y. I think exploration would save us from building the wrong thing." Proposed: "Before I build [feature], there's a design decision here that scores [X, Y]. I think researching this first would save us from building the wrong thing." The shift from "exploration" to "design decision" and "researching" is subtle but positions every interaction in the decision gap.

4. **README one-liner:** Change "Get design decisions right before writing code" to something that names the gap. Candidate: "The design decision phase that AI skipped." This is provocative (which is good for GitHub/awesome lists) and true (which is good for trust). It frames Edison as filling a hole that the industry created when it jumped from brainstorming tools to code generation tools.

5. **Do NOT rename the modes.** Check, Explore, and Audit are clear and well-understood. The positioning change is in the framing around them, not in the modes themselves.

## Unchallenged Assumptions

1. **Users think in phases.** The "gap between brainstorming and building" assumes people conceptualize their workflow as sequential phases. Some developers do not use brainstorming tools at all — they go from idea to code. For those users, the "gap" framing may not resonate because there is no gap in their workflow.

2. **The gap is permanent.** FigJam, Miro, v0, and other tools may expand to cover decision-making. Figma's blog already discusses "reasoning capture." If FigJam adds decision support, Edison's "missing phase" positioning weakens.

3. **"Decision" is the right word.** The priority says "decision gap" but Edison's actual process is more like structured exploration that produces decisions. Calling it a "decision tool" may set expectations for something more focused (like a decision matrix) than what Edison actually delivers (a multi-round research and exploration process).

4. **Marketplace listing matters.** This analysis assumes the primary discovery channel is skill marketplaces and GitHub. If Edison spreads primarily through word-of-mouth or blog posts, the one-line description matters less than the experience of using it.

5. **Naming competitors helps.** Approach B explicitly names FigJam and v0. This assumes those comparisons help rather than confuse. Edison users may not use those tools and may find the comparison irrelevant or off-putting.
