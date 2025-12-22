# Over The Wire Bandit Game

## Bandit Level 11 → Level 12

**Challenge:**
The text is rotated by 13 characters (ROT13).

**Solution:**

```23:23:linux-notes.md
cat data.txt | tr 'A-Za-z' 'N-ZA-Mn-za-m'
```

### Explanation:

- tr translates characters
- ROT13 shifts letters by 13 places

Password: 5Te8Y4drgCRfCx8ugdwuEX8KFC6k2EUu

**What I learned:**
character substitution is reversible with the right mapping.