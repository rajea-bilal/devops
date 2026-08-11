# DevOps Learning Journey

Notes, scripts, and projects from learning DevOps from the ground up — starting with the shell and Linux fundamentals, then networking, Git in professional workflows, and now containers.

Everything here is written by me as I learn it. The goal is to explain concepts in plain language rather than collect commands I don't understand.

**Currently learning:** Docker — images, containers, and Compose.

---

## Featured project — Deploying a site to AWS EC2 by hand

I took my Next.js portfolio off Vercel and deployed it to a Linux server I configured and secured myself, to find out what managed hosting had been doing on my behalf.

![My portfolio served over HTTPS from my own EC2 instance](Networking/Deployment_project/images/result.png)

**Stack:** AWS EC2 (Ubuntu) · NGINX · Cloudflare DNS · Certbot + Let's Encrypt

What it involved: opening the right ports via Security Group firewall rules, understanding NGINX's `sites-available` / `sites-enabled` symlink model, serving a static build from `/var/www`, issuing and deploying a TLS certificate, and repointing DNS to the EC2 public IP.

**Where it ended up:** the portfolio is back on Vercel today, and that's the most useful thing this project taught me. Serving a static export by hand meant every content change was a manual rebuild, re-upload, and reload on the server. There was no path from "commit" to "live" that didn't involve me SSH-ing in. That gap is precisely what CI/CD pipelines exist to close, and hitting it deliberately is why it's next on my list. The server work did its job: I now know what Vercel is automating for me.

**→ [Full write-up, step by step with screenshots](Networking/Deployment_project/README.md)**

---

## Modules

| Module | What it covers | Status |
| --- | --- | --- |
| [Bash](Bash/) | Shell scripting — variables, loops, conditionals, functions, argument parsing, error handling, file I/O | Scripts complete |
| [Linux](Linux/) | Permissions, root and sudo, processes, text processing, plus 13 OverTheWire Bandit levels | Notes complete |
| [Networking](Networking/) | Ports and protocols, TCP vs UDP, the OSI model, and the EC2 deployment project | In progress |
| [Git](Git/) | Branching, rebasing, undoing changes, stashing, hooks, remotes, secrets, Git at scale | Notes complete |
| Docker | Images, containers, Dockerfiles, volumes, networking, Compose | Next up |

---

## How this went

**December 2025 — Linux and the shell.** Started with how Linux thinks about ownership and permissions, then root vs. sudo, processes, and text processing with `grep`, `awk`, and `sed`. Worked through the OverTheWire Bandit wargame alongside it, writing up each level's reasoning rather than just the password.

**December 2025 – January 2026 — Bash.** Built a ten-level "Bash game" for myself, each level a script solving a progressively harder problem: looping over files, conditionals, argument parsing, a file sorter, a multi-file log searcher, and a directory-change monitor. Two boss levels combining everything.

**January 2026 — Networking.** Ports, protocols, TCP vs UDP, and the OSI model. Finished the module by deploying my portfolio to EC2 with NGINX and HTTPS, which made DNS and firewall rules concrete in a way notes hadn't.

**January 2026 — Git.** Beyond `add`/`commit`/`push` into what teams actually rely on: rebase vs. merge, recovering work with reflog, commit hygiene, pre-commit hooks, and handling secrets that shouldn't have been committed.

**Now — Docker.** Picking the journey back up with containers.

---

## Repository structure

```
.
├── Bash/                        # Shell scripting practice
│   ├── Bash - The Game/         #   10-level self-built challenge series
│   ├── Bash Challenges/         #   Standalone problems
│   ├── Loops&FlowControl/
│   ├── Functions/
│   ├── Error_Handling/
│   └── Reading_Files/
├── Linux/                       # Linux fundamentals
│   ├── linux-notes*.md          #   Permissions, root, text processing
│   ├── linux-commands.md        #   Command reference
│   └── OverTheWire/             #   Bandit levels 0–13
├── Networking/
│   ├── *.md                     #   Protocols, OSI model
│   └── Deployment_project/      #   EC2 + NGINX + HTTPS write-up
└── Git/                         # Git for professional workflows
```

---

## How I write these

Every note here is written from scratch in my own words after working through the material — never pasted from a course. If I can't explain a concept plainly, I don't understand it yet, so the writing is part of the learning rather than a record of it.

This repo grows most days. Corrections and suggestions are welcome.
