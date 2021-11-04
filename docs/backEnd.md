# BackEnd: Deploy MySQL and SpringBoot Containers for MyTrials App

If you haven't installed Docker, refer to our
[Ubuntu Docker Install Guide](./dockerInstallUbuntu.md)

The goal of this guide is to setup the Backend part of the MyTrial's application and connect the MySQL database container with the SpringBoot container using both **jdbc mysql URL** and the **backend docker network**.

## Create Docker Bridged Network for Backend and Frontend

~~~bash
sudo docker network create -d bridge backend
sudo docker network create -d bridge frontend
~~~

## Deploy Docker Container's MySQL Server in Background with Access to Host's mytrial DB

### Set Up Host's mytrial Database using Host's MySQL Server

Install MySQL Server on your host machine:

~~~bash
sudo apt-get -y update
sudo apt-get -y install mysql-server
sudo mysql_secure_installation # set root password, then everything else default
~~~

Run the Database creation script `schema.sql` on host machine:

~~~bash
mysql -u root -p # when asked, enter your password

# replace ${PWD} with path to your project
source ${PWD}/Stem-Cell-Clinical-Trials-Tracker/myTrial-api/src/main/resources/schema.sql
~~~

Verify if you have **mytrial_docker**  user for your MySQL DB on host machine:

~~~sql
-- Running Host's MySQL server to check users who exist
SELECT User, Host FROM mysql.user;
~~~

If that user isn't there, then create that user using your host's MySQL server. Later we'll be using that user from the Docker container's MySQL server to access this host's mytrial database:

~~~sql
-- Running Host's MySQL server to create mytrial_docker user for Docker Container's
-- MySQL server to be able to later access Host's mytrial database tables
USE mytrial;

-- specify mysql docker user, container name where user is
CREATE USER 'mytrial_docker'@'localhost' IDENTIFIED BY 'mytrial_docker';

-- If you need to Delete user, use the following sql:
-- DROP USER 'mytrial_docker'@'localhost';

-- Provide new user mytrial_docker with full access all dbs & tables, etc
GRANT ALL PRIVILEGES ON * . * TO 'mytrial_docker'@'localhost';

-- exit from mysql server service
quit
~~~

Once we are done populating our MySQL mytrial database tables, we can turn off the host's mysql server since only one mysql server can access the mytrial database at a time, so we will be using the Docker container's mysql server to access our host's mytrial database files and directories:

~~~bash
# in host, if mysql server is running, then turn it off
sudo service mysql status

# in host, turn off mysql server
sudo service mysql stop
~~~

### Launch Docker Container's MySQL Server to Access Host's mytrial DB

I think I should use a MySQL Client in Docker container???

Pull the mysql docker image:

~~~bash
sudo docker pull mysql:8.0.27
~~~

Create a named volume mounted to the host's mysql folder that contains mytrial database and more. This volume is outside the scope of any container:

~~~bash
# create volume with path to host's mysql folder
sudo docker volume create --name mytrial-db-data \
    --opt type=none \
    --opt device=/var/lib/mysql \
    --opt o=bind
~~~

Launch Docker container that runs its own MySQL Server that is separate from the host's MySQL Server. This Docker container will have mytrial-db-data volume mounted, so we can access the host's mysql database tables, users, and everything:

~~~bash
# Launches Docker container MySQL server, map TCP port 3306 in container to port 3307 on host
sudo docker run -d \
    --name mytrial-db \
    --restart always \
    -p 3307:3306 \
    --mount source=mytrial-db-data,target=/var/lib/mysql \
    --network=backend \
    mysql:8.0.27
~~~

Now our Docker container's MySQL server is running. We should be able to login to the MySQL Server running inside the container as the same user we were when we were operating the host's MySQL server since we are accessing those mysql files from the host inside our Docker container.

**Option 1:** Let's login to the MySQL server running inside the container as root user using the same password we used when we were running MySQL server on the host machine:

~~~bash
# Login to the container's MySQL server using "root" user, enter your password
sudo docker exec -it mytrial-db mysql -h localhost -u root -p

# Alternatively, you can login to the container's MySQL server using "mytrial_docker" user, 
# it has same password we set up earlier, when asked, enter password mytrial_docker
sudo docker exec -it mytrial-db mysql -h localhost -u mytrial_docker -p
~~~

**Option 2:** You could execute bash command to enter into the **mytrial-db** Docker container, then login to the container's MySQL server directly:

~~~bash
# Jump into Docker container
sudo docker exec -it mytrial-db bash

# didn't work. I will use localhost instead of the container's internal ip
# Inside the container, login to container's MySQL server directly
mysql -h localhost -u mytrial_docker -p # when asked, enter password mytrial_docker
~~~

Now we're in our container's MySQL server, lets verify we can see some data in tables that were populated when we ran our DB creation script:

~~~sql
-- if not used, make sure use mytrial db
SHOW databases;

USE mytrial;

SELECT * FROM org LIMIT 5;

SELECT * FROM trial LIMIT 5;

quit
~~~

As long as everything went well, you should see data in the tables above from within the container's MySQL server.

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
    -e SPRING_DATASOURCE_USERNAME=mytrial_docker \
    -e SPRING_DATASOURCE_PASSWORD=mytrial_docker \
    --network=backend \
    mytrial-api:dev

# It seems, can't connect container to multiple networks
# when creating container, so doing a separate network connect
# to connect container to frontend network too
sudo docker network connect frontend mytrial-sb-server
~~~

Access myTrial-api app at `localhost:8080/test`

So now not only the docker host has access to the docker container, the other remote computers have access to the docker container too.

## Appendix

### Running VirtualBox, Set Up Port Forwarding

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

### Troubleshooting Docker Container

After launching the docker container **mytrial-db**, if you are not able to login to the container's mysql server or even jump into the container, check if the container is running:

~~~bash
# shows running containers
sudo docker ps

# shows all containers even if not running
sudo docker ps -a
~~~

If the container doesn't show up in the output after running the command(s) above, check the arguments you pass to launch the container:

~~~bash
sudo docker run -d \
    --name mytrial-db \
    --restart always \
    -p 3307:3306 \
    --mount source=mytrial-db-data,target=/var/lib/mysql \
    --network=backend \
    mysql:8.0.27
~~~

Make sure you didn't miss anything or if you modified an argument or added another argument, check how it changes the launch of the container.

Also you could run **journalctl** to see a log of all the processes that are running, keep that terminal window open and open another terminal to relaunch the container.

~~~bash
# terminal 1
journalctl
~~~

Open another terminal, if your Docker container hasn't been removed yet, remove it, then relaunch it using the **docker run** command above:

~~~bash
sudo docker rm mytrial-db
~~~

### Troubleshooting Host's MySQL Server and Docker Container's MySQL Server

#### Turn Off Docker Container's MySQL Server, Login to Host's MySQL Server

If you have the Docker container's MySQL server running, but you need to use the Host's MySQL server, you should turn off the container since only one MySQL server should running at a time to access the data in the Database:

~~~bash
# host terminal, not inside docker container
sudo docker stop mytrial-db
~~~

From the host's terminal, let's check the status of MySQL server:

~~~bash
# host terminal, not inside docker container
sudo service mysql status
~~~

If your host's mysql is off or failed to start and you see **Errorcode 13**, that means the privileges of the data directory or its contents do not permit server access.

Let's first verify ownership of mysql's data directory and its contents to see if the mysql server has access:

~~~bash
# host terminal, not inside docker container
sudo ls -la /var/lib/mysql
~~~

If you see another owner besides mysql like **systemd-coredump**, let's change the permissions for the involved files and directories so the server has right to use them. I also notice this error happening when we use the Docker Container's MySQL Server to access the data that was in the host's MySQL Server.

Lets change the ownership back to **mysql**:

~~~bash
# host terminal, not inside docker container
sudo chown -R mysql /var/lib/mysql
~~~

Now try starting mysql service again:

~~~bash
# host terminal, not inside docker container
sudo service mysql start
~~~

You should be able to login to mysql server:

~~~bash
# host terminal, not inside docker container
mysql -u root -p # password whatever you set it to
~~~

#### Turn Off Host's MySQL Server, Login to Docker Container's MySQL Server

Also keep in mind if you are trying to login to the Docker Container's MySQL Server, but you are facing issues, such as the following error:

    ERROR 2002 (HY000): Can't connect to local MySQL server through socket '/var/run/mysqld/mysqld.sock' (2)

check if the host's MySQL server is running and turn it off, then try to login to the container's MySQL Server again.

~~~bash
# host terminal, not inside docker container
sudo service mysql stop
~~~

Now let's go into Docker container:

~~~bash
# host terminal, not inside docker container yet
sudo docker exec -it mytrial-db bash

# Inside docker container, login to container's MySQL Server
mysql -h localhost -u mytrial_docker -p # when asked, enter password mytrial_docker
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