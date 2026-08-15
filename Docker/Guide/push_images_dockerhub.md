# Docker Hub

Docker Hub is a platform that where you can store, share and access Docker images.

You can pre-built images or share your own.

Develops can pull these images to their machines and they can act as a great starting point to their projects.
Not every image has to be built from scratch via a DockerFile. 

We can also learn to create our own images and push them to a private Docker Registry. 

# Process

Create an account on Docker Hub

Head over to command-line in your VS code and run the following command

```bash
docker login
```

[!docker login](images/docker-login.png)

Enter Docker Hub details to authenticate your account.

Now you're ready to push and pull images directly from the terminal.

Inside Docker Hub, we need to create a repository where we will push and pull our images from.

First we need to build and tag our image correctly so it can be pushed to Docker Hub.

```bash
docker build -t rajea/flask-mysql-repo:v1 .
```

Instructing Docker to build an image from the Dockerfile located in the current directory, tag it with your Docker Hub username/name-of-repo:v1 

Once image is created, run the following command to push image to Docker Hub 

```bash
docker push rajea/flask-mysql-repo:v1
```

Its now being pushed to Docker Hub

[!docker image pushed](images/docker-image-pushed.png)

Once its been pushed, head over to Docker Hub and you'll see the image sititng inside your specified repo

We can also pull the image to another machine or your own machine

Docker Pull

```bash
docker pull rajea/flask-mysql-repo:v1 
```

[!docker image pulled](images/docker-pull.png)