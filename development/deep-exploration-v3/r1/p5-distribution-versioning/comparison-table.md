# Versioning Approaches: Comparison Table

| Dimension | None (Status Quo) | SemVer in Frontmatter | SemVer + Changelog + Compat | Full VS Code Model |
|-----------|-------------------|----------------------|-----------------------------|--------------------|
| **Version tracking** | marketplace.json only, not in skill file | Version travels with SKILL.md | Version + history + constraints | Version + history + constraints + automation |
| **User knows what changed** | No | No (number without context) | Yes (changelog) | Yes (changelog + release notes) |
| **User knows if update is safe** | No | Partial (SemVer signals intent) | Yes (compat fields + changelog) | Yes (engine check + pinning) |
| **Breaking change visibility** | Silent | Major version bump signals | Changelog explains what broke and why | Automated warning before update |
| **Maintenance cost** | Zero | Near-zero (bump a number) | Low (changelog discipline per release) | Medium-high (releases, update checker, pinning logic) |
| **Dual-source risk** | Low (one version in marketplace.json) | Medium (frontmatter + marketplace.json) | Medium (frontmatter + marketplace.json + changelog) | High (4+ places to synchronize) |
| **Ecosystem leadership** | None — follows the crowd | Minimal — one field | Moderate — reusable pattern | Strong — published standard |
| **Adaptability to future standard** | Easy (nothing to migrate) | Easy (rename/move field) | Easy (field rename, changelog stays) | Risky (may conflict with official approach) |
| **Works today (no new tooling)** | Yes | Yes | Yes | Partially (pinning/auto-update need runtime support) |
| **Handles Edison's token-intensity** | No | No | Yes (min_context field) | Yes |
| **ChatGPT plugin failure lesson** | Ignores it | Partially addresses | Addresses core issue (users can trust stability) | Over-addresses for current scale |
| **Implementation effort** | 0 hours | 0.5 hours | 2-3 hours | 8-15 hours |
| **Risk of over-engineering** | N/A | None | Low | High |

## Recommendation

**SemVer + Changelog + Compat** (column 4) is the sweet spot. It addresses the ChatGPT plugin lesson (trust through transparency), creates a reusable pattern for the ecosystem, and works entirely within today's tooling. The full VS Code model solves problems Edison doesn't have yet and depends on runtime capabilities that don't exist.

The key question for Round 2 to challenge: is SemVer even the right versioning scheme for a skill that's essentially a living document?
