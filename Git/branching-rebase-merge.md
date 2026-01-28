# Branching, Rebase, and Merge

## Trunk-Based Development

- Teams work directly on `main` or very short-lived branches.
- Branches usually live hours or days, not weeks.
- Requires:
  - strong CI pipelines
  - automated testing
  - quality gates
- Used in fast-moving organisations.
- Allows frequent shipping while keeping stability.

---

## Why Rebase Is Used

- Rebase rewrites commit history on a branch.
- Makes it look like the branch started from the latest `main`.
- Keeps history linear and clean.
- Often used before merging PRs.
- Requires coordination if the branch is shared.

---

## Merge vs Rebase

### Merge:
- Creates a merge commit.
- Preserves full branch history.
- No rewriting of commits.

### Rebase:
- Replays commits on top of another branch.
- Produces a clean linear history.
- Rewrites commit hashes.

---

## Squashing Commits with Interactive Rebase

- Used to combine many commits into one.
- Keeps PR history tidy.
- Done with:

git rebase -i HEAD~3


- Change later commits to `squash`.
- Edit final commit message.
- Produces one clean commit.

---

## Force Push After Rewriting History

- Rebase and amend rewrite commits.
- After pushing previously, a force push is required.
- Must be communicated to the team.
- Dangerous on shared branches.
