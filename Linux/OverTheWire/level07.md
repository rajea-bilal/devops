# Over The Wire Bandit Game

## Bandit Level 7 → Level 8

**Challenge:**
Find a file owned by bandit7 and group bandit6.

**Solution:**

```bashfind / -type f -user bandit7 -group bandit6 2>/dev/null
cat /var/lib/dpkg/info/bandit7.password
```

### Explanation:

- / searches the entire filesystem
- -user filters by owner
- -group filters by group
- 2>/dev/null hides permission errors

Password: DXjZPULLxYr17uwoI01bNLQbtFemEgo7

**What I learned:**
Linux permissions protect files, and errors can be redirected away.