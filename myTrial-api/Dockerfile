FROM openjdk:17-jdk-alpine

# SJSU CMPE 138 Fall 2021 TEAM1

ENV SPRING_DATASOURCE_URL=jdbc:mysql://mytrial-db:3306/mytrial
ENV SPRING_DATASOURCE_USERNAME=mytrial_docker
ENV SPRING_DATASOURCE_PASSWORD=mytrial_docker

ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]