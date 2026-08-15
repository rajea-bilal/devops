Create a free account on AWS

Sign in to console

AWS managemnet console -->

ECR
This is where you ca deploy and share container software

Create a repository and make it private

flask-mysql-aws

Click on repo

View push commands button provides list of commands

Authenticate by copying the token in your terminal

interacting with aws cli with the ecr service

Press Enter

Login to your private registry on AWS

Build the image first

docker build -t flask-mysql-image .

Tag our docker images before being pushing them to AWS

We tag them with ECR repo url

docker tag image:latest aws ecr url/image-name:latest

Once the image is built, we copy the command to push the image

docker push aws-ecr-url/image-name:latest

[!docker image successfully pushed to AWS private registry](/images/aws-image-pushed.png)

Our image should appear in the AWS ECR page

Next we can also pull this image from AWS ECR repo

docker pull aws-ecr-url/image-name:latest

[!docker image successfully pulled from AWS private registry](/images/aws-image-pull.png)

This image is not ready to be run as a container

docker run -p 5001:5001 aws-ecr-url/image-name:latest

First create a mydb MySQL database by pulling the image from the Docker registry and running it as a container (since we already have the image) and pass in the credentials

docker run -d --name mysql-server -e MYSQL_ROOT_PASSWORD=mysecret-pw mysql:8

We run Flask-MySQL app based off the image we just pulled from AWS 

docker run -p aws-ecr-url/image-name:latest 

We get an error because the containers are on different networks

docker netowkr create my-app-network

docker run -d --name mysql-server --network my-app-network-for-aws-images -e MYSQL_ROOT_PASSWORD=my-secret-pw mysql:8

Then run our image from AWS on the same custom network we just created

docker run -p --network my-app-network aws-ecr-url/image-name:latest

[!image pulled from AWS added on custom network](/images/aws-pulled-image-on-network.png)

[!image from browser with AWS pulled image](/images/aws-browser-result.png)

## AWS Docker Compose

Simplify the process of managing and networking containers by listing all the different services of the app inside a single YAML file

We can deploy an app using Docker with an image pulled from AWS


Instead of performing all the following actions manually
- creating a custom network, 
- running flask-sql-aws image on the custom network as a container
- running mysql image pulled from Docker hub on the same custom network
- starting/stopping containers 

We could update the Docker compose YAML file as follows (add the aws authentication token) and run the compose command

```bash
docker-compose up
```

and acheive the same results, mcuch faster;

- consistent app environment across different machines, in development and production
- easy to deploy, easy to test


[!using docker compose with aws](/images/aws-docker-compose.png)

## Making images lighter through multi-stage build

A multi-stage build uses multiple FROM statements in one Dockerfile.

Each FROM starts a separate stage.

Stage 1 → Build application
Stage 2 → Create smaller final image

[!multi stage image 01](/images/multi-stage-02.png)

[!multi stage image 02](/images/multi-stage-02.png)