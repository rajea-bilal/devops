# Over The Wire Bandit Game

## Bandit Level 8 → Level 9

**Challenge:**
The password is in data.txt next to the word millionth.

**Solution:**

```23:23:linux-notes.md
find . -type f -name "data.txt"
grep "millionth" data.txt
```

### Explanation:

- grep searches for lines containing text
- It prints the full matching line

Password: cvX2JJa4CFALtqS87jk27qwqGhBM9plV

**What I learned:**
grep is essential for searching inside files.