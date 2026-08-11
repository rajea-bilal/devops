# Linux Module – DevOps Learning Notes

Linux fundamentals from a DevOps angle: who is allowed to do what, how processes are managed, and how to pull signal out of text on the command line.

---

## Notes

| File | Covers |
| --- | --- |
| [linux-notes.md](linux-notes.md) | File permissions — owner, group, others; read/write/execute; reading `ls -l`; numeric permission modes |
| [linux-notes02.md](linux-notes02.md) | Root and `sudo` — what the root account is, why normal users are restricted, ownership changes |
| [linux-notes03.md](linux-notes03.md) | Text processing — `grep`, `awk`, `sed`, and piping them together |
| [linux-commands.md](linux-commands.md) | Command reference built up while working through the module |

Screenshots referenced by the notes live in `screenshots/`.

---

## OverTheWire — Bandit

Write-ups for levels 0 through 13 of the [Bandit wargame](https://overthewire.org/wargames/bandit/), a series of SSH-based puzzles that force you to actually use the filesystem and command line rather than read about it.

Each write-up records the challenge, the command that solved it, and — the part that matters — why that command was the right one.

[Levels 0–13 →](OverTheWire/)

Passwords are included since Bandit's are public and identical for everyone; the value is in the reasoning, not the answer.

---

## Suggested order

1. `linux-notes.md` — permissions, because everything else assumes them
2. `linux-notes02.md` — root and sudo
3. `linux-notes03.md` — text processing
4. `OverTheWire/` — apply all of it under pressure
5. `linux-commands.md` — reference, dip in as needed

---

## Key ideas

- **Permissions answer three questions:** who owns this, who else is allowed, and what are they allowed to do. Owner / group / others, each with read, write, execute.
- **On a directory,** `x` means "can enter", not "can execute" — a directory you can read but not enter is nearly useless.
- **Root is not a person.** It's a system account with unlimited permissions, created at install. Normal users are restricted precisely so that a mistake stays small.
- **Text processing is a pipeline.** `grep` filters lines, `awk` picks fields out of them, `sed` rewrites them. Chained with `|`, they replace a surprising amount of scripting.
