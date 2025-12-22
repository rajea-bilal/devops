# Over The Wire Bandit Game

## Bandit Level 9 → Level 10

**Challenge:**
The password is the only line that occurs once.

**Solution:**

```23:23:linux-notes.md
sort "data.txt" | uniq -u
```

### Explanation:

- sort groups identical lines together
- uniq -u prints lines that appear only once

Password: UsvVyFSfZZWbi6wgC7dAFyFuR6jQQUhR

**What I learned:**
Text-processing tools can find patterns without manual inspection.