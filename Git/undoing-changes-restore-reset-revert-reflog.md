# Undoing Changes in Git

## Case 1 – Modified but Not Staged

- File changed but not added.
- Restore it with:

git restore file.txt


- Resets file to last commit.

---

## Case 2 – Staged but Not Committed

- Unstage with:

git restore --staged file.txt


- Keeps file changes.
- Removes from staging area.

---

## Case 3 – Bad Commit Not Pushed

### Soft Reset
- Moves HEAD back.
- Keeps changes staged.

git reset --soft HEAD~1


### Mixed Reset
- Keeps changes in files.
- Removes staging.

git reset HEAD~1


### Hard Reset
- Deletes commit and file changes.

git reset --hard HEAD~1


- Dangerous.
- Only for local commits.

---

## Case 4 – Bad Commit Already Pushed

- Use revert instead of reset.
- Creates a new commit undoing changes.

git revert HEAD


- Safe for shared branches.

---

## Git Log and Reflog

### git log --oneline
- Shows commit history.

### git reflog
- Tracks every HEAD movement.
- Can recover deleted commits.
- Useful after resets.
