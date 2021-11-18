# FullStack: Deploy MyTrial App Across React, SpringBoot & MySQL Docker Containers (Mac OS Ed)

<!-- SJSU CMPE 138 Fall 2021 TEAM1 -->

Let's go through the steps to manually deploy each Docker Container in our MyTrials-Tracker Full Stack Web Application by using docker run commands in each linked section.

## BackEnd: MySQL Server Docker Container

The 1st BackEnd part of the application `mytrial-db` is written in mysql.

We will use an existing mysql db service docker image from dockerhub and then build on top of it to come preloaded with our `mytrial` database. Check out the **mytrial-db** [Dockerfile](../myTrial-mysql-db/Dockerfile)

Let's go deploy the MySQL Server Docker Container: [BackEnd: Deploy MySQL and SpringBoot Containers for MyTrials App (Mac OS Ed)](./macNativeDockerBackEnd.md)

## BackEnd: SpringBoot Server Docker Container

The 2nd BackEnd part of the application `mytrial-sb-server` is written in Java SpringBoot.

Check out the **mytrial-api** [Dockerfile](../myTrial-api/Dockerfile) for reference.

Let's go deploy the SpringBoot Server Docker Container: [BackEnd: Deploy MySQL and SpringBoot Containers for MyTrials App (Mac OS Ed)](./macNativeDockerBackEnd.md)

## FrontEnd: ReactJS Client Docker Container

The FrontEnd part of the application `mytrial-client` is written in ReactJS.

Check out the **mytrial-fe** [Dockerfile](../mytrial-fe/Dockerfile) for reference.

Let's go deploy the ReactJS Client Docker Container: [FrontEnd: Deploy ReactJS Docker Alpine Container (Mac OS Ed)](./macNativeDockerFrontEnd.md)

## Save Each Docker Container (MySQL, SpringBoot, ReactJS)

If we save each docker container mentioned above each into a docker image state, then next time, we can load each docker image and launch each one as a container that comes with each part of the app prebuilt out of box for MySQL Server container, SpringBoot container, and ReactJS container.
