# Git Module – DevOps Learning Notes

Git beyond `add`, `commit`, and `push` — the workflows teams actually depend on, and how to get out of trouble when something goes wrong.

---

## Notes

| # | File | Covers |
| --- | --- | --- |
| 1 | [branching-rebase-merge.md](branching-rebase-merge.md) | Branching strategy, merge vs. rebase, squashing, and when each is appropriate |
| 2 | [undoing-changes-restore-reset-revert-reflog.md](undoing-changes-restore-reset-revert-reflog.md) | `restore`, `reset`, `revert`, and recovering apparently lost work with `reflog` |
| 3 | [stash.md](stash.md) | Setting work aside safely and getting it back |
| 4 | [commit-hygiene-squash-amend.md](commit-hygiene-squash-amend.md) | Writing useful commits, `--amend`, and interactive squashing |
| 5 | [hooks-precommit.md](hooks-precommit.md) | Git hooks and automating checks before a commit lands |
| 6 | [remotes-ssh-auth.md](remotes-ssh-auth.md) | Remotes, SSH keys, and authentication |
| 7 | [mistakes-security-secrets.md](mistakes-security-secrets.md) | Common mistakes, and what to do when a secret gets committed |
| 8 | [git-at-scale-monorepos.gitops.md](git-at-scale-monorepos.gitops.md) | Monorepos, GitOps, and how Git works in large organisations |

Read them in that order — each builds on the one before.

---

## Key ideas

- **Rebase rewrites history, merge preserves it.** Rebase for a clean local branch before sharing; never rebase something others have already pulled.
- **`reflog` is the safety net.** Almost nothing is truly lost — Git remembers where `HEAD` has been, even after a hard reset.
- **`revert` is safe, `reset` is not.** `revert` adds a new commit undoing an old one; `reset` moves the branch pointer and can discard work.
- **A committed secret stays in history.** Deleting the line in a later commit does not remove it. Rotate the credential first, then clean the history.
- **Hooks move checks earlier.** Catching a lint error or a stray secret at commit time is far cheaper than catching it in CI.

---

Notes are written in plain language with correct Git terminology, focused on DevOps workflows. They're revision material and a public learning log.
