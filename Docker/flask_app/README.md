# Flask app in Docker — everything that went wrong

My first attempt at putting an app inside a container. The app itself is nine lines of Flask that returns one line of text. Almost none of my time went on the app — it all went on the six things below.

Writing them down because every one of them taught me something, and I'd have solved them faster if I'd understood what the error was actually telling me.

---

## The app

```python
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hey Rajea, this is live from the Flask app!'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)
```

---

## Problem 1 — Python couldn't find Flask

```
python3 app.py

ModuleNotFoundError: No module named 'flask'
```

**What it means in plain English:** line 1 of my file says "go get Flask." Python looked in the place it keeps installed packages, didn't find Flask there, and stopped before running any of my code.

Writing `from flask import Flask` does not install Flask. It only asks for something that has to already be on the machine. Flask isn't part of Python — it's a library someone else wrote, and it has to be installed separately.

---

## Problem 2 — installing it meant learning what a venv is

I'd never used Python properly before, so "create a virtual environment" meant nothing to me.

**The way it finally clicked:** I've built a Next.js site, so I already knew this idea with different words.

In JavaScript, `npm install` puts packages in a **`node_modules`** folder inside the project. Every project gets its own. My portfolio's packages never mix with another project's.

Python doesn't do that by default. It throws every package into one shared pile for the whole computer, so two projects that need different versions of the same thing end up fighting.

**A virtual environment is me asking Python for a `node_modules`-style folder for this project.** It's literally a folder named `venv` holding this project's packages and nothing else's.

"venv" is just short for *virtual environment*. The name made it sound harder than it is.

```bash
python3 -m venv venv        # make the folder — once, ever
source venv/bin/activate    # tell the terminal to use it — every new terminal
pip install flask           # install into that folder — once
```

`pip` is Python's `npm`. When it's active, `(venv)` appears at the front of the terminal prompt — that's how you know.

---

## Problem 3 — port 5000 was already taken (macOS)

I originally wrote `port=5000`, which is the Flask default. It wouldn't work.

```bash
lsof -nP -iTCP:5000 -sTCP:LISTEN

COMMAND     PID       USER   ...  NAME
ControlCe   650  rajeabilal   ...  TCP *:5000 (LISTEN)
```

`ControlCe` is **macOS Control Centre** — the AirPlay Receiver feature sits on port 5000 permanently.

**In plain English:** a port is like a door number on my computer. Only one program can stand behind a given door. macOS had already claimed door 5000, so Flask couldn't have it.

This is a Mac-only trap and it catches everyone, because 5000 is the number in every Flask tutorial.

---

## Problem 4 — port 6000 was blocked by the browser

So I switched to 6000. The terminal said the server had started:

```
* Running on http://127.0.0.1:6000
```

But the browser refused to load it — `ERR_UNSAFE_PORT`.

**What was actually happening:** the server was fine. I confirmed it was answering with `curl`, which returned my text correctly. The problem was that **Chrome and Firefox keep a list of ports they refuse to connect to**, and 6000 is on it (it's traditionally used by X11). The browser wouldn't even try.

So two different problems in a row, with the same symptom of "can't see my app":

| Port | Why it failed |
| --- | --- |
| 5000 | macOS AirPlay is already using it |
| 6000 | Browsers block it outright |
| **5001** | **Works** |

**Lesson:** "I can't see it in the browser" and "the server isn't running" are two different problems. `curl` tells you which one you have — if `curl` gets a response, your app is fine and the problem is the browser.

---

## Problem 5 — `docker build` missing the dot

```bash
docker build -t flask_app

ERROR: docker: 'docker buildx build' requires 1 argument
```

**In plain English:** I told Docker what to *name* the image (`-t flask_app`) but never told it *where the files were*.

```bash
docker build -t flask_app .
```

That trailing `.` means "this folder, the one I'm standing in." Docker needs both pieces every time: a name, and a location. I'd given it one.

---

## Problem 6 — a missing space in the Dockerfile

```dockerfile
CMD["python", "app.py"]     # ❌ not a valid instruction
CMD ["python", "app.py"]    # ✅
```

Docker reads the first word of each line as the instruction. Without the space it can't see `CMD` as a word on its own, so the line means nothing to it.

---

## Problem 7 — the venv was about to be copied into the image

My Dockerfile had `COPY . .`, which means "copy everything in this folder into the image." Everything included my `venv` folder.

**Why that's bad:** the `venv` folder holds programs built for **macOS**. The container runs **Linux**. Those files are useless inside it, and they make the image far bigger for no reason.

Fixed with a `.dockerignore` — same idea as `.gitignore`, a list of things Docker should skip:

```
venv/
__pycache__/
*.pyc
.DS_Store
```

---

## The thing that confused me most

I spent a while thinking the venv and the container were the same idea, or that I'd wasted my time making one.

They're separate, and they're both needed for different reasons:

- **The venv is for running the app on my Mac.** It's how my Mac gets Flask.
- **The container installs its own Flask**, via `RUN pip install flask` in the Dockerfile. It never looks at my venv. That's the whole point — the image carries its own dependencies so it runs the same anywhere.

So the venv isn't wasted, it's just for local development. If I only ever ran this in Docker, I wouldn't need one at all.

Which is also the clearest explanation of what Docker is *for* that I've come across so far: **"works on my machine" really means "my machine happens to have the right things installed."** A container ships the app and everything it depends on together, so there's no happening-to-have-it involved.

---

## The Dockerfile, line by line

```dockerfile
FROM python:3.10-slim      # start from a small Linux image with Python already on it
WORKDIR /app               # work inside a folder called /app inside the container
COPY . .                   # copy my files in (minus whatever .dockerignore skips)
RUN pip install flask      # install Flask INSIDE the image, at build time
EXPOSE 5001                # note which port the app uses
CMD ["python", "app.py"]   # the command to run when the container starts
```

One thing I got right by accident: `host='0.0.0.0'` in `app.py`. Inside a container, the default `127.0.0.1` would mean "only accept connections from inside this container" — so the app would start fine and still be unreachable from my browser. `0.0.0.0` accepts from outside too.

Given how much time I lost to ports already, that one would have hurt.

---

## Commands worth remembering

```bash
# venv
python3 -m venv venv
source venv/bin/activate
pip install flask

# what's using a port?
lsof -nP -iTCP:5001 -sTCP:LISTEN

# is the server actually responding, browser aside?
curl http://127.0.0.1:5001/

# docker
docker build -t flask_app .
docker run -p 5001:5001 flask_app
```

On that last one — `-p 5001:5001` maps a port on my Mac to a port inside the container. Without it the app runs but nothing on my machine can reach it. Left side is my Mac, right side is the container.
