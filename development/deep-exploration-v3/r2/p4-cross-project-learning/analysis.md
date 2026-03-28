# P4: Cross-Project Learning -- R2 Analysis

**Lens:** The Archaeologist -- What precedents exist? What happened when others tried this?
**Priority type:** Conceptual (primary) / Structural (secondary)

---

## Assumption Verdicts

### #1: Developers actually use Edison across multiple projects
**Verdict: REFINED -- but the cold-start problem is already solved by Claude Code itself.**

The archaeological record is clear: Claude Code already ships a three-tier memory system -- global `~/.claude/CLAUDE.md`, project-level `CLAUDE.md`, and auto-memory in `~/.claude/projects/<project>/memory/`. The first 200 lines (or 25KB) of MEMORY.md load at every session start. Cross-project memories live in `~/.claude/global-memory/`, and at least one practitioner has turned that directory into a git repo for cross-device sync.

This means Edison's proposed `~/.claude/edison/developer.md` is reinventing infrastructure that already exists. Claude Code's auto-memory already accumulates "build commands, debugging insights, architecture notes, code style preferences" across sessions. The question is not whether Edison needs a separate cross-project file, but whether Edison should write to the memory system that already exists.

Frequency concern remains valid -- but is less critical if Edison piggybacks on a system the user already feeds through normal Claude Code usage.

### #3: Pattern extraction from exploration artifacts can be reliably automated
**Verdict: OVERTURNED -- extraction is the wrong metaphor. Deposition is what works.**

Devin's knowledge base offers the key precedent. Devin stores "structured knowledge entries -- bite-sized, persistent context it thinks might matter in future sessions." These are deposited during work, not extracted afterward. The difference matters: extraction requires a post-hoc classification step ("is this portable?"), while deposition captures in the moment when the context is richest.

The awesome-cursorrules community shows what happens with extraction-after-the-fact: 28.7% line duplication across repos, because people copy whole rule files rather than extracting the portable parts. Manual extraction does not scale; automated extraction is an unsolved NLP problem. Deposition -- writing small, typed observations as they occur -- sidesteps the extraction problem entirely.

For Edison: instead of a post-synthesis extraction step, Edison should deposit observations during synthesis. When a tradeoff resolves in a surprising way, write it then. When a research question returns nothing, note it then. The observation is a byproduct, not a separate pipeline.

### #4: The developer profile stays small enough to read every invocation
**Verdict: CONFIRMED with precedent-based mitigation.**

VS Code Settings Sync is the cautionary tale. Profile management results in "a lot of bloat in the settings.json file" because tools store whatever settings exist at any given moment with no pruning. Browser password managers exhibit "credential drift" -- a growing inventory of entries unrelated to active use, requiring monthly manual pruning.

Claude Code's own solution: cap at 200 lines or 25KB, whichever comes first. This is the right model. A hard ceiling with LRU-style or relevance-based eviction beats unbounded append. R1 proposed no cap. The fix is simple: cap the developer profile at 50 entries or 3KB. When full, the oldest entry with the lowest reuse count drops.

---

## Diff Against R1

### CHANGED: Storage location
- **R1:** `~/.claude/edison/developer.md` (custom global file)
- **R2:** Write to `~/.claude/CLAUDE.md` or `~/.claude/projects/<project>/memory/` (existing Claude Code memory system)
- **Why:** Claude Code already loads global memory at session start. A separate file means Edison must implement its own loading, its own size management, its own cross-device story. The existing system handles all of this. Edison should be a good citizen of the memory system, not a parallel one.

### CHANGED: Write mechanism
- **R1:** Post-synthesis extraction step that identifies portable patterns
- **R2:** In-synthesis deposition -- observations written as they occur during Final Synthesis, tagged with `[edison]` for filterability
- **Why:** Extraction is an unsolved problem (assumption #3 overturned). Deposition during the moment of insight is reliable because the agent already has the context. Devin's knowledge base validates this pattern.

### CHANGED: Size management
- **R1:** No pruning mechanism proposed
- **R2:** Hard cap (50 entries / 3KB). Eviction by staleness (date) + low reuse. Entries carry a `last-used` date updated when Edison reads them during Phase 0.
- **Why:** Every precedent (VS Code, password managers, Claude Code's own 200-line cap) shows unbounded accumulation fails.

### KEPT: Portable vs. non-portable taxonomy
- R1's distinction (decision patterns = portable, file paths = not) is correct and well-drawn. No change needed.

### KEPT: Stack fingerprint concept
- Keying observations by stack signature remains useful for relevance matching. But it becomes a tag on deposited observations rather than a section header in a structured profile.

### KEPT: Privacy-by-locality
- Local-only storage remains the right default. The concern about proprietary stack patterns (assumption #5) is real but mitigated by deposition: the developer sees each observation as it is written and can veto it.

---

## Should P3 and P4 Merge?

**Verdict: Yes, partially. They share plumbing but differ in audience.**

R1 Synthesis already identified this: "The meta-observations file IS the cross-project mechanism." The Archaeologist lens confirms it. Devin does not separate "self-improvement" from "cross-project learning" -- its knowledge base serves both purposes. The observations that improve Edison's behavior on the next project are the same observations that improve Edison's behavior on THIS project.

However, the two priorities have different consumers:
- **P3 (Self-Improvement)** produces observations that feed back into SKILL.md evolution. Consumer: the skill author.
- **P4 (Cross-Project Learning)** produces observations that feed into Phase 0 of the next project. Consumer: the running Edison instance.

**Proposed merge:** A single observation system (deposition-based, capped, stored in Claude Code's existing memory) that serves both purposes. Observations are tagged by type: `[preference]`, `[stack-pattern]`, `[process-outcome]`, `[edge-case]`. P3's evolution pipeline reads `[process-outcome]` and `[edge-case]` tags. P4's Phase 0 reads `[preference]` and `[stack-pattern]` tags. One system, two read paths.

This eliminates the dual-storage problem from P3 (project-local `.edison/` + global `~/.claude/skills/edison/.edison/meta-observations.md`) and the separate-file problem from P4.

---

## Cross-Priority Insights

**From P6 (Binding Portability):** AGENTS.md is tool-agnostic. Storing Edison observations in Claude Code's memory system is explicitly NOT tool-agnostic -- it ties Edison to Claude Code. This is acceptable because Edison IS a Claude Code skill. If Edison ever becomes multi-tool, observations would need a tool-agnostic format, but that is not today's problem.

**From P8 (User Signal):** Proxy research findings from one project (e.g., "users of recipe apps prefer visual-first onboarding") are highly portable to similar domains. These are the highest-value cross-project observations. The deposition model captures them naturally -- they emerge during Research Synthesis (Phase 2) and can be tagged `[domain-insight]`.

**From P1 (Spec Compression):** If observations live in Claude Code's memory rather than a custom file, Edison adds zero lines to SKILL.md for cross-project learning infrastructure. The spec only needs to say "deposit observations to user memory during synthesis" -- maybe 5 lines.

---

## Kernel Extraction

Even if the full deposition model is rejected, the insight that should survive: **Edison should not build its own memory system. Claude Code already has one. Be a tenant, not a landlord.**

---

RESEARCH_NEEDED: Does Claude Code's auto-memory system support structured tags or namespacing that would let Edison filter its own observations from general auto-memory entries?

---

*R2 challenge complete. Recommending P4 graduate to RESOLVED, contingent on P3 adopting the shared observation system.*
