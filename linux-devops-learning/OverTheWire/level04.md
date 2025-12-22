# Over The Wire Bandit Game

## Bandit Level 3 → Level 4

**Challenge:**
The password is stored in a file with spaces in its name.

**Solution:**

```23:23:linux-notes.md
cat "spaces in this filename"
```

### Explanation:

- Quotes treat the filename as a single argument
- Without quotes, the shell splits on spaces

Password: UmHadQclWmgdLOKQ3YNgjWxGoRMb5luK

**What I learned:**
Quotes are required when filenames contain spaces.