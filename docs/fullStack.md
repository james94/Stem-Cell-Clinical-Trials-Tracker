# FullStack: Deploy MyTrial App Across React, SpringBoot & MySQL Docker Containers

Let's go through the steps to manually deploy each Docker Container in our MyTrials-Tracker Full Stack Web Application by using docker run commands in each linked section.

## BackEnd: MySQL Server Docker Container

The 1st BackEnd part of the application `mytrial` is written in mysql.

We will use an existing mysql db service docker image from dockerhub.

Let's go deploy the MySQL Server Docker Container: [BackEnd: Deploy MySQL and SpringBoot Containers for MyTrials App](./backEnd.md)

## BackEnd: SpringBoot Server Docker Container

The 2nd BackEnd part of the application `mytrial-sb-server` is written in Java SpringBoot.

Check out the **mytrial-api** [Dockerfile](../myTrial-api/Dockerfile) for reference.

Let's go deploy the SpringBoot Server Docker Container: [BackEnd: Deploy MySQL and SpringBoot Containers for MyTrials App](./backEnd.md)

## FrontEnd: ReactJS Client Docker Container

The FrontEnd part of the application `mytrial-client` is written in ReactJS.

Check out the **mytrial-fe** [Dockerfile](../mytrial-fe/Dockerfile) for reference.

Let's go deploy the ReactJS Client Docker Container: [FrontEnd: Install ReactJS on Ubuntu VM, Then Deploy ReactJS Docker Alpine Container](./frontEnd.md)


<!-- ## Deploy FullStack MyTrial App with Docker Compose

Check out the **mytrial-full-stack** [docker-compose.yml](./docker-compose.yml) for reference.

~~~bash
cd $pwd/Stem-Cell-Clinical-Trials-Tracker/
docker-compose up
~~~ -->