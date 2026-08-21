Objective
Create a multi-container application that consists of a simple Python Flask web application and a Redis database. The Flask application should use Redis to store and retrieve data.

Requirements
Flask Web Application:

A Flask app that has two routes:
/: Displays a welcome message.
/count: Increments and displays a visit count stored in Redis.
Redis Database:

Use Redis as a key-value store to keep track of the visit count.
Dockerize Both Services:

Create Dockerfiles for both the Flask app and Redis.
Use Docker Compose to manage the multi-container application.
Test the Application
Access the Welcome Page:

Open your browser and go to http://localhost:5000 to see the welcome message. Test the Visit Count:

Navigate to http://localhost:5000/count to see the visit count increment each time you refresh the page.

SOLUTION

I started off the project by creating a parent folder `flask_redis_app` with two child folders:

1. `flask_container`
2. `redis_container`

I chose those names as they helped me understand the process better. 

The `flask-container` folder is the Flask app, and contains two files

1. `dockerFile`
2. `app.py`

The `app.py` file is the entry point into the Flask application. It imports a python-redis client library allowing the app to communicate with a redis database (I read through redis docs to find the redis connection syntax and redis port (6379)).


1. root route ("/")
2. count route ("/count")

When a user hits the root route, a `welcome_user` function runs, displaying a simple string. 
When a user hits the /count route, `display_count` function runs, retrieves a count from the database and saves it to a variable (count). 

In case of no count (first visit), sets a value of 1 inside redis. If a count already exists, it converts the retrieved value to an integer, increments it by 1, and stores the new value back in Redis.

The Dockerfile for Flask app imports:

- python:3.10 slim as the base image, 
- sets /app as the working directory inside the container
- runs the command to install flask and redis 
- copies all the files from the current directory into the /app directory inside the container
- exposes port 5003 as the port the container listens on
- runs the command python app.py in the end

The `redis-container` folder contains the Dockerfile used to build the Redis server image.

- imports `redis:8` as the base image from Docker Hub 

Next I created a `docker-compose.yaml` file in the root directory, specifying the two services of the app 

- web and database 
- their appropriate build folders, 
- port


Docker compose manages the application defined in the YAML file. We use the command
`docker-compose up -d` to define and run both services together, with Docker Compose automatically placing them on the same network.


![root route](./images/root_route.png)

![count route](./images/image_count_route.png)

![docker compose](./images/success.png)


## Bonus Challenge

- Persistent Storage for Redis: Configure Redis to use a volume to persist its data.
- Environment Variables: Modify the Flask application to read Redis connection details from environment variables and update the docker-compose.yml accordingly.
- Scaling the Application: Scale the Flask service to run multiple instances and load balance between them using Docker Compose.

## Using Docker Volume to Persist Data

One of the key considerations when using Redis in a production environment is to ensure that the data persists even if the container is stopped ore removed.

By default, data stored in a Docker container is ephemerel, meaning once the container is destroyed, the data is destroyed with it. 

To overcome this, we use volumes which configures Redis to use a Docker volume, and that allows data to be stored on the host machine. 

- Volumes are stored on the Docker Hub, not inside the container or in your project directoru.
- the actual location is managed by Docker
- On Linux, volumes are typiclly stored under var/lib/docker/volumes/.
- For named volumes (recommended), you do not provide a host path, just the volume name and the container path.
- You specify the volume name and mount entry point inside the container
- The data inside volume is created and managed by the container at runtime.
- You do not specify initial data in the Compose file.
- The path after the colon in the volumes attribute (VOLUME:CONTAINER_PATH) is always the directory inside the container where the volume will be mounted. 
- for Redis, the official image stores its persistent data at /data inside the container.
- you do not specify the contents of the volume in the Docker Compose file.
- the volume starts empty unless you use a special initialisation process.

Added the shared volumes to the `docker-compose up -d.yaml` file.

In the Redis service (line:12), we mount the shared data volume to "/data" in the Redis container.
This ensures that all data stored by Redis in /data in the Redis container is persisted to the volume. 

The actual data will be stored in this volume, but we're mounting that in /data within the container.
That way it remembers based on the info it receives from the volume stored on our host machine. 

![docker compose file updated ](./images/updated_compose.png)

Next removed the old containers so I can restart new containers with mounted volumes. 

`docker-compose down`

![Removal of old containers](./images/remove_old_containers.png)

`docker inspect flask_redis_app-web-1`

Checked the Flask app to see if volume has been mounted correctly.

![Volume mounted](./images/volumes_mounted.png)

It confirms volume is attached and mounted at the specified path inside the container. 

![Volume confirmed inside docker desktop](./images/volume_dockerdesktop.png)

## Environment Variables

In real world environment, its not advisable to use hard coded connection details. 
Using environment variables to configure apps, adds flexbility, allowing you to easily change configurations without modifying code. 

![Using Env Var inside Flask App](./images/env_var_compose.png)

Using environment variables inside `app.py` to configure Redis database rather than hard coding connection string and port numbers.

Specified the environment variables inside `docker.compose.yaml` file as well.

![Using dodcker compose file](./images/docker_compose_env.png)


## Scaling services based on traffic

To scale the web service to multiple instances, we can use

`docker-compose up --scale web=3`

This will generate 3 instances of your Flask app.

Difference between Expose and Port
Expose directive makes the flask app port 5002 available to other services within the network
but doesnt bind it to the host's network. Basically, the container uses this port internally

Port means to connect a port on the host's machine (my machine) to a port inside this container

port:
 - 5004:5004

means that we can visit localhost:5004 and it would reach our Flask app inside the container

If you want to access the Flask app from the host's machine (your machine) while using `epxose` in `docker-compose.yaml` file, you'll need to implement a load balancer to distribute the incoming requests to the multiple instances of your flask apps. 

 We bind 


![Using dodcker compose file](./images/nginx_compose.png)

 Mounting a custom NGINX config file to configure loading balancing.


![Using dodcker compose file](./images/nginx_config.png)

Nginx is sitting in front of Flask app as a reverse proxy.

An upstream is basically; here are the application servers Nginx can send requests to.

The flask application I want you to send requests to is the Docker Compose service called web, on port 5004.

`server {}`

This starts the configuration for the Nginx web server itself.

`listen 5004` 

Nginx should listen for incoming requests on port 5004


`location / {
            proxy_pass http://flask_app;
        }
`

When someone asks for anything beginning at /, use these instructions: take the request that Nginx received and pass it to the backend I called flask_app


`  
nginx:
    image: nginx:latest
    ports:
        - "5002:5002"
    volumes:
        - ./nginx.conf:/etc/nginx/nginx.conf
    depends_on:
        - web
`

Take my local nginx.config file and place it where Nginx expects its config files inside the container (bind mount - youre mounting a file from your machine into the container)

## Problems

### I mixed up Redis Cloud with a locally running Redis server

I initially used the host, port, username and password shown on the Redis Cloud dashboard. But my actual goal was 

Flask container ----> local Redis container.

So I had to backtrack and understand that for a local Redis server, Flask just needs to connect to a `redis` host on `port=6379`. The `redis` hostname came from the Docker Compose service name. 

## Confusion between host and depends_on in the YAML file

I realised that `host=redis` tells Flask where Redis is

depends_on:
    - redis

Tells Docker Compose which service should be started before the web service.

They both referenced `redis` but do different jobs. 

## Redis connection variable had the wrong scope

One of the issues I faced was a scope problem. 

I had placed the connection to the Redis server inside the `welcome()` that runs when a request hits the root route (/). The problem was when I tried to access Redis in the `display_count()` to display visit count to the user, it was out of scope. 

I fixed this by keeping the Redis connection outside the route functions so either function can access Redis through the `r` variable.

## Redis valudes need converting before doing arithmetic

Another problem was Redis returns a string instead of a number so when I tried to increment the result from Redis, it gave an error. I had to first convert the result from Redis into an integer and then increase it. 

