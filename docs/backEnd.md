# BackEnd: Deploy MySQL and SpringBoot Containers for MyTrials App

If you haven't installed Docker, refer to our
[Ubuntu Docker Install Guide](./dockerInstallUbuntu.md)

The goal of this guide is to setup the Backend part of the MyTrial's application and connect the MySQL database container with the SpringBoot container using both **jdbc mysql URL** and the **backend docker network**.

## Create Docker Bridged Network for Backend & Frontend

~~~bash
sudo docker network create -d bridge backend 
sudo docker network create -d bridge frontend
~~~

## Deploy MySQL Docker Container in Background with DB Mounted Volume to Host

Run the Database creation script `schema.sql`:

~~~bash
mysql -u root -p # when asked, enter your password

# replace ${PWD} with path to your project
source ${PWD}/Stem-Cell-Clinical-Trials-Tracker/myTrial-api/src/main/resources/schema.sql
~~~

Verify some tables have data

~~~sql
-- if not used, make sure use mytrial db
USE mytrial;

SELECT * FROM org;

SELECT * FROM trial LIMIT 5;

quit
~~~

Pull the mysql docker image:

~~~bash
sudo docker pull mysql:8.0.27
~~~

Create a named volume outside the scope of any container:

~~~bash
sudo docker volume create mytrial-db-data

# sudo docker volume inspect mytrial-db-data
~~~

NOTE: We use named volume instead of host mounted volume to avoid losing volume information.

Launch mysql container in background:

~~~bash
# map TCP port 3306 in container to port 3307 on host
sudo docker run -d \
    --name mytrial-db \
    --restart always \
    -p 3307:3306 \
    -e MYSQL_ROOT_PASSWORD=root \
    -e MYSQL_USER=mytrial_user \
    -e MYSQL_PASSWORD=mytrial_user \
    -e MYSQL_DATABASE=mytrial \
    -v mytrial-db-data:/var/lib/mysql \
    --network=backend \
    mysql:8.0.27
~~~

## Deploy SpringBoot Alpine Docker Container with JDBC MySQL Connection

1\. Install OpenJDK and Maven:

~~~bash
sudo apt -y update
sudo apt -y install openjdk-17-jre-headless
sudo apt -y install maven
~~~

2\. Let's change to the **myTrial-api** directory:

~~~bash
cd ${PWD}/Stem-Cell-Clinical-Trials-Tracker/myTrial-api
~~~

3\. Create .jar file use below command

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

4\. Build and tag the Docker image for our SpringBoot **myTrial-api** app using the Dockerfile:

~~~bash
sudo docker build -t mytrial-api:dev .
~~~

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

5\. Launch the Docker container named **mytrial-sb-server:** for our SpringBoot app with the code based from **myTrial-api** folder:

~~~bash
sudo docker run -d \
    --name mytrial-sb-server \
    -p 8080:8080 \
    -e SPRING_DATASOURCE_URL=jdbc:mysql://mytrial-db:3306/mytrial \
    -e SPRING_DATASOURCE_USERNAME=mytrial_user \
    -e SPRING_DATASOURCE_PASSWORD=mytrial_user \
    --network=backend \
    mytrial-api:dev

# It seems, can't connect container to multiple networks
# when creating container, so doing a separate network connect
# to connect container to frontend network too
sudo docker network connect frontend mytrial-sb-server
~~~

Access myTrial-api app at `localhost:8080/test`

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

- [Spring Boot, MySQL, React Docker Compose Example](https://www.callicoder.com/spring-boot-mysql-react-docker-compose-example/)
- [Spring Boot + Spring Security + JWT + MySQL + React Full Stack Polling App - Part 1](https://www.callicoder.com/spring-boot-spring-security-jwt-mysql-react-app-part-1/): Part on **Configuring the Server, Database, Hibernate and Jackson**
- [DockerHub: MySQL](https://hub.docker.com/_/mysql)
- [Docker Documentation: Compose File Version 3 Reference](https://docs.docker.com/compose/compose-file/compose-file-v3/)
- [Docker Documentation: Use Volumes](https://docs.docker.com/storage/volumes/)
- [Docker Documentation: Container Networking](https://docs.docker.com/config/containers/container-networking/)
- [Docker Documentation: Docker Network Create](https://docs.docker.com/engine/reference/commandline/network_create/)
- [Docker Documentation: Docker Network Connect](https://docs.docker.com/engine/reference/commandline/network_connect/)
- [Docker Tutorial for Beginners - A Full DevOps Course on How to Run Applications in Containers](https://www.youtube.com/watch?v=fqMOX6JJhGo&t=1058s)
- [Stackoverflow: Docker - Container cannot be connected to network endpoints](https://stackoverflow.com/questions/60301221/docker-container-cannot-be-connected-to-network-endpoints): Part on when I found when you launch container, it seems we can't connect to multiple networks just one at that time, we have to manually connect them to remaining networks using "docker network connect"

- [Stackoverflow: How to run SQL script in MySQL?](https://stackoverflow.com/questions/8940230/how-to-run-sql-script-in-mysql)