# Git Stash

## Purpose

- Temporarily save unfinished work.
- Switch branches quickly.
- No commit required.

---

## Creating a Stash

git stash push -m "work in progress"


- Saves staged and unstaged changes.
- Working tree becomes clean.

---

## Listing Stashes

git stash list


---

## Applying a Stash

git stash apply


- Restores changes.
- Keeps stash entry.

---

## Applying and Removing


git stash pop


- Restores changes.
- Deletes stash.

---

## Clearing All Stashes

git stash clear


---

## Common Use Case

- Pause feature work.
- Fix urgent bug on main.
- Push hotfix.
- Restore feature work.
