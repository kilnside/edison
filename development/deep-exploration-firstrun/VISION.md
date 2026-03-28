# Edison First-Run Vision

## Core Principles
1. Edison can't do research until it understands the project context
2. On first invocation in a new project, Edison needs to see what the user is doing and identify their needs
3. This should feel like Edison orienting itself, not interrogating the user
4. The output of first-run feeds directly into better research questions and priority identification

## The Feeling
Like a senior consultant's first day — they walk around, look at the codebase, read the docs, understand the domain, and THEN ask smart questions. Not a form to fill out.

## Target Users
Any developer invoking Edison for the first time in a project. Could be a greenfield project or an established codebase.

## Entry Points
- First `/edison` or `/deep-dive` invocation in a project with no prior Edison artifacts
- Could also self-trigger: Edison detects it has no project context when asked to explore

## Anti-Targets
- This is NOT a project management onboarding
- This is NOT a codebase audit (that's Mode 3)
- This is NOT meant to replace the user describing their vision — it augments it with codebase understanding
