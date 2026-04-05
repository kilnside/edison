---
name: edison
version: 3.0.0
description: >
  Design decision skill — the phase between brainstorming and building. Research-first,
  progressively-deepening analysis that produces self-executing specs. Three modes: Check (quick
  gate), Explore (deep dive), Audit (spec vs code). Triggers on: /iterate, /edison, /deep-dive,
  "/edison audit", "explore all the options", "are we missing anything?", "what happened to the spec?",
  or any situation where design decisions need validation before code.
---

# Edison

The design decision phase that AI skipped.

Named after Edison who tried 1,000 materials before finding the right filament. Systematic
exploration before commitment produces results that "just build it" never could.

Four insights:

1. **AI's unique value is research, not interrogation.** Scan the landscape. Bring back
   intelligence the user didn't have. Questions are a last resort.
2. **Great specs that nobody follows are worse than no specs.** Every mode includes a
   binding mechanism that makes the spec impossible to ignore during implementation.
3. **Exploration saves tokens long-term.** Building the right thing once costs less than
   building the wrong thing and rebuilding. Spare no expense.
4. **Edison's purpose is creative discovery, not convention compliance.** Know established
   patterns the way an artist knows art history — as context, not instructions. When
   Edison independently arrives at a known pattern, that's validation through understanding.
   When it doesn't, that's where the real value lives.

Edison's exploration methodology — research, progressive rounds, synthesis — is Edison's
own. It is not derived from or constrained by any host tool's conventions.

---

## Routing

```
User request or self-trigger
│
├── "Does the code match the spec?" / /audit
│   └── Audit (read resources/audit-process.md)
│
├── Is there a design decision being made?
│   ├── No → Just build
│   └── Yes → Does a spec already exist?
│       ├── Yes → Does the code match it?
│       │   ├── Yes → Build from the spec
│       │   └── No → Audit (then fix)
│       └── No → How complex is the decision?
│           ├── Simple (1-2 choices) → Brainstorming skill (if available, else handle inline)
│           └── Complex (3+ interconnected) → The Check
│               ├── Score 0-1 → Build
│               └── Score 2+ → Explore (read resources/explore-phases.md)
```

### Triggers

| Phrase | Route |
|--------|-------|
| `/edison`, `/iterate`, `/deep-dive` | Start at the Check, escalate if needed |
| `/edison audit`, "what happened to the spec?", "does this match?" | Audit |
| "explore all the options", "spare no expense" | Explore directly |
| "are we missing anything?" | The Check |
| `--autonomous`, "run autonomously", "don't wait for me", "I'll be AFK" | Explore in autonomous mode (see below) |

### Autonomous Mode

When invoked with `--autonomous` or equivalent language ("run autonomously",
"don't wait for me", "I'll be AFK", "just go"), Edison runs with blanket
gate pre-approval. Gates remain internal synthesis checkpoints — Edison still
pauses to write VISION.md, priorities.md, and the final spec at each gate —
but Edison does not wait for user confirmation between phases.

**What changes:**
- Vision Capture: Edison writes VISION.md and proceeds without confirmation
- Priority Identification: Edison writes priorities.md and proceeds without confirmation
- Handoff: Edison presents the spec, binds it, auto-commits, and reports completion

**What stays the same:**
- All rounds, synthesis, and the Review Gate run exactly as in interactive mode
- Fork questions still appear on the Guidance Board (the user may be watching)
- The final spec is presented; the user can still reject or request changes after
- Steering remains available via interrupt (Ctrl+C / new message)

**Announce at start:** "Running autonomously. I'll present the spec when done.
Interrupt anytime if you want to steer." One line. No ceremony.

**Evidence basis:** Autonomous runs on Guidance/cannabinoid-personalization
and GlazeLN/annotation-v2 produced no quality loss vs interactive runs. Gates'
value was synthesis-forcing, not user-input-requiring. (kilnside/edison#3)

### Self-Trigger

Pause and run the Check if you're about to:
- Implement something that contradicts or isn't covered by an existing spec
- Make UX decisions inline while coding
- Build a feature that's interconnected (3+ features), precedent-setting, or opinionated

Do NOT self-trigger for: established patterns, CRUD, bug fixes, config changes, tests,
or work the user explicitly said "just build."

---

## The Check (10 seconds)

Five questions. Unweighted. Threshold: 2 of 5.

| # | Question | Signal |
|---|----------|--------|
| 1 | **Interconnected?** (3+ features) | "oh, and this could also be used for..." |
| 2 | **Precedent-setting?** (future code copies this) | New directory, hook pattern, or convention |
| 3 | **Opinionated?** (strong reactions) | User-facing text, API shape, architecture |
| 4 | **Irreversible?** (expensive to change) | Database schema, public API, navigation |
| 5 | **Multi-stakeholder?** (different users/teams) | Admin vs end-user, mobile vs desktop |

Score 0-1: Build. Flag assumptions.
Score 2+: Recommend Explore. Present the case. User decides.

### Implicit Security Flag (independent of score)

Ask one additional question separately from the 5 Check questions:

> **Cross-user data read?** Does this feature query rows the current user did not create
> (social feeds, discovery, shared content, leaderboards, notifications)?

If YES, Edison must include `CROSS-USER READ` fields on affected Components in the
DEFINITIVE-SPEC and flag the need for explicit RLS / access control verification.
This flag triggers regardless of the Check score — a simple CRUD feature with a
cross-user read still needs policy review, even if it's a "just build it" call.

Why: functional tests cannot detect silently-blocked cross-user queries. The failure
mode is "empty results," which is indistinguishable from "no data yet." Only explicit
policy review catches it. (kilnside/edison#13)

### Pre-Check

Glob for specs in `.edison/`, CLAUDE.md "Active Design Specs", AGENTS.md.
If the task conflicts with an active spec, flag immediately and route to Audit.

### What to Say

> "Before I build [feature], there's a design decision here that scores [X, Y]. I think
> researching this first would save us from building the wrong thing. This will be
> thorough — expect [estimate]. Want me to explore, or should I go ahead?"

**Be honest when Edison is NOT the right tool.** Score 0-1 = "This doesn't need Edison —
just build it." Don't upsell. Edison's value is precision, not frequency.

---

## Phase 0: Project Scan (First-Run Only)

Check if `.edison/profile.md` exists. If yes, read it. If no, scan the project.

Scan runs in parallel with user input. Never block.

**Tier 1 — Always read:** User's request, CLAUDE.md, AGENTS.md, package manifest (top 50
lines), directory tree (2 levels), README (first 80 lines). Try each in priority order —
use what exists, note what's missing. Near-empty profile is valid for greenfield projects.

**Tier 2 — Only if Explore triggers:** Existing specs (glob `.edison/`, `docs/design/`),
git log (last 15 commits), entry point file.

**Cross-project context:** Read Edison-tagged entries from user memory (`[edison:preference]`,
`[edison:stack-pattern]`) to inform the profile with lessons from prior projects.

Produce `.edison/profile.md` (~500 tokens): Identity, Architecture, Active Specs,
Established Patterns, Lessons, Edison History. Updates append-on-event, not every run.

---

## Explore Overview

Research-first, progressively-deepening design exploration. Token-intensive by design.

**For full execution detail, read `resources/explore-phases.md`.**

### Cost Estimation (always present before starting)

| Depth | Priorities | Estimated Tokens | When |
|-------|-----------|-----------------|------|
| Check only | N/A | ~2-5K | Score 0-1 |
| Focused (2 rounds) | 3-5 | ~150-250K | Moderate stakes |
| Full (3 rounds) | 5-9 | ~350-550K | High stakes |
| Deep (3+ rounds) | 7-10 | ~500-700K | "Spare no expense" |

Present estimate with ROI framing. Offer depth options. Default: Full for scores 4-5,
Focused for scores 2-3. Per-priority graduation reduces actual cost.

### Phase Summary

| Phase | What | Gate |
|-------|------|------|
| 1. Vision Capture | Structure what the user said (not interrogate) | User confirms vision |
| 2. Research | 1-5 agents scan real-world sources. Must include user-signal questions. | None (intelligence gathering) |
| 3. Priorities | 5-10 key decisions with classification and dependencies | User confirms list |
| 4. Round 1 | The Engineer: best known solution per priority. Self-score 1-5 → graduation. | Checkpoint table |
| 5. Round 2 | The Designer: challenge assumptions through analytical lenses. CONTESTED/MURKY only. | Checkpoint table |
| 6. Round 3 | The Provocateur: per-tension, not per-priority. Kernel extraction. | Checkpoint table |
| 7. Synthesis | CONVERGENCE.md + DEFINITIVE-SPEC.md + artifact. Run Metadata appended. Observations deposited. | None |
| 7.5. Review Gate | Adversary + New Hire stress-test the spec document. SHIP IT / NEEDS WORK / STOP. | STOP blocks handoff |
| 8. Handoff | Present synthesis first. Drill down on request. Bind to AGENTS.md. Auto-commit and push. | User approves + binding complete |

**Focused (2-round) path:** Skips Round 3. Final Synthesis draws from R1 and R2 only.
Unresolved tensions are flagged in CONVERGENCE.md as "open questions for implementation."

**Early exit:** If all priorities RESOLVED after any round, skip remaining rounds.

**All-MURKY fallback:** If no priorities resolve after R2, force R3 on the top-3 MURKY
priorities treated as tensions against each other — or escalate to user: "These priorities
aren't resolving. Want to reframe them or proceed to synthesis with what we have?"

**Null research fallback:** If >50% of questions return nothing, compress what exists,
flag low-evidence state, and bias R1 toward conservative approaches.

### Output

All output to `.edison/explorations/[date]-[feature]/`:

```
.edison/explorations/[date]-[feature]/
├── VISION.md
├── RESEARCH-BRIEF.md
├── priorities.md
├── r1/, r2/, r3/
├── R1-SYNTHESIS.md, R2-SYNTHESIS.md
└── synthesis/
    ├── CONVERGENCE.md (includes Run Metadata)
    ├── DEFINITIVE-SPEC.md (includes Validation Plan)
    └── [definitive artifact]
```

### Auto-Save

After Phase 8 handoff (or after Audit completes), automatically commit `.edison/` and
any AGENTS.md/CLAUDE.md binding changes. Push if a remote is configured. Don't ask.
Edison artifacts are project infrastructure — losing them breaks the design chain.

Commit message format: `edison: [feature-name] [mode] complete`

---

## Cleanup

Runs automatically at the end of every Explore and Audit (Phase 8 Step 6). Also
available manually via `/edison clean`.

- Scan `.edison/explorations/` and `.edison/audits/` for artifacts not referenced by
  any active AGENTS.md or CLAUDE.md binding
- Present the list: "These explorations aren't referenced by any active spec. Archive them?"
- Archived artifacts move to `.edison/archive/` — preserved but not read during Phase 0
- Update `.edison/profile.md` Active Specs to remove archived entries
- Skip silently if nothing is stale

---

## Audit Overview

Compare an existing spec against the codebase. No new exploration.

**For full execution detail, read `resources/audit-process.md`.**

**When:** After implementation, when the user asks "does this match?", when the Check
finds spec/code divergence, or periodically as a health check.

**Steps:** Find Spec → Parse Task Blocks → Check Deviations → Gap Analysis → Prioritize
→ Present → Bind Updates.

**Non-Edison specs:** If no MUST/VERIFICATION task blocks found, treat narrative
requirements as unstructured assertions. Do best-effort comparison. Flag that the spec
is not in Edison format and coverage metrics may be approximate.

**Output:** `.edison/audits/[date]-[feature].md`

---

## Key Principles

| Principle | Meaning |
|-----------|---------|
| Research before opinions | Scan the landscape. Questions are a last resort. |
| Spare no expense | Token-intensive by design. Warn, then go hard. |
| Specs must be self-executing | MUST/VERIFICATION fields ARE the checklist. |
| Per-priority, not per-round | Synthesis picks the best answer from available rounds. |
| Graduated depth | RESOLVED priorities freeze. Only unresolved advance. |
| Preserve everything | Never delete alternatives. Round 3 kernels are especially valuable. |
| Steering is non-blocking | User can skip, reprioritize, or stop at any time. |
| Gates are blocking (by default) | Vision, Priority, and Handoff gates require user confirmation. In autonomous mode, gates remain as synthesis checkpoints but don't wait for input. |
| The user is always right | "Just build it" = build it. "The spec is wrong" = update the spec. |
| Creative contribution awareness | Know what's established ground vs. genuinely novel territory. Spend energy on paradigm shifts. |

---

## Scaling

| Situation | Approach |
|-----------|----------|
| 1-2 decisions | Brainstorming skill (or handle inline) |
| 3-5 priorities, moderate | Focused Explore (2 rounds) |
| 5-9 priorities, high stakes | Full Explore (3 rounds) |
| 10+ priorities | Split into sub-topics, run Explore on each |
| "Does the code match?" | Audit only |
| "Spare no expense" | Full Explore + extra research depth |

## Anti-Patterns

- Running Explore on bug fixes or config changes
- Running Explore when a spec already covers the feature (use Audit)
- Skipping Phase 8 handoff (binding is the whole point)
- Using the Check as procrastination — score 0-1 = just build
- Running Audit without a spec to compare against
- Asking the user questions when you could research the answer
- Watering down exploration to save tokens
- Running all priorities through all rounds when some resolve early

## Edison's Output Contract

DEFINITIVE-SPEC.md uses a predictable structure any downstream tool can consume:

- Each `## Component:` block is an independent implementation unit
- `IMPLEMENTS:` traces to a named priority from the exploration
- `MUST:` / `MUST NOT:` are binary-testable requirements
- `VERIFICATION:` describes how to confirm the requirement was met
- `DEPENDS ON:` declares file/component prerequisites
- `AGENT INSTRUCTION:` provides specific implementation directive

Any skill that reads markdown with these fields can plan from an Edison spec.
No Edison installation required to consume the output.

## Relationship to Other Skills

Edison is standalone in capability. These companion skills enhance the workflow:

- **Brainstorming**: Simple decisions (Check score 0-1). If no brainstorming skill is
  installed, Edison handles simple decisions inline.
- **Implementation Planning**: Edison's spec feeds into planning. Plans should reference
  task blocks via IMPLEMENTS fields.
- **Frontend Design**: Round agents can use this for visual artifact quality.
- **Code Simplification**: Run after implementation to clean up spec-matched code.
- **Edison Evolve** (`/edison evolve`): Companion skill that reads Edison's outputs and
  proposes SKILL.md improvements based on accumulated user signals. Separate install.

None of these are required. Edison works alone. Edison works better with them.
