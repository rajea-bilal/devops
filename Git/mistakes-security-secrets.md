# Common Git Mistakes

## Forgetting to Pull

- Push rejected.
- Someone else committed first.
- Use pull before starting work.

---

## Force Pushing to Shared Branches

- Can delete others’ work.
- Dangerous on main.
- Use only with care.

---

## Committing Secrets

- API keys
- tokens
- .env files
- credentials

- Bots scan public repos.
- Rotate secrets immediately.

---

## Not Using .gitignore

- node_modules
- OS files
- secrets
- build artifacts

---

## Merging Without Review

- PRs catch bugs.
- Prevent accidental changes.

---

# Git Security and Secrets Hygiene

## Prevention Tools

- git-secrets
- trufflehog
- pre-commit hooks

---

## If a Secret Leaks

- Revoke key.
- Rotate credentials.
- Remove from history using:
  - git-filter-repo
  - BFG

---

## Audit History

- git log
- bots for detection
- server-side hooks
