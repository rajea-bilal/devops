# Commit Hygiene

## Writing Good Commit Messages

- Describe exactly what changed.
- Focus on one logical change.
- Examples:
  - fix navbar alignment
  - add auth middleware
  - add analytics module

---

## One Change Per Commit

- Avoid mixing features and fixes.
- Easier debugging.
- Easier rollback.

---

## Squashing Before Merge

- Combine noisy WIP commits.
- Keeps main branch clean.
- Common in PR workflows.

---

## Avoid Noisy History

- Avoid:
  - fix
  - final
  - test again
- Avoid repeated merges between same branches.

---

# Git Commit Amend

## Amend Message or Content

git commit --amend


- Edit last commit.
- Add missing files.
- Change commit message.

---

## After Push

- Amend rewrites history.
- Requires force push.
- Communicate with team.
