# SJSU CMPE 138 Fall 2021 TEAM1
FROM mysql:8.0.27

ENV MYSQL_ALLOW_EMPTY_PASSWORD=true
ENV MYSQL_USER=mytrial_docker
ENV MYSQL_PASSWORD=mytrial_docker
ENV MYSQL_DATABASE=mytrial

ARG MYTRIAL_DB_CREATION_SCRIPT=schema.sql
COPY ${MYTRIAL_DB_CREATION_SCRIPT} /docker-entrypoint-initdb.d/

COPY ${MYTRIAL_DB_CREATION_SCRIPT} .
