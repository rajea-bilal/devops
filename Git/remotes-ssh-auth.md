# Remotes and SSH Authentication

## Linking Local Repo to Remote

git remote add origin URL


---

## Pushing First Time

git push -u origin main


- Sets upstream tracking.

---

## Pulling Changes

git pull


- Keeps branch up to date.

---

## SSH vs HTTPS

### SSH:
- Uses keys.
- No password prompts.
- Preferred for developers.

### HTTPS:
- Requires tokens/passwords.
- Easier initial setup.

---

## SSH Authentication Flow

- Host verified and saved in known_hosts.
- GitHub checks uploaded public key.
- Confirms identity.
- No shell access is granted.
