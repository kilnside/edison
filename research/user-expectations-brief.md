# Research Brief: Developer Expectations for AI Design/Planning Tools

**Date:** 2026-03-27
**Focus:** What developers consider table stakes vs. delightful, and where Edison fits

---

## 1. Trust Is Low and Falling -- Even as Adoption Rises

The 2025 Stack Overflow Developer Survey found that 84% of developers use AI tools, but trust in AI accuracy dropped from 40% to 29% year-over-year. The #1 frustration (66% of respondents) is "solutions that are almost right, but not quite." 75% of developers said they would still turn to a human "when I don't trust AI's answers."

**This matters because:** Edison's value proposition is not "AI gives you the answer" -- it is "AI surfaces intelligence you did not have, then you decide." The trust data validates this framing. Tools that position AI as an oracle will lose credibility. Tools that position AI as a researcher who brings back findings will match how developers already think about AI: a fast, fallible collaborator.

## 2. Specs Beat Mockups Beat Code Scaffolds

The spec-driven development movement (GitHub Spec Kit, Kiro, Augment Code) shows clear developer preference: specs are the primary source of truth, not generated code. Developers describe specs as "living documents that help you think through edge cases." Code scaffolds are valued when guided by specs, but mockups are seen as secondary -- developers "prefer text-based syntax" over visual artifacts.

**This matters because:** Edison's Explore mode should output specs and decision matrices, not mockups or code. The handoff (Phase 8) producing a "build contract" is exactly what the market is converging toward.

## 3. Speed Wins, But Not at the Cost of Substance

The average time adults spend on a single task before switching has dropped to 9.8 minutes. Screen attention spans are at 47 seconds. The METR study found that AI reasoning models have a "50% time horizon" of ~50 minutes (tasks that take humans 50 minutes, AI succeeds at 50% of the time). Meanwhile, developers using tools like Cursor value "flow" -- the tool that "stays out of the way."

However, a METR randomized trial also showed developers using AI were 19% *slower* but *believed* they were 24% faster. The perception of speed matters as much as actual speed.

**This matters because:** A 30-minute Edison exploration is risky from an attention standpoint. The 3-mode design (Check as a quick gate, Explore as a deep dive) is the right architecture -- but Explore needs clear progress signals and intermediate value delivery. Users will abandon a black-box process after ~10 minutes. They will stay engaged with one that delivers findings incrementally.

## 4. Token Cost Is a Real Psychological Barrier

Token prices dropped 10x per year for equivalent performance, but actual bills are rising because reasoning models consume 100x more tokens through internal "thinking." 85% of companies miss their AI spending forecasts. Developers using tools like Cline actively tune "cost vs quality" per task.

**This matters because:** Edison's multi-agent parallel exploration is inherently token-expensive. Users need to understand the cost-value tradeoff upfront. Consider: showing estimated token cost before an Explore run, offering depth levels (quick/standard/deep), and making Check mode genuinely cheap so it does not create cost anxiety as a gate.

## 5. Spec Drift Is a Recognized Pain Point with Emerging Solutions

"Spec drift" -- when code no longer matches its specification -- is now a named problem with dedicated tooling (GitHub Spec Kit, SpecSync). These tools validate alignment at commit-time. Developers report that when they cannot trust documentation, they must read source code directly, which slows development significantly.

**This matters because:** Edison's Audit mode addresses a real, growing market need. The fact that GitHub shipped Spec Kit and AWS launched Kiro with spec-driven development as a core feature validates that checking code against spec is becoming table stakes, not a nice-to-have.

## 6. Exploration Prevents Expensive Rework

Research consistently shows 30-50% of software project effort goes to rework. Reworked code costs 2.5x more than getting it right initially. IBM's data shows fixing bugs after release costs 30x more than catching them during design. One case study describes an e-commerce company spending $180K on an AI chatbot that failed within 3 days because they "didn't invest time to clearly identify desired business outcomes."

**This matters because:** This is Edison's core thesis validated by data. The cost of NOT exploring is 2.5-30x the cost of exploring. Edison should surface this framing explicitly -- "this exploration costs X tokens but could prevent Y hours of rework."

## 7. Developers Prefer Research Over Interrogation

Developers value agents that combine autonomous research with targeted clarifying questions. The preference is not for pure autonomy or pure Q&A, but for agents that "take a question, search multiple sources, synthesize findings, and ask clarifying questions." Pure interrogation (20 questions before doing anything) is seen as friction.

**This matters because:** Edison's design insight #2 -- "AI's unique value isn't asking good questions, it's bringing back intelligence" -- is confirmed. The current design of researching first and proposing second, with questioning as a last resort, matches developer expectations precisely.

---

## Summary: Table Stakes vs. Delightful

| Table Stakes (must have) | Delightful (differentiator) |
|---|---|
| Fast initial response (< 30 seconds to first value) | Progressive deepening with visible intermediate findings |
| Spec-formatted output, not just prose | Cost transparency before expensive operations |
| Clear "here is what I found" before "here is what I recommend" | Audit mode that catches spec drift at commit-time |
| User retains final decision authority | Multi-perspective exploration (literal/creative/wild) |
| Cheap quick-check mode for gatekeeping | Build contracts that bind to implementation |

---

Sources:
- [Stack Overflow 2025 Developer Survey - AI Trust](https://stackoverflow.blog/2025/12/29/developers-remain-willing-but-reluctant-to-use-ai-the-2025-developer-survey-results-are-here/)
- [Closing the Developer AI Trust Gap](https://stackoverflow.blog/2026/02/18/closing-the-developer-ai-trust-gap/)
- [METR Developer Productivity Study](https://metr.org/blog/2025-07-10-early-2025-ai-experienced-os-dev-study/)
- [Spec-Driven Development with GitHub Spec Kit](https://developer.microsoft.com/blog/spec-driven-development-spec-kit)
- [Spec Drift: The Hidden Problem AI Can Help Fix](https://www.kinde.com/learn/ai-for-software-engineering/ai-devops/spec-drift-the-hidden-problem-ai-can-help-fix/)
- [Token Burnout: Why AI Costs Are Climbing](https://labs.adaline.ai/p/token-burnout-why-ai-costs-are-climbing)
- [Slow AI: Designing User Control for Long Tasks](https://jakobnielsenphd.substack.com/p/slow-ai)
- [Best AI Coding Agents 2026: Real-World Developer Reviews](https://www.faros.ai/blog/best-ai-coding-agents-2026)
- [Software Development Waste](https://newsletter.techworld-with-milan.com/p/software-development-waste)
- [Addy Osmani: How to Write a Good Spec for AI Agents](https://addyo.substack.com/p/how-to-write-a-good-spec-for-ai-agents)
- [Martin Fowler: Understanding Spec-Driven Development](https://martinfowler.com/articles/exploring-gen-ai/sdd-3-tools.html)
