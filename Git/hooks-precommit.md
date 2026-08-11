# Git Hooks and Pre-Commit

## What Are Git Hooks?

- Scripts triggered by Git events.
- Examples:
  - pre-commit
  - pre-push
  - post-commit

---

## Native Hooks Location

.git/hooks/


- Shell scripts.
- Not easily shared across teams.

---

## Pre-Commit Framework

- Uses YAML config.
- Hooks stored in repo.
- Installed with:

pre-commit install


---

## Example Checks

- formatting
- Terraform validation
- YAML linting
- secret scanning
- file size checks

---

## Behaviour

- Runs automatically before commit.
- Blocks commit if checks fail.
- Can auto-fix files.

---

## Benefits

- Prevent broken code.
- Enforce standards.
- Catch mistakes early.
- Works locally and in CI.
