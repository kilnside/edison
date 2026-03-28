# Kernel: Identity Stack

**Source:** Tension 2 -- Edison's Identity (R3, The Provocateur)
**Constraint removed:** Edison must choose one identity (tenant/citizen/sovereign)

---

## The Kernel

Identity is a stack, not a choice.

```
Layer 4: Category    -> Sovereign   "I am the decision tool"
Layer 3: Methodology -> Sovereign   "I explore with research-rounds-synthesis"
Layer 2: Output      -> Citizen     "My results are AGENTS.md-compatible"
Layer 1: Memory      -> Tenant      "I use the host's memory system"
```

**Analogy:** PostgreSQL uses your filesystem (tenant), speaks SQL (citizen), and owns MVCC + its query planner (sovereign). Nobody calls this incoherent.

**Principle:** Be a tenant where you sleep, a citizen where you speak, and a sovereign where you think.

---

## Spec Implications

1. **Add sovereignty claim to SKILL.md.** Edison's methodology evolves on Edison's terms, not the platform's. State this explicitly. Not arrogance -- every framework does this.

2. **Dual-format decision records.** `.edison/decisions/` for sovereign consumption (rich, Edison-native). AGENTS.md-compatible binding for citizen portability. Not redundant -- layered.

3. **Sovereign tagging in tenant storage.** Memory deposited into Claude Code's system, but tagged with Edison's taxonomy (`[edison:methodology]`, `[edison:preference]`). The storage is rented; the semantics are owned.

4. **Category claim is non-negotiable.** "The tool for the decision gap" is Edison's sovereign position. It does not require ecosystem permission.

---

## Risk

The boundary between "methodology" (sovereign) and "output format" (citizen) will be contested. If AGENTS.md evolves to prescribe how exploration tools structure their output, Edison faces a choice: comply (citizen) or diverge (sovereign). The kernel says: comply at Layer 2, diverge at Layer 3. But the layers may not be as clean in practice as they are in theory.

## Opportunity

If Edison's decision record format gains adoption (even 5-10 projects), it creates gravitational pull. Other tools writing AGENTS.md-compatible output could also write Edison-compatible decision records. The sovereign format becomes a de facto standard not because Edison demanded it, but because it was more useful than the generic alternative.
