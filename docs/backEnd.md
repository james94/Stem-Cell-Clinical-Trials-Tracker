# Backend Document

This document contains all the documentation and LLBP for backend

## Docker
### Basic info

https://www.youtube.com/watch?v=fqMOX6JJhGo&t=1058s

### Setup

* Create .jar file use below command</br>
./mvnw install

* Create the 'Dockerfile'(name exactly the same) and copy the below code(Dockerfile should be out of target directory)</br>
FROM openjdk:17-jdk-alpine</br>
ARG JAR_FILE=target/*.jar</br>
COPY ${JAR_FILE} app.jar</br>
ENTRYPOINT ["java","-jar","/app.jar"]

* Generate docker image by building Dockerfile</br>
sudo docker build -t springio/gs-spring-boot-docker .</br>
Here springio/gs-spring-boot-docker is the name of the docker

__USE ONLY ONE OF THE FOLLOWING RUN COMMANDS__</br>
* Docker run</br>
Once docker image is generated anynumber of containers can be made out of this docker image(Containers are like the instance of Image).
Now lets run the docker with the image we have</br>

sudo docker run springio/gs-spring-boot-docker</br>
Above command runs the server in attached mode(foreground process) now terminal is inaccessible and if we ctrl+c docker and server goes down.

To run the docker in background use -b</br>
sudo docker run -b springio/gs-spring-boot-docker</br>

Only the docker host has access to the docker container so to make it access to others use the below command</br>
sudo docker run -bp 8080:8080 springio/gs-spring-boot-docker</br>

### Appendix

If you are running in Virtual Box you need to setup port forwarding:
* Machine->settings->network->advanced->port forwarding
* Add connection(small + button on the right)
* Host ip:empty, Host port:8080, Guest ip:empty, Guest port: 8080

Command to find the IP of the docker container:</br>
sudo docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' container_name_or_id

List all the docker instances:</br>
sudo docker ps
