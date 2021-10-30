# BackEnd: Deploy SpringBoot JAR App into Docker Alpine Container

1\. Let's change to the **myTrial-api** directory:

~~~bash
cd myTrial-api
~~~

2\. Create .jar file use below command

~~~bash
./mvnw install
~~~

<!-- 2\. Create the 'Dockerfile'(name exactly the same) and copy the below code(Dockerfile should be out of target directory):

~~~bash
# NOTE: Creating Dockerfile for backend
FROM openjdk:17-jdk-alpine</br>
ARG JAR_FILE=target/*.jar</br>
COPY ${JAR_FILE} app.jar</br>
ENTRYPOINT ["java","-jar","/app.jar"]
~~~ -->

3\. Build and tag the Docker image for our SpringBoot **myTrial-api** app using the Dockerfile:

~~~bash
sudo docker build -t springio/gs-spring-boot-docker
~~~

Here springio/gs-spring-boot-docker is the name of the docker.
Once docker image is generated any number of containers can be made out of this docker image (Containers are like the instance of Image).

<!-- 4\. Use only one of the following **docker run** commands:

A.) Lets launch the docker container with the image we have:

~~~bash
sudo docker run springio/gs-spring-boot-docker
~~~

- The above command runs the server in attached mode(foreground process) now terminal is inaccessible and if we ctrl+c docker and server goes down.

B.) Lets launch the docker container in background:

~~~bash
sudo docker run -b springio/gs-spring-boot-docker
~~~ -->

4\. Launch the Docker container named **scct_tracker_be** for our SpringBoot app with the code based from **myTrial-api** folder:

~~~bash
sudo docker run \
    --name scct_tracker_be \
    -bp 8080:8080 \
    springio/gs-spring-boot-docker
~~~

So now not only the docker host has access to the docker container, the other remote computers have access to the docker container too.

### Appendix

If you are running in Virtual Box, you need to setup port forwarding:

* Machine->settings->network->advanced->port forwarding
* Add connection(small + button on the right)
* Host `ip:empty`, Host `port:8080`, 
* Guest `ip:empty`, Guest `port: 8080`

Command to find the IP of the docker container:

~~~bash
sudo docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' container_name_or_id
~~~

List all the docker instances:

~~~bash
sudo docker ps
~~~

## Reference

- [Docker Tutorial for Beginners - A Full DevOps Course on How to Run Applications in Containers](https://www.youtube.com/watch?v=fqMOX6JJhGo&t=1058s)