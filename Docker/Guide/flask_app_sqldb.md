# Connecting a Flask App to MySQL with Docker

Two containers, one network. The Flask app handles the requests, MySQL holds the data, and they find each other by name.

```
   Browser
      ↓  localhost:5001
┌─────────────────────────────────┐
│      my-custom-network          │
│                                 │
│  flask-container  →  mysql-server
└─────────────────────────────────┘
```

---

## 1. The app code

When a request hits the root route, `hello_world()` runs. It connects to the MySQL server, sends one query asking which version it is, and returns the answer to the browser.

```python
from flask import Flask
import MySQLdb

app = Flask(__name__)

@app.route('/')
def hello_world():
    conn = MySQLdb.connect(
        host="mysql-server",     # hostname of the MySQL container
        user="root",             # credentials for the MySQL server
        passwd="mysecret-pw",
        db="mysql"               # database inside the MySQL server
    )
    cursor = conn.cursor()
    cursor.execute("SELECT VERSION()")
    version = cursor.fetchone()

    return f'Hey Rajea, live from the Flask app! MYSQL server version: {version[0]}'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)
```

**Why `host="mysql-server"`** — this tripped me up at first. The Flask app runs inside its own container, so `localhost` in there means *itself*, not MySQL. It has to reach across to a separate container.

On a custom network, a container's **name is its hostname**. Docker resolves `mysql-server` to that container automatically. That's the whole point of the custom network — otherwise I'd be hardcoding an IP address that changes every restart.

**Why `db="mysql"`** — `mysql` is a database that MySQL creates for itself on first boot, so it's already there and I didn't have to make one. `host` is which server to connect to; `db` is which database inside it.

---

## 2. Updating the Dockerfile

Adding `mysqlclient` broke the build.

`mysqlclient` isn't ready-to-run Python code. It has to be assembled on the spot when it installs, and assembling it needs tools. My base image is `python:3.10-slim`, and *slim* means stripped down — those tools aren't included. So the install had nothing to work with and failed.

The fix is one line that installs the missing tools before `pip install`:

```dockerfile
FROM python:3.10-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
          pkg-config \
          gcc \
          default-libmysqlclient-dev \
      && rm -rf /var/lib/apt/lists/*

COPY . .

RUN pip install flask mysqlclient

EXPOSE 5001

CMD ["python", "app.py"]
```

After that the build went through.

---

## 3. Creating the custom network

```bash
docker network create my-custom-network
```

[!Creating the custom Docker network](images/docker_custom_network.png)

Both containers go on this network so they can reach each other by name instead of by IP address.

---

## 4. Running the MySQL container

MySQL already has an official image on Docker Hub, so I could skip the whole write a Dockerfile → build an image → run it cycle and go straight to running it.

```bash
docker run -d \
  --name mysql-server \
  --network my-custom-network \
  -e MYSQL_ROOT_PASSWORD=mysecret-pw \
  mysql:8
```

- `-d` — detached, runs in the background
- `--name mysql-server` — has to match the `host` value in `app.py`
- `--network my-custom-network` — joins the network Flask will be on
- `-e MYSQL_ROOT_PASSWORD` — sets an environment variable inside the container, which MySQL reads on first boot to set the root password
- `mysql:8` — the image to run

![Running the MySQL container on the custom network](images/creating_mysql_container_on_custom_network.png)

No `-p` flag here. MySQL doesn't need to be reachable from my Mac — only from the Flask container, which is already on the same network.

![MySQL server running in Docker](images/sql_server_running_docker.png)

---

## 5. Building and running the Flask container

```bash
docker build -t flask-app-mysql .
```

Builds an image from the Dockerfile in this folder and names it `flask-app-mysql`.

```bash
docker run -d \
  --name flask-container \
  --network my-custom-network \
  -p 5001:5001 \
  flask-app-mysql
```

- `-d` — detached
- `--name flask-container` — a name I can refer back to
- `--network my-custom-network` — same network as MySQL, so `host="mysql-server"` works
- `-p 5001:5001` — maps port 5001 on my Mac to 5001 inside the container, so `localhost:5001` reaches the app
- `flask-app-mysql` — the image just built

![Running the Flask container on the custom network](images/flask_container_custom_network.png)

Because it's detached, nothing prints to the terminal. To see what the app is doing — or the error if it fell over:

```bash
docker logs flask-container
```

---

## 6. The result

![The Flask app returning the MySQL server version in the browser](images/result_in_browser.png)

The Flask container found the MySQL container by name, logged in, asked for the version, and sent it back to the browser. Yippee!

---

## Recall

| Command | What it does |
|---|---|
| `docker network create <name>` | Create a custom network so containers can find each other by name |
| `docker run -d --name X --network Y` | Start a container, named, on that network |
| `-e VAR=value` | Set an environment variable inside the container |
| `-p 5001:5001` | Map a port on my Mac to a port in the container |
| `docker build -t <name> .` | Build an image from the Dockerfile here |
| `docker logs <container>` | See the output of a detached container |

**The two things that have to match:**

```
--name mysql-server        →  host="mysql-server"   in app.py
-e MYSQL_ROOT_PASSWORD=... →  passwd="..."          in app.py
```

Get either wrong and the connection fails.

**Slim images leave things out.** If a Python package needs building rather than just copying in, a slim base image won't have what it needs — install the tools first.

**Only publish the ports you need.** MySQL had no `-p` and Flask still reached it, because containers on the same network talk to each other directly.



Learnt about Docker compose, its a faster, more efficient way of setting a consistent environment for your app.
You no longer have to start/stop containers manually.

You can specify all the different services of your app (e.g web, database, cache, etc.) in a single YAML file and run this file using the following script


Docker compose runs each service as a separate container, creating a network for all the containers it manages. They can communicate with each other seamlessly.

/insert image from /images folder

When I tried to reach the app on localhost:5001, it was showing an error, despite the containers working. 

![Docker compose showing the two containers running](images/docker-compose-running.png)

A little bit of digging revealed that docker-compose had in fact, built the container from an older version of the YAML file. I had since made changes to the YAML file and the current containers didn't reflect those changes to code. 

I needed Docker compose to recreate the containers using the new changes to the YAML file.

First step was to remove the old container (flask_app-web-1) with the following command

```bash
docker compose down
```

Once web app was removed, ran the ```docker compose up --build``` command again to rebuild the containers

Checked the containers currently existing using the command

```bash
docker compose ps
```


![Docker compose finally working](images/docker-compose-finally.png)

The browser is visible, means flask app is able to connect with MySQL database and display the MySQL version

![Docker compose results in browser](images/result-in-browser.png)



Important command to inspect logs and find errors
docker compose logs -f web