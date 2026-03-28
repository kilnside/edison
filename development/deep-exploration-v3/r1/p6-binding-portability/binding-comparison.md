# Binding Comparison: Same Spec, Four Formats

Shows how Edison's Phase 8 binding for a hypothetical "Auth System" spec would look across platforms.

---

## Scenario

Edison produced `deep-exploration/synthesis/DEFINITIVE-SPEC.md` for a project's auth system. The spec has sections for Auth, Mobile Auth, and Session Management. Implementation files live in `src/auth/`, `src/mobile/auth/`, and `src/session/`.

---

## 1. CLAUDE.md (Current Edison Binding)

Single flat file at project root. All triggers in one section.

```markdown
# CLAUDE.md

## Active Design Specs
- [Auth System]: deep-exploration/synthesis/DEFINITIVE-SPEC.md
  - When working on files in src/auth/**, read the [Auth] section FIRST
  - When working on files in src/mobile/auth/**, read the [Mobile Auth] section FIRST
  - When working on files in src/session/**, read the [Session Management] section FIRST
```

**Characteristics:**
- Flat structure, all rules in one file
- Claude Code-only — no other tool reads CLAUDE.md
- Path globs are convention, not enforced
- Can become cluttered with multiple specs

---

## 2. AGENTS.md (Recommended — Directory-Scoped)

Root file plus directory-scoped overrides. Read by 16+ tools.

**Root: `AGENTS.md`**
```markdown
## Design Specs

This project uses Edison design specs. The active spec is at
`deep-exploration/synthesis/DEFINITIVE-SPEC.md`.

Before modifying auth, mobile auth, or session code, read the relevant
section of the spec. Directory-scoped AGENTS.md files contain specific
guidance.
```

**`src/auth/AGENTS.md`**
```markdown
## Auth Implementation Guide

Read `deep-exploration/synthesis/DEFINITIVE-SPEC.md` — section "Auth" —
before modifying any file in this directory.

Key constraints from spec:
- MUST use PKCE flow for all OAuth providers
- MUST NOT store tokens in localStorage
- Verification: all auth routes return 401 for expired tokens
```

**`src/mobile/auth/AGENTS.md`**
```markdown
## Mobile Auth Implementation Guide

Read `deep-exploration/synthesis/DEFINITIVE-SPEC.md` — section "Mobile Auth" —
before modifying any file in this directory.

Key constraints from spec:
- MUST use biometric fallback when available
- MUST NOT require re-auth more than once per 24h
```

**`src/session/AGENTS.md`**
```markdown
## Session Management Guide

Read `deep-exploration/synthesis/DEFINITIVE-SPEC.md` — section "Session Management" —
before modifying any file in this directory.

Key constraints from spec:
- MUST invalidate all sessions on password change
- MUST NOT extend session beyond 30 days
```

**Characteristics:**
- Directory-scoped — agents see relevant rules when touching relevant files
- Cross-platform — Cursor, Copilot, Codex, Gemini CLI all read these
- Hierarchical — subdirectory files override/supplement root
- Spec constraints are co-located with the code they govern
- More files to manage, but each is small and focused

---

## 3. .cursor/rules/ (Cursor-Specific)

MDC format files with glob patterns and metadata.

**`.cursor/rules/auth-spec.mdc`**
```
---
description: Auth system design spec compliance
globs: src/auth/**
alwaysApply: false
---

Before modifying auth code, read the design spec at
`deep-exploration/synthesis/DEFINITIVE-SPEC.md`, section "Auth".

Key constraints:
- Use PKCE flow for all OAuth providers
- Never store tokens in localStorage
- All auth routes must return 401 for expired tokens
```

**`.cursor/rules/mobile-auth-spec.mdc`**
```
---
description: Mobile auth design spec compliance
globs: src/mobile/auth/**
alwaysApply: false
---

Before modifying mobile auth code, read the design spec at
`deep-exploration/synthesis/DEFINITIVE-SPEC.md`, section "Mobile Auth".

Key constraints:
- Use biometric fallback when available
- Never require re-auth more than once per 24h
```

**`.cursor/rules/session-spec.mdc`**
```
---
description: Session management design spec compliance
globs: src/session/**
alwaysApply: false
---

Before modifying session code, read the design spec at
`deep-exploration/synthesis/DEFINITIVE-SPEC.md`, section "Session Management".

Key constraints:
- Invalidate all sessions on password change
- Never extend session beyond 30 days
```

**Characteristics:**
- YAML frontmatter with glob patterns — explicit file scoping
- Cursor-only format
- `alwaysApply: false` means rules activate only when matching files are in context
- Clean separation per concern, but proprietary format

---

## 4. Generic Format (Platform-Agnostic Intermediate)

What Edison could generate internally before writing to any platform.

```json
{
  "spec": "deep-exploration/synthesis/DEFINITIVE-SPEC.md",
  "bindings": [
    {
      "section": "Auth",
      "paths": ["src/auth/**"],
      "constraints": [
        { "type": "MUST", "rule": "Use PKCE flow for all OAuth providers" },
        { "type": "MUST_NOT", "rule": "Store tokens in localStorage" },
        { "type": "VERIFICATION", "rule": "All auth routes return 401 for expired tokens" }
      ]
    },
    {
      "section": "Mobile Auth",
      "paths": ["src/mobile/auth/**"],
      "constraints": [
        { "type": "MUST", "rule": "Use biometric fallback when available" },
        { "type": "MUST_NOT", "rule": "Require re-auth more than once per 24h" }
      ]
    },
    {
      "section": "Session Management",
      "paths": ["src/session/**"],
      "constraints": [
        { "type": "MUST", "rule": "Invalidate all sessions on password change" },
        { "type": "MUST_NOT", "rule": "Extend session beyond 30 days" }
      ]
    }
  ]
}
```

**Characteristics:**
- Machine-readable intermediate representation
- Edison generates this, then renders to whatever platform format is needed
- Constraints extracted from DEFINITIVE-SPEC.md task blocks
- Could be stored as `.edison/bindings.json` for re-rendering on platform change

---

## Comparison Matrix

| Dimension | CLAUDE.md | AGENTS.md | .cursor/rules | Generic |
|-----------|-----------|-----------|---------------|---------|
| **Tools supported** | 1 (Claude Code) | 16+ | 1 (Cursor) | N/A (intermediate) |
| **Scoping mechanism** | Path globs in text | Directory hierarchy | YAML glob patterns | JSON path arrays |
| **Files created** | 1 | 1 root + N directories | N .mdc files | 1 JSON |
| **Schema** | Convention | Free Markdown | MDC with frontmatter | Structured JSON |
| **Constraint co-location** | No (all in root) | Yes (per directory) | Yes (per rule file) | Yes (per binding) |
| **Maintenance burden** | Low (one file) | Medium (multiple files) | Medium (multiple files) | Low (one file) |
| **Ecosystem trajectory** | Stable but isolated | Growing standard | Stable but proprietary | Edison-internal |
| **Spec reference style** | Section pointer | Section pointer + inline constraints | Section pointer + inline constraints | Full constraint extraction |

## Recommendation

AGENTS.md as primary target, with the generic JSON as an internal intermediate. This lets Edison:
1. Generate bindings once in a structured format
2. Render to AGENTS.md for cross-platform compatibility
3. Optionally render to CLAUDE.md for Claude-specific directives
4. Support future formats (Cursor .mdc, etc.) by adding renderers without changing the core
