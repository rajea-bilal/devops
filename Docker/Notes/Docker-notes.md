## What is Docker?
Docker is an open platform for developing, shipping, running and managing applications using containers.

## What is containerisation?
Containerisation is the process of packaging an application together with everything it needs to run inside a container.

## What is a container?
A container is a lightweight, portable unit that runs an application together with its required dependencies, libraries, binaries and runtime.

## What is a Docker image?
A Docker image is a template used to create containers.

It is a snapshot of an application at a particular point in time.

## What is a Dockerfile?
A Dockerfile is a file containing a series of instructions that Docker uses to build a Docker image.

## What is the Docker Engine?
The Docker Engine is the core service that makes containerisation possible.

It is responsible for building, running and managing containers.

## What is Docker Hub?
Docker Hub is a repository where Docker images can be found and shared.

You can use it to:

- pull official images
- pull community images
- share your own images

## What is Docker Compose?
Docker Compose is a tool for defining and running applications that use multiple containers.

For example:

Web Server
+
Database
+
Cache

These can run in separate containers but form one overall application.



# Docker Recall — Modern Development & VMs vs Containers

## Why is Docker important in modern development?

Docker helps teams by:

* creating consistent environments from development to production
* using fewer resources than traditional VMs
* making environments easier to share between developers
* integrating well with CI/CD pipelines

This makes development, testing and deployment faster and more predictable.

---

## How does Docker solve the "it works on my machine" problem?

Docker packages the application with its dependencies into a consistent environment.

That same environment can then be used across:

```text
Development → Testing → Production
```

This reduces problems caused by different dependencies or configurations on different machines.

---

## Why are Docker containers efficient?

Containers **share the host operating system kernel** instead of each running their own full operating system.

Because of this, they:

* use fewer resources
* start quickly
* are easier to scale

---

## How does Docker improve collaboration?

Teams can share the same Docker image.

This means developers work with the same:

* application
* dependencies
* environment

It also makes onboarding new developers easier because they do not need to manually recreate the environment.

---

## How does Docker fit into CI/CD?

Docker works well with CI/CD pipelines to automate:

```text
Testing → Building → Deployment
```

This helps applications move more consistently from development to production.

---

# Virtual Machines vs Containers

## What is a Virtual Machine?

A **Virtual Machine (VM)** runs a complete guest operating system on top of a **hypervisor**.

Each VM has its own:

* guest OS
* application
* binaries
* libraries

---

## What is a hypervisor?

A **hypervisor** creates and manages virtual machines.

It allocates resources such as:

* CPU
* memory
* storage

to each VM.

---

## What is the main difference between a VM and a container?

A VM runs its own **guest operating system**.

A container does not. Containers share the **host OS kernel** and isolate applications at the process level.

```text
VM
Application + Dependencies + Guest OS

Container
Application + Dependencies
Shares Host OS Kernel
```

---

## Why are containers lighter than VMs?

Because containers do not need a complete guest operating system for every application.

They share the host OS kernel, so they require less:

* CPU
* memory
* storage

and start faster.

---

## What does process-level isolation mean?

Applications run in separate container environments, so they do not interfere with each other.

However, the containers still share the underlying host OS kernel.

---

## Which provides stronger isolation: VMs or containers?

**VMs provide stronger isolation** because each VM has its own complete operating system.

Containers provide **process-level isolation**, which is lighter but not as strong as VM isolation.

---

## Why do VMs start slower than containers?

VMs need to boot a complete guest operating system.

Containers share the existing host OS kernel, so they can start much faster.

---

## Which is more portable?

**Containers are generally more portable.**

They are smaller and can run consistently across different environments using Docker images.

VMs are larger because they include a complete operating system and may depend on specific hypervisors.

---

## When would you choose a VM?

Choose a VM when you need:

* stronger isolation
* a full separate operating system
* different operating systems on the same host

---

## When would you choose containers?

Choose containers when you need:

* lightweight environments
* fast startup
* efficient resource usage
* portability
* easy scaling

---

# Interview: Containers vs Virtual Machines

**Virtual machines run a full guest operating system on top of a hypervisor, whereas containers share the host OS kernel and isolate applications at the process level.**

Because containers do not need their own guest OS, they are lighter, use fewer resources and start faster. VMs use more resources but provide stronger isolation.

```text
VM
→ Guest OS
→ More resources
→ Slower startup
→ Stronger isolation

Container
→ Shares host OS kernel
→ Fewer resources
→ Faster startup
→ Process-level isolation
```

Dockerfile — Quick Recall

What is a Dockerfile?

A Dockerfile is a file containing step-by-step instructions Docker uses to build a Docker image.

Each instruction creates a layer in the image, which helps Docker track changes and optimise builds.

Why are Dockerfiles useful?

Dockerfiles make builds repeatable and consistent.

The same Dockerfile can be used to recreate the same application environment instead of manually setting everything up each time.

What is the Dockerfile flow?

Dockerfile
   ↓
docker build
   ↓
Docker Image
   ↓
Run Image
   ↓
Container
   ↓
Running Application

What does FROM do?

FROM node:14

FROM specifies the base image your image will be built on.

Examples:

Node application   → Node base image
Python application → Python base image

The base image provides the foundation your application needs.

What does WORKDIR do?

WORKDIR /app

WORKDIR sets the working directory inside the container/image.

Instructions that follow, such as COPY and RUN, operate from that directory.

What does COPY do?

COPY package*.json ./

COPY copies files from your host machine/project into the Docker image.

For example, you can first copy:

package.json
package-lock.json

so Docker can install the application's dependencies.

Later:

COPY . .

copies the rest of the application code.

What does RUN do?

RUN npm install

RUN executes a command while the Docker image is being built.

Here, npm install reads the package.json and installs the Node.js dependencies into the image.

What does EXPOSE do?

EXPOSE 3000

EXPOSE tells Docker that the container is expected to listen on that network port at runtime.

In this example:

Container → Port 3000

What does CMD do?

CMD ["node", "index.js"]

CMD specifies the command that should run when the container starts.

Here, the container starts the Node.js application with:

node index.js

What is the key difference between RUN and CMD?

RUN
→ runs while BUILDING the image

CMD
→ runs when STARTING the container

Example:

RUN npm install

installs dependencies into the image.

CMD ["node", "index.js"]

starts the application when the container runs.

What is the basic order in this Dockerfile?

FROM node:14
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["node", "index.js"]

What is happening:

Choose base image
      ↓
Set working directory
      ↓
Copy dependency files
      ↓
Install dependencies
      ↓
Copy application code
      ↓
Declare application port
      ↓
Start application when container runs

30-Second Recall

FROM    → base image
WORKDIR → working directory
COPY    → copy files into image
RUN     → run command while building image
EXPOSE  → specify expected runtime port
CMD     → command to run when container starts

Dockerfile → docker build → Image → Container → Application

Docker Networking — Quick Recall
Why is Docker networking important?

Docker networking allows containers to communicate with each other, share data, and work together as one system.

This is especially important in DevOps and microservices, where different parts of an application may run in separate containers.

Can containers communicate across different machines?

Yes.

Docker networking can allow containers to communicate:

on the same machine
across multiple machines
What are the main Docker network types introduced?
Bridge
Host
None
What is a bridge network?

A bridge network is the default network mode for containers on the same machine.

Containers on the bridge network can communicate with each other using their own IP addresses.

It is isolated from the host machine's network.

Container A ↔ Container B
        ↓
   Bridge Network
What is a host network?

With the host network, the container uses the host machine's network directly.

There is no network isolation between the container and the host.

This can be useful when an application needs to interact closely with the host system.

What is a none network?

The none network gives the container no network access.

The container is completely isolated from networking.

This can be useful when a container should not communicate with anything over a network.

Why is Docker networking important for microservices?

In a microservices architecture, different parts of an application run as separate services, often in separate containers.

Docker networking allows those services to communicate with each other.

Frontend Container
       ↕
Backend Container
       ↕
Database Container
What Docker networking commands were introduced?
docker network ls
docker network create
docker network connect
docker network ls → list Docker networks
docker network create → create a network
docker network connect → connect a container to a network
30-Second Recall
Bridge → containers communicate on the same machine; isolated from host network

Host   → container uses the host network directly

None   → container has no network access
Docker networking
→ connects containers
→ enables microservices communication
→ supports scalable containerised applications


What is Docker Compose?

Docker Compose is a tool used to define and manage multiple Docker containers together.

Why do we need Docker Compose?

Without Docker Compose, you have to start and manage containers one by one.

With Docker Compose, you define the whole application setup in one file and manage everything together.

What is the Docker Compose YAML file?

It is a file that defines the services your application needs.

It can include:

which images to use
which ports to expose
which containers/services are needed
how they interact
What does docker-compose up do?
docker-compose up

It starts all the services defined in the Docker Compose YAML file.

How does Docker Compose help with networking?

Docker Compose automatically creates a network for the containers it manages.

This means the containers can communicate without you manually creating a custom network.

Why is Docker Compose useful for development and testing?

It lets you start the full application environment quickly with one command.

For example:

Web server
+ Database
+ Cache

can all be started together.

How does Docker Compose improve consistency?

Everyone can use the same Docker Compose YAML file.

This means developers, testers, and CI/CD pipelines can use the same environment setup.

This reduces the "it works on my machine" problem.

How does Docker Compose improve teamwork?

The Compose file can be stored in the same repository as the application code.

A new developer can:

Clone repository
→ Run docker-compose up
→ Start the full development environment

This makes setup faster and reduces configuration mistakes.

30-Second Recall
Docker Compose
→ manages multiple containers together

docker-compose.yml
→ defines the services and setup

docker-compose up
→ starts all services

Networking
→ created automatically by Docker Compose
Main benefits
Easier development/testing
+ Consistent environments
+ Better teamwork

Docker Hub & Registries — Quick Recall
What is Docker Hub?

Docker Hub is a Docker registry used to store, share, push and pull Docker images.

Why is Docker Hub useful?

It lets you:

use official pre-built images
share your own images
collaborate with others
store images in repositories

Examples of official images include:

Python
Node.js
MySQL
Postgres
MongoDB
What is a Docker registry?

A Docker registry is a place where Docker images are stored so they can be uploaded, downloaded and shared.

Local machine
   ↕
Docker Registry
   ↕
Other machines
What does docker login do?
docker login

Authenticates your terminal with Docker Hub so you can push and pull images using your account.

How do you build and tag an image for Docker Hub?
docker build -t username/repository:v1 .

Example structure:

username/repository:v1
username → your Docker Hub username
repository → repository where the image will be stored
v1 → image tag/version
. → use the current directory as the build context
What is an image tag?

A tag identifies a particular version of an image.

Examples:

v1
v2
latest
How do you upload an image to Docker Hub?
docker push username/repository:v1

docker push uploads your local Docker image to the Docker Hub repository.

How do you download an image from Docker Hub?
docker pull username/repository:v1

docker pull downloads the image to your local machine.

You can then use that image to create a container.

What is the overall flow?
Dockerfile
   ↓
docker build
   ↓
Local Docker Image
   ↓
docker push
   ↓
Docker Hub
   ↓
docker pull
   ↓
Another machine
   ↓
Run image as container
What is AWS ECR?

AWS ECR is another Docker registry, introduced here as a private registry commonly used in production environments.

30-Second Recall
Docker Hub
→ stores and shares Docker images

docker login
→ authenticate with Docker Hub

docker build -t
→ build and tag image

docker push
→ upload image to registry

docker pull
→ download image from registry

Tag
→ identifies image version

AWS ECR
→ private Docker registry used in production

Essential Docker Commands — Quick Recall
How do you list Docker images on your machine?
docker images

Shows locally stored images, including:

repository/name
tag/version
image ID
creation date
size
How do you inspect an image?
docker inspect <image-id>

Shows detailed information about an image, such as:

configuration
environment variables
layers
How do you remove a Docker image?
docker rmi <image-id>

Removes an image you no longer need.

If a container is still using that image, Docker may stop you from deleting it until the container is stopped and removed.

How do you clean up unused Docker resources?
docker system prune

Removes unused Docker resources such as:

stopped containers
unused networks
dangling images
dangling build cache

Use this carefully because it deletes resources Docker considers unused.

How do you see running containers?
docker ps

Shows the containers that are currently running.

How do you stop a container?
docker stop <container-id>

You can also stop multiple containers:

docker stop <container-id-1> <container-id-2>

Stopping a container does not delete it. It still exists in a stopped state.

How do you completely remove a container?
docker rm <container-id>

Removes a stopped container from your system.

Key Difference: Stop vs Remove
docker stop
→ stops the container
→ container still exists

docker rm
→ removes the container completely
30-Second Recall
docker images
→ list local images

docker inspect
→ view detailed image information

docker rmi
→ remove an image

docker system prune
→ clean up unused Docker resources

docker ps
→ list running containers

docker stop
→ stop a container

docker rm
→ remove a container


What is a multi-stage build?

A multi-stage build uses multiple FROM statements in one Dockerfile.

Each FROM starts a separate stage.

Stage 1 → Build application
Stage 2 → Create smaller final image
Why use multi-stage builds?

Some packages and tools are needed only to build the application, not to actually run it.

Without a multi-stage build, those build tools can remain in the final image and make it unnecessarily large.

How does a multi-stage build work?

Stage 1 — Build stage

Contains everything needed to build/install the application, including build tools and dependencies.

FROM python:3.8-slim AS build
WORKDIR /app
...

Stage 2 — Production/runtime stage

Starts from a clean image and copies only what is needed from the build stage.

FROM python:3.8-slim
WORKDIR /app

COPY --from=build /app /app

EXPOSE 5002
CMD ["python", "app.py"]

The unnecessary build tools are therefore left behind.

What does AS build mean?
FROM python:3.8-slim AS build

It gives that Dockerfile stage the name build.

You can then copy files from it later:

COPY --from=build /app /app
Why does this make the image smaller?

The first stage may contain tools such as:

GCC
Python development tools
MariaDB/MySQL build dependencies

These may be needed to build/install dependencies but aren't needed when the application is running.

The final stage only keeps what is required at runtime.

What was the result in the example?
Original image    → 471 MB
Multi-stage image → 151 MB

The application still runs, but the unnecessary build tools are removed from the final image.

Why are smaller Docker images better?

Smaller images:

take less disk space
use less bandwidth
are faster to pull from a registry
are faster to deploy
How do you check an image's size?
docker images

This lets you compare the original and optimised images.

Interview: What is a multi-stage Docker build?

A multi-stage build uses multiple FROM stages in a Dockerfile.

One stage contains the tools needed to build the application, while the final stage contains only what is needed to run it.

This produces a smaller, more efficient production image.

30-Second Recall
Multi-stage build
→ multiple FROM statements

Build stage
→ contains build tools + dependencies

Production stage
→ copies only what is needed to run the app

Result
→ smaller Docker image
→ faster pulls/deployments
→ less storage

28 — Advanced Container Orchestration

Why does managing containers become harder at scale?
Managing containers manually becomes difficult when an application has hundreds or thousands of containers, especially in production.

Why might Docker Compose not be enough for very large applications?
Docker Compose helps manage multiple containers, but managing hundreds or thousands of containers still becomes complex.

What is container orchestration?
Container orchestration is the automated management, deployment, scaling, and operation of large numbers of containers.

What tools are used for container orchestration?
Kubernetes and Docker Swarm are container orchestration tools.

Why are orchestration tools important in production?
They automate container management and make it easier to scale and manage large, complex containerized applications.

30-Second Recall
A few containers → manual Docker management may be enough.
Many containers → management becomes difficult.
Container orchestration automates deployment, scaling, and management.
Kubernetes and Docker Swarm are orchestration tools.
29 — Kubernetes Introduction

What is Kubernetes?
Kubernetes, or K8s, is an open-source platform that automates the deployment, scaling, and operation of containerized applications.

What problem does Kubernetes solve?
It helps manage hundreds or thousands of containers running across multiple machines, where manual container management would become slow and error-prone.

What does Kubernetes automate?
Kubernetes can automate container deployment, scaling, and recovery from failures.

How does Kubernetes handle changing demand?
It can scale applications up or down depending on demand.

Why is Kubernetes useful for distributed systems?
It manages containers across multiple machines and reduces the need to manually manage each individual container.

What does it mean that Kubernetes abstracts the underlying infrastructure?
Kubernetes handles much of the complexity of managing the machines and containers underneath, allowing developers to focus more on the application.

Why is Kubernetes important for DevOps engineers?
Modern production systems often use large-scale containerized and cloud-native applications, so DevOps engineers need tools like Kubernetes to deploy, manage, and scale them.

30-Second Recall

Kubernetes manages large numbers of containers across multiple machines. It automates deployment, scaling, and recovery from failures, reducing the amount of manual container management required.

Interview

What is Kubernetes and why is it used?
Kubernetes is an open-source container orchestration platform used to automate the deployment, scaling, and management of containerized applications. It becomes especially useful when applications have many containers running across multiple machines, because managing them manually would be complex and error-prone.

30 — Docker Swarm vs Kubernetes

What is Docker Swarm?
Docker Swarm is Docker's built-in clustering and container orchestration tool.

Why is Docker Swarm easier to start with?
It is built into Docker and works closely with existing Docker commands and environments, so setup is relatively simple.

When is Docker Swarm a good choice?
It is suited to smaller or less complex deployments where simplicity is more important than advanced orchestration features.

What is Kubernetes?
Kubernetes is a more powerful and feature-rich container orchestration platform designed for managing containers at large scale.

What is a major scaling difference between Docker Swarm and Kubernetes?
Docker Swarm does not have built-in auto-scaling, while Kubernetes can automatically scale applications up or down based on demand.

How do their communities compare?
Kubernetes has a much larger and more active community, providing more support, resources, and continued development.

Which is easier to set up?
Docker Swarm is generally easier to set up. Kubernetes has a steeper learning curve and requires more understanding of its components.

Why can Kubernetes manage a wider range of environments?
Kubernetes is not limited to the Docker API, so it can work with a wider range of container runtimes and provide more advanced container-management features.

When would you choose Kubernetes over Docker Swarm?
Choose Kubernetes when you need greater scalability, flexibility, auto-scaling, or need to manage a large and complex distributed application.

30-Second Recall

Docker Swarm: simpler, built into Docker, easier setup, suited to smaller deployments, no built-in auto-scaling.

Kubernetes: harder to learn, but more powerful, scalable, flexible, has auto-scaling, and is better suited to large production environments.

Interview

Docker Swarm vs Kubernetes — what is the main difference?
Both are container orchestration tools. Docker Swarm is simpler and integrates directly with Docker, making it suitable for smaller deployments. Kubernetes is more complex but provides greater scalability, flexibility, built-in auto-scaling, and more advanced features, making it better suited to large production environments.

31 — Why Use Orchestration Tools?

Why are orchestration tools needed as applications grow?
Managing large numbers of containers manually becomes difficult. Orchestration tools automate container deployment, operation, and scaling across multiple machines.

What do orchestration tools manage?
They manage large numbers of containers running across multiple machines and environments.

How do orchestration tools improve high availability?
They monitor containers and can restart or relocate them when failures occur, helping keep the application available.

What is self-healing in container orchestration?
Self-healing means the orchestration tool detects failed containers and automatically restarts or replaces them without manual intervention.

How do orchestration tools help with scaling?
They can scale applications up when demand increases and scale them down when demand decreases.

Why is automatic scaling useful?
Scaling up helps maintain performance during busy periods, while scaling down avoids wasting resources during quieter periods.

How do orchestration tools improve resource utilization?
They help use infrastructure more efficiently by automatically adjusting resources and container workloads based on what the application needs.

What is the overall benefit of container orchestration?
It reduces manual infrastructure work while improving scalability, reliability, availability, and management of complex deployments.

30-Second Recall

Orchestration tools such as Kubernetes and Docker Swarm manage containers across multiple machines.

They provide:

automated deployment and management
scaling
high availability
self-healing
better resource utilization

The goal is to keep large containerized applications reliable and scalable without constant manual management.

Interview

Why do we use container orchestration tools?
Container orchestration tools automate the deployment, scaling, and management of containers across multiple machines. They also provide features such as high availability and self-healing, where failed containers can be detected and restarted or relocated automatically. This makes large-scale containerized applications more reliable and easier to manage.