# Over The Wire Bandit Game

## Bandit Level 6 → Level 6

**Challenge:**
Find a file that is:

- Human-readable
- 1033 bytes
- Not executable

**Solution:**

```23:23:linux-notes.md
find . -type f -size 1033c ! -executable
cat ./maybehere07/.file2
```

### Explanation:

- find . searches from the current directory
- -type f looks only for files
- -size 1033c matches exact size
- ! -executable excludes executable files

Password: koReBOKuIDDepwhWk7jZC0RTdopnAYKh

**What I learned:**
find can filter files using multiple conditions at once.