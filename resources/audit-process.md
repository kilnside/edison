# Audit Process (Spec vs. Code)

Compare an existing design spec against the actual codebase. No new exploration — just
an honest diff between "what we said we'd build" and "what we actually built."

## When to Use

- After completing a major implementation phase
- When the user says "does this match the spec?" or "what happened to X?"
- When the Check finds a spec exists but code has diverged
- Periodically, as a health check
- After implementation agents complete a batch of work

---

## The Process

### Step 1: Find the Spec

Use the project profile (`.edison/profile.md`) to locate active specs. Fall back to
searching CLAUDE.md "Active Design Specs" section and `docs/design/`.
If no spec exists, this isn't an audit — route to Explore or just build.

### Step 2: Parse Task Blocks

Edison specs use a dual-structure: narrative sections + embedded task blocks with
MUST/MUST NOT/VERIFICATION fields. Extract these structured fields first — they are
the machine-checkable assertions. For each task block:

```
## Component: [Name]
MUST: [requirements]
MUST NOT: [anti-requirements]
VERIFICATION: [how to check]
```

Use the project profile's directory structure and CLAUDE.md path-based triggers to
locate the implementation files for each component.

**Non-Edison specs:** If no task blocks (MUST/MUST NOT/VERIFICATION) are found, treat
narrative requirements as unstructured assertions and do a best-effort comparison.
Flag that the spec is not in Edison format and coverage metrics may be approximate.

### Step 3: Check Deviations

Read `DEVIATIONS.md` if it exists. Intentional, documented deviations are NOT gaps —
they are acknowledged decisions. Filter them out before scoring.

### Step 4: Produce the Gap Analysis

Write `.edison/audits/[date]-[feature].md` (or update if it exists):

| Component | Spec Field | Spec Says | Current Code | Gap Level |
|-----------|-----------|-----------|-------------|-----------|
| [name] | MUST | [requirement] | [code state, file:line] | None / Partial / Missing |
| [name] | MUST NOT | [anti-requirement] | [code state, file:line] | None / Contradiction |
| [name] | VERIFICATION | [check] | [result] | Pass / Fail |

Gap levels:
- **None** — Code matches spec
- **Partial** — Structure exists but incomplete or different
- **Missing** — Not implemented at all
- **Contradiction** — Code does the opposite (highest priority). Check these against
  DEVIATIONS.md — if documented, downgrade to "Acknowledged Deviation"

### Step 5: Prioritize

1. **Contradictions** (undocumented) — Code does the opposite. Fix first.
2. **Missing critical** — MUST items in core user flows
3. **Failed verifications** — VERIFICATION checks that don't pass
4. **Partial** — Structure exists, needs completion
5. **Missing nice-to-have** — Lower-priority MUST items

### Step 6: Present to User

Show the scoreboard (% coverage by category) and the prioritized gap list.
Ask: "Want to fix these now, or plan a realignment pass?"

### Step 7: Bind Updates

- If gaps are fixed, update VERIFICATION fields in the spec
- If the spec was wrong (implementation revealed better approach), update the spec
  and record the rationale in DEVIATIONS.md
- Update the project profile: record audit date, coverage percentage, any new tensions
