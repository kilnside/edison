---
name: edison-update
description: >
  Update Edison and companion skills to the latest version from GitHub.
  Triggers on: /edison-update, /edison update, "update edison"
---

# Edison Update

Pull the latest Edison from GitHub and reinstall all skills.

## Steps

1. **Find the source repo.** Read `~/.claude/skills/edison/.source-repo`. If it
   exists, use that path. If not, check if `~/Documents/claude/Edison` exists.
   If neither, clone fresh:
   ```bash
   git clone https://github.com/kilnside/edison.git /tmp/edison-update
   ```

2. **Pull latest.**
   ```bash
   cd [repo-path] && git pull
   ```

3. **Run install.**
   ```bash
   ./install.sh
   ```

4. **Report what changed.** Run `git log --oneline -5` and show the user
   recent commits so they know what's new.

5. **Confirm.** Tell the user:
   > Edison updated. Changes are live — no restart needed.
   > Skills load fresh on each invocation.
