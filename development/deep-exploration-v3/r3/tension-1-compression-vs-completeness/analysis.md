# Tension 1: Spec Compression vs. Self-Improvement Completeness

**Round 3 — The Provocateur**
**Tension:** P1 (compress to ~270 lines) vs. P3 (self-improvement adds ~20-30 lines)

---

## The Removed Constraint

**Self-improvement instructions must live inside SKILL.md.**

Every prior round assumed that for Edison to learn from its runs, the learning mechanism must be described in the spec itself. R1 proposed 20-30 lines of dual-level evolution instructions. R2 trimmed it but still allocated ~15 lines for task-level capture plus ~5 for meta-level. Both rounds treated "lines in SKILL.md" as the only delivery vehicle for self-improvement behavior.

Remove this constraint entirely. Zero lines for self-improvement in SKILL.md. Not one.

---

## What Becomes Possible

### 1. The Spec Becomes a Pure Execution Document

Right now, SKILL.md tries to be two things: an execution spec (how to run Edison) and a meta-spec (how to improve Edison). These are different audiences reading at different times. The execution spec is read every invocation. The meta-spec is read... when? During synthesis? After a run? On explicit `/edison evolve`? The answer keeps shifting because the meta-spec is a parasite on the execution spec's context budget.

With zero self-improvement lines, SKILL.md is only about running Edison. Every line earns its context budget. P1's ~270 line target becomes ~270 lines of pure signal, not ~250 lines of execution plus ~20 lines of "and here is how to learn from what you just did" bolted on at the end.

### 2. Self-Improvement Becomes a Companion Skill

Create `edison-evolve/SKILL.md` -- a separate skill that:

- Reads `.edison/profile.md` and the exploration output directory
- Reads Claude Code's memory for Edison-tagged observations
- Analyzes patterns across runs
- Proposes SKILL.md mutations as diffs
- Records what was proposed, accepted, and rejected

The user invokes it with `/edison evolve`. It never loads during a normal Edison run. This is not a theoretical architecture -- it is exactly how Unix tools work. `git` does not contain `git bisect`'s full logic inline. `make` does not embed `automake`. The evolution tool reads the execution tool's outputs. Separation of concerns.

The token economics are stark: self-improvement instructions consume context on every Edison invocation but only provide value on the rare occasions someone runs `/edison evolve`. That is like paying rent on an apartment you visit once a month. A companion skill loads those instructions only when needed -- zero carrying cost.

### 3. Hooks Replace Instructions

Claude Code hooks fire after commands complete. A post-Edison hook could:

```json
{
  "event": "after_skill",
  "skill": "edison",
  "command": "append-observations"
}
```

This hook fires after every Edison run and deposits structured observations into `.edison/observations.log` or into Claude Code's memory system. No SKILL.md lines needed. The capture mechanism is infrastructure, not instruction.

R2 already established that user signals (overrides, corrections, rejections) are the gold-standard feedback. A hook captures these by diffing what Edison proposed against what the user actually did -- after the conversation, not during it. This is architecturally superior to inline capture because the hook sees the final state, not intermediate states.

### 4. Self-Improvement Becomes Implicit in Output Structure

Here is the insight R1 and R2 missed entirely:

**Edison already produces self-improvement data. It just does not label it.**

Every Edison run generates:
- `priorities.md` -- what Edison thought mattered
- `R1-SYNTHESIS.md` -- what resolved easily vs. what did not
- `CONVERGENCE.md` -- which round won for each priority
- The user's edits to these files (corrections, reorderings, deletions)

A companion skill or hook does not need Edison to "capture lessons." It needs Edison to produce structured output -- which it already does. The self-improvement mechanism is a *reader* of Edison's existing outputs, not a *writer* of new capture instructions.

This reframes the entire P3 priority. R1 and R2 spent their time designing a capture mechanism (what to log, where to store it, how to graduate it). But the capture already exists in Edison's output directory. What is missing is not capture -- it is *interpretation*. And interpretation belongs in a separate tool that can evolve independently of the spec it interprets.

### 5. The Evolution Pace Decouples from the Execution Pace

When self-improvement lives inside SKILL.md, every change to the improvement mechanism requires a SKILL.md version bump (P5). The improvement logic and the execution logic are versioned together, tested together, and break together.

With separation: Edison's execution spec can be rock-stable (v3.0 for months) while the evolution companion skill iterates rapidly (v0.1, v0.2, v0.3 weekly). Users who want stable Edison get it. Users who want experimental evolution opt into the companion. This is the plugin model that every successful tool ecosystem converges on.

---

## The Strongest Counter-Argument

If self-improvement is not in SKILL.md, Edison has no awareness that it should be learning. A companion skill can read outputs, but Edison itself will not structure those outputs *for* the companion. There is a difference between "Edison happens to produce data a companion can read" and "Edison intentionally structures its output to enable learning."

This is real. But it has a clean solution: Edison's output format (the directory structure, the synthesis documents, the checkpoint tables) is already designed. Adding one line to SKILL.md -- a single directive in the output format -- handles it:

> After final synthesis, append a structured `## Run Metadata` section to CONVERGENCE.md: priorities count, resolution rounds, user modifications, fallbacks triggered.

That is 2 lines. Not 20-30. The difference between "Edison captures learning data" (20-30 lines of mechanism design) and "Edison appends a metadata block to its existing output" (2 lines of output format) is the difference between embedding the engine and leaving a hook point.

---

## The Radical Departure

**What if Edison's self-improvement were someone else's skill entirely?**

Not `edison-evolve` (still in Edison's namespace). A generic `skill-evolve` that works on ANY Claude Code skill. It reads any skill's outputs, analyzes patterns, proposes mutations. Edison is the first customer, not the only one.

This sounds wild but consider: the mechanisms R1 and R2 designed for Edison (capture user signals, detect resolution patterns, propose spec diffs) are not Edison-specific. Any skill that produces structured output could benefit from the same analysis. The brainstorming skill could learn which framing produces better options. The code review skill could learn which review patterns the user values.

Edison designing its own evolution mechanism is like a web app building its own analytics platform. You use a general tool. You instrument your outputs. The general tool does the analysis. Edison's contribution is producing clean, structured, analyzable output -- which it already does by design.

---

## Kernel Extraction

**Even if this full proposal is rejected, the insight that should survive is:**

Self-improvement in SKILL.md is a category error. The spec describes *execution behavior* -- what Edison does when invoked. Self-improvement is *meta-behavior* -- what happens to Edison between invocations. These operate at different times, for different audiences, at different frequencies. Embedding meta-behavior in the execution spec costs context on every run, delivers value on almost no runs, and couples two concerns that evolve at different rates. The minimum viable self-improvement is not 20 lines of capture instructions -- it is 2 lines of structured output metadata that a separate mechanism can read. Edison's job is to produce excellent explorations. Learning from those explorations is a different job.

---

## Line Budget Implications

If this proposal is adopted:

| Addition | Lines | Source |
|----------|-------|--------|
| P3 self-improvement mechanism | 0 | Externalized to companion skill |
| P3 metadata output directive | 2 | Added to Phase 7 output format |
| P2 fallback clauses | 15-20 | NON-NEGOTIABLE, stays |
| P5 version/changelog frontmatter | 3-5 | Stays |
| P6 binding changes | 5-8 | Stays |
| P8 validation plan in output | 3-5 | Stays |
| **Total additions** | **28-40** | |
| **Headroom from ~270 body** | **230-242** | Significant breathing room |

Compare to R2's plan where P3 alone consumed 15-20 lines. The externalization frees 15-18 lines that can absorb other priorities' additions or simply remain as headroom for future needs.

---

## What This Does NOT Solve

1. **The companion skill does not exist yet.** This proposal trades spec lines for a new deliverable. Someone has to build `edison-evolve/SKILL.md`.
2. **Hook infrastructure may not be ready.** Claude Code hooks for post-skill events may not exist in the form described. The hook-based capture path is aspirational.
3. **Users must opt in.** A companion skill is not discovered automatically. Users who install Edison but not the companion get zero self-improvement. Whether this is a feature (explicit opt-in) or a bug (incomplete default experience) depends on your philosophy.

The Provocateur's answer to objection 3: if self-improvement is so critical that it must be in the default install, then R1 and R2's 20-30 lines were underweight anyway -- you cannot build a meaningful learning system in 20 lines of markdown instructions. If it is not critical enough for a separate install, then it is not critical enough to consume context on every run. The tension resolves in one direction or the other. The middle ground (a few lines of inline self-improvement) is the worst option: too little to work well, too much to be free.
