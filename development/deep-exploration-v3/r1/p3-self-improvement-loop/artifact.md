# P3: Self-Improvement Feedback Loop

```mermaid
flowchart TD
    subgraph CAPTURE ["What Triggers Capture"]
        A1[Edison run completes<br/>Check / Explore / Audit] --> C1
        A2[User overrides Edison<br/>reorder, add, reject, skip] --> C1
        A3[Fallback clause triggers<br/>P2 edge case hit] --> C1
        A4[Audit finds gaps<br/>spec vs code mismatch] --> C1
    end

    C1[Event extracted<br/>structured summary of run]

    subgraph STORE ["What Gets Stored"]
        direction TB
        S1[".edison/evolution-log.md<br/>(per-project, append-only)<br/>Run date, mode, metrics,<br/>overrides, fallbacks, outcomes"]
        S2[".edison/profile.md § Lessons<br/>(per-project, curated)<br/>Local adaptations:<br/>skip auth research,<br/>user prefers UX-first ranking"]
        S3["~/.claude/skills/edison/.edison/<br/>meta-observations.md<br/>(global, cross-project)<br/>Patterns seen in 3+ projects"]
    end

    C1 --> S1
    S1 -->|"Lesson extraction<br/>(~2-5K tokens)"| S2

    subgraph FEEDBACK ["How It Feeds Back"]
        direction TB
        F1["Next run in SAME project<br/>Profile + Lessons loaded in Phase 0<br/>Research questions tuned<br/>Priority ranking adjusted"]
        F2["Pattern graduation<br/>Same lesson in 3+ project profiles<br/>→ promoted to meta-observation"]
        F3["'/edison evolve' invoked<br/>Edison reads meta-observations<br/>Generates SKILL.md diff<br/>with evidence from runs"]
    end

    S2 --> F1
    S2 -->|"3+ projects<br/>show same pattern"| F2
    F2 --> S3
    S3 --> F3

    subgraph GATE ["Human Oversight"]
        direction TB
        G1{"User reviews diff"}
        G2[Approve → merge into SKILL.md<br/>Version incremented]
        G3[Reject → record in<br/>§ Failed Mutations<br/>with rationale]
    end

    F3 --> G1
    G1 -->|approve| G2
    G1 -->|reject| G3

    G2 --> R1["New SKILL.md baseline<br/>(Level 4: self-evolving spec)"]
    G3 --> S3

    style CAPTURE fill:#f9f4e8,stroke:#d4a843
    style STORE fill:#e8f0f9,stroke:#4382d4
    style FEEDBACK fill:#e8f9ed,stroke:#43d47a
    style GATE fill:#f9e8e8,stroke:#d44343
    style R1 fill:#d4f0d4,stroke:#2d8a2d,stroke-width:3px
```

## Reading the Diagram

**Yellow (Capture):** Four event types trigger data capture. Edison runs, user corrections, fallback triggers from P2's edge case hardening, and post-implementation audits all produce structured events.

**Blue (Storage):** Three tiers, increasing scope. The evolution log is raw append-only data. Project lessons are curated local adaptations. Meta-observations are cross-project patterns that graduated through the 3-project threshold.

**Green (Feedback):** Three feedback paths at different cadences. Per-run feedback is automatic (profile loads on Phase 0). Pattern graduation is passive (happens when lessons accumulate). Spec evolution is explicit (user invokes `/edison evolve`).

**Red (Gate):** Human always decides. Approved changes become the new baseline. Rejected changes are recorded with rationale to prevent re-proposal (failure memory from Approach 3, incorporated into the recommended Approach 2).

## Key Design Decisions

1. **Task-level is automatic, meta-level is gated.** Profile lessons update without approval (they are advisory, project-scoped). SKILL.md mutations always require human review.

2. **Graduation threshold prevents noise.** A lesson must appear in 3+ project profiles before it becomes a meta-observation. This filters project-specific quirks from universal patterns.

3. **Failure memory prevents cycling.** Rejected mutations are recorded. Edison will not re-propose a change that was already reviewed and rejected, unless the evidence base has changed substantially.

4. **Token cost is marginal.** The capture and lesson extraction add ~2-5K tokens per run. The evolution step (reading meta-observations, generating a diff) is heavier (~20-50K) but runs only on explicit invocation, not every run.
