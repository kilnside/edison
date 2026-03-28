---
name: edison-evolve
version: 0.1.0
description: >
  Companion skill for Edison. Analyzes exploration outputs and proposes improvements.
  Two modes: end-of-run lightweight capture (personal preferences + universal discoveries),
  and deep analysis across multiple runs. Invoke with /edison evolve for deep analysis.
  Lightweight capture happens automatically at the end of Edison Explore runs.
---

# Edison Evolve

Companion skill that helps Edison learn from its own runs. Two modes:

1. **End-of-run capture** — lightweight, happens after every Explore run
2. **Deep analysis** (`/edison evolve`) — reads across all runs, proposes SKILL.md changes

---

## End-of-Run Capture

After an Edison Explore completes (Phase 8 Handoff done), scan the session for two
types of signal before closing out.

### Personal Preferences

Look for patterns the user demonstrated during this run:

- **Priority reordering** — user changed the order Edison proposed
- **Priority additions** — user added priorities Edison missed
- **Priority removals** — user removed priorities Edison suggested
- **Depth preference** — user chose Focused when Edison recommended Full, or vice versa
- **Research steering** — user redirected research questions
- **Round overrides** — user accepted R2/R3 over R1 for specific priority types

**When found, offer casually:**

> "I noticed you moved UX priorities above technical ones. Want me to remember that
> for next time?"

If the user says yes, append to `.edison/profile.md` under `## Lessons`:

```markdown
## Lessons
- [2026-03-28] [preference] User prefers UX priorities ranked above technical priorities.
  Evidence: reordered in 2026-03-28 exploration. Confidence: low (1 observation).
```

Lessons carry timestamps and confidence levels:
- 1 observation = low confidence
- 2-3 observations = medium
- 4+ observations = high

**Staleness:** Lessons older than 6 months with low confidence and no reuse can be
suggested for removal during the next end-of-run capture.

### Universal Discoveries

Look for insights that could improve Edison for all users:

- **Spec ambiguity** — Edison hit a fallback clause (evidence that the spec was unclear)
- **Research pattern** — a research question category consistently returns nothing or
  consistently returns high-value results
- **Round effectiveness** — R2 challenges consistently overturn R1 for a specific
  priority type, suggesting R1's approach for that type is weak
- **Process gap** — something happened that the spec doesn't address at all
- **Threshold issue** — the Check scored something as 0-1 that turned out to need
  Explore, or scored 4-5 on something trivial

**When found, offer with weight:**

> "During this exploration, we discovered that [specific insight with evidence].
> This could improve Edison for everyone using it. Want to share it with the
> Edison community?"

If the user says yes:
1. Compose a GitHub issue with:
   - **Title:** "[Edison Evolve] [short description]"
   - **Body:** The insight, the evidence (which run, what happened, how many times),
     and a proposed change to SKILL.md if applicable
   - **Label:** `evolution`
2. Create the issue:
   ```
   gh issue create --repo kilnside/edison \
     --title "[Edison Evolve] [description]" \
     --body "[composed body]" \
     --label "evolution"
   ```
3. Tell the user: "Shared! You can track it at [issue URL]."

**If `gh` is not available or not authenticated:** Save the discovery to
`.edison/evolution-log.md` with a note: "Could not submit — save for later with
`/edison evolve submit`."

**If the user says no:** Still log the discovery to `.edison/evolution-log.md`
for potential future submission. Don't ask again for the same discovery.

---

## Deep Analysis (`/edison evolve`)

Invoked explicitly. Reads across all Edison runs in the current project and
(if accessible) across projects via Claude Code memory.

### What It Reads

1. `.edison/profile.md` — current project lessons
2. `.edison/explorations/*/synthesis/CONVERGENCE.md` — Run Metadata sections
3. `.edison/evolution-log.md` — accumulated discoveries not yet submitted
4. Claude Code memory entries tagged `[edison:*]`
5. `.edison/audits/*.md` — gap analysis results

### Analysis Steps

#### Step 1: Pattern Detection

Scan all available data for recurring patterns:

- **Consistent user overrides** — the same type of change across 3+ runs
- **Fallback trigger frequency** — which fallbacks fire most often (spec weakness)
- **Resolution patterns** — which priority types resolve in which rounds
- **Research effectiveness** — which question categories yield signal vs noise
- **Audit gaps** — which MUST/VERIFICATION fields consistently fail

#### Step 2: Categorize

For each pattern found, classify:

- `[personal]` — reflects this user's preference, not a spec issue
- `[universal]` — reflects a genuine spec improvement opportunity
- `[inconclusive]` — not enough data to tell

Heuristic: If the pattern would change Edison's behavior for ALL users and the change
is an improvement (not just a preference), it's universal. If reasonable users would
disagree about whether the change is better, it's personal.

#### Step 3: Present

Show the user a summary table:

| # | Pattern | Type | Evidence | Proposed Change |
|---|---------|------|----------|-----------------|
| 1 | UX priorities always reranked above technical | personal | 4/5 runs | Default UX above technical in your profile |
| 2 | Null research fallback triggers on auth topics | universal | 3/5 runs | Add auth to known-sparse research domains |
| 3 | R2 Economist lens consistently overturns R1 for cost priorities | inconclusive | 2/5 runs | Need more data |

#### Step 4: Act

For each pattern the user confirms:

- **Personal:** Update `.edison/profile.md` Lessons section
- **Universal:** Compose and submit GitHub issue (same process as end-of-run)
- **Inconclusive:** Log for future analysis, revisit after more runs

#### Step 5: Submit Pending

Check `.edison/evolution-log.md` for unsent discoveries (from end-of-run captures
where `gh` wasn't available). Offer to submit them now.

---

## Evolution Log Format

`.edison/evolution-log.md` accumulates discoveries:

```markdown
# Edison Evolution Log

## 2026-03-28 | Exploration: auth-redesign
- [universal] Null research fallback triggered on 4/6 auth questions.
  Proposed: add auth/identity to known-sparse domains in research phase.
  Status: submitted (issue #12)

- [personal] User reordered P3 above P1 (UX over architecture).
  Status: saved to profile lessons

## 2026-03-25 | Exploration: notification-system
- [universal] All-MURKY fallback unclear — agent treated top-3 as independent
  priorities, not tensions. Proposed: clarify fallback language.
  Status: pending submission
```

---

## What This Skill Does NOT Do

- **Never modifies SKILL.md directly.** All changes go through GitHub issues → human review.
- **Never submits without explicit user consent.** Every universal discovery is offered, not pushed.
- **Never re-proposes rejected changes.** If the user says "no" to a discovery, it's logged as rejected and not raised again.
- **Never runs during an Edison exploration.** This skill loads only at end-of-run or on explicit `/edison evolve`. Zero context cost during normal Edison operation.

---

## Relationship to Edison

Edison Evolve is a separate skill that reads Edison's outputs. Edison does not know
Edison Evolve exists. The only connection is:

1. Edison appends Run Metadata to CONVERGENCE.md (2 lines in Edison's spec)
2. Edison Evolve reads that metadata plus all other Edison artifacts

This separation is intentional: Edison's execution spec should not contain its own
improvement mechanism. Execution and meta-improvement operate at different times,
for different audiences, at different frequencies.
