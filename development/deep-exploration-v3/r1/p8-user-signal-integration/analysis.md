# P8 Analysis: User Signal Integration

**Priority:** P8 — User Signal Integration (Tradeoff)
**Agent:** Round 1 — The Engineer
**Self-score:** 4/5

---

## The Problem

Every established design methodology includes real user contact. GV Sprint tests with 5 users on Day 5. IDEO's Empathize phase involves ethnographic observation. Double Diamond puts users in the loop throughout. Edison has zero user contact — it researches what users said elsewhere (forums, reviews, documentation) but never talks to the actual humans who will use what gets built.

The instinct is to call this a fatal gap. But the P7 analysis reveals something important: Edison operates pre-prototype. It sits in the decision phase between brainstorming and building. In GV Sprint, user testing happens on Day 5 — after prototyping on Day 4. In Double Diamond, user testing happens in the second diamond (Develop/Deliver), not the first (Discover/Define). Edison lives entirely in the first diamond. The gap may be real but misplaced — like criticizing a blueprint for not load-testing the building.

Still, the NN/g principle applies: "Process compression, not elimination." Even if Edison is pre-prototype, ignoring user signals entirely means the research phase has a blind spot. The question is whether that blind spot can be addressed without introducing human dependency — which would undermine Edison's core value as a solo-practitioner tool.

## Three Approaches

### Approach A: Proxy Signal Research (No Human Contact Required)

Edison already researches forums, documentation, and competitor products. Formalize this into a structured "user signal scan" during the Research phase. Instead of ad-hoc forum scraping, define specific proxy signal categories that Edison's research agents should always check:

1. **Support tickets / GitHub issues** — what users of similar products actually complain about
2. **App store / product reviews** — sentiment patterns in the category
3. **Forum threads** (Reddit, HN, Stack Overflow) — what real users say they want
4. **Analytics patterns** (if the project has analytics) — what users actually do vs. what they say
5. **Churn signals** — why users leave competing products

Each research agent would be required to include at least one proxy user signal per question cluster, tagged as `USER_SIGNAL: [source] [confidence]`. This makes user voice a first-class research output without requiring the developer to talk to anyone.

**Strengths:** Zero human dependency. Fits Edison's research-first identity. Scales with available data. Can be done in parallel with existing research.

**Weaknesses:** Proxy signals are indirect. They tell you what users of *other* products want, not what *your* users want. For greenfield projects, proxy signals may not exist. There is a real epistemic difference between "Reddit users complained about X in a competitor" and "your user Sarah couldn't find the settings page."

### Approach B: Lightweight User Ping (Minimal Human Contact)

Add an optional step after Research Synthesis: Edison generates exactly one question — the single most important thing that research could not answer — and suggests the developer ask one person. Not a user test. Not an interview. One question to one person, taking under 60 seconds.

Edison would frame it: "Research found conflicting signals about [X]. If you can ask one user 'Would you prefer [A] or [B]?', that would resolve this. If not, I'll proceed with my best inference." The developer can skip it entirely. If they do ask, they paste the answer and Edison integrates it.

**Strengths:** Preserves solo-practitioner accessibility (it is optional and takes seconds). Addresses the epistemic gap that proxy signals cannot. One pointed question based on research findings is more valuable than five generic user interview questions. Honest about the limitation without being preachy.

**Weaknesses:** Any human dependency, even optional, changes the flavor of the tool. Developers who work alone (the core audience) may not have a user to ask. The "optional" nature means it will almost always be skipped, making it a dead feature.

### Approach C: Explicit Scoping — Edison is Pre-Prototype

Do not add user signals at all. Instead, make Edison's position in the workflow explicit and recommend when user testing should happen. The final spec (DEFINITIVE-SPEC.md) would include a section: "Recommended validation before scaling" that identifies which decisions should be user-tested after a prototype exists, which assumptions are riskiest, and what the cheapest test for each would be.

Edison does not do user testing. Edison tells you what to test, when, and how cheaply.

**Strengths:** Honest. Methodologically sound — it acknowledges the limitation rather than pretending proxy signals are equivalent to real user contact. Gives the developer actionable next steps. Keeps Edison's scope clean.

**Weaknesses:** Does not actually integrate user signals — it defers them. If the developer never runs the recommended tests (likely for solo practitioners), the gap remains. Some will read this as "Edison admits it can't do user testing" rather than "Edison knows when user testing belongs."

## Recommended Path: A + C (Proxy Signals with Explicit Scoping)

The best answer combines formalized proxy signal research (Approach A) with honest scoping (Approach C). Here is the concrete recommendation:

1. **During Research (Phase 2):** Add a coverage check requirement that at least 2 of the 8-12 research questions must target proxy user signals. Tag findings as `USER_SIGNAL` with source and confidence. This is a natural extension of the existing "coverage check" that already requires 3+ source categories — add "user voice" as a mandatory category.

2. **During Final Synthesis (Phase 7):** Add a "Validation Plan" section to DEFINITIVE-SPEC.md. For each priority, identify: the riskiest user-facing assumption, the cheapest way to test it post-prototype, and the reversal cost if the assumption is wrong. This is not user testing — it is a research output about what should be tested.

3. **Do NOT add Approach B.** The optional user ping sounds good in theory but will be skipped by 90%+ of users, creating a dead feature that clutters the flow. If a developer wants to ask users questions, they will do so without Edison's prompting.

This combination means Edison does what it does best — research — while being transparent about what it cannot do. The proxy signals improve research quality. The validation plan gives the developer a path to real user contact when they are ready.

## Unchallenged Assumptions

1. **Proxy signals are available for most projects.** If someone is building in a novel category with no competitors and no forums, there are no proxy signals to scrape. Edison's research phase would come back empty-handed on user voice, and the spec would be built entirely on inference.

2. **Solo practitioners do not have access to users.** The entire framing assumes that "talk to users" is a burden. Some solo developers have active Discord communities, beta testers, or even just friends who use the product. Edison might be underestimating its audience's access to user feedback.

3. **Pre-prototype is the right scope boundary.** We assume Edison should not cover post-prototype validation. But if a developer runs Edison, builds a prototype, and then needs validation guidance, they might expect Edison to help — especially since the Audit mode already covers post-implementation review.

4. **One user signal category in research is sufficient.** The recommendation adds user voice as one mandatory research category. But user signals might deserve more weight than, say, technical documentation. Treating them as coequal with other source categories may still underweight them.

5. **The validation plan will be read.** Adding a "Recommended validation" section to the spec assumes developers will read and act on it. If they skip it (like they skip most "future work" sections), it adds length without value.
