# Over The Wire Bandit Game

## Bandit Level 13 → Level 14

**Challenge:**
The password for the next level is stored in /etc/bandit_pass/bandit14 and can only be read by user bandit14. For this level, you don’t get the next password, but you get a private SSH key that can be used to log into the next level. Look at the commands that logged you into previous bandit levels, and find out how to use the key for this level.



**Solution:**

```23:23:linux-notes.md
mkdir /tmp/bandit12
cp data.txt /tmp/bandit12
cd /tmp/bandit12
xxd -r data.txt
```

### Explanation:

- -i specifies an identity key
- SSH can authenticate using keys instead of passwords

Password: 8ZjyCRiBWFYkneahHwxCv3wb2a1ORpYL

**What I learned:**
SSH keys provide secure passwordless authentication.