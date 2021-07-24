FROM postgres:11-alpine


RUN ["sed", "-i", "s/exec \"$@\"/echo \"skipping...\"/", "/usr/local/bin/docker-entrypoint.sh"]

ENV PG_USER=postgres
ENV POSTGRES_PASSWORD=docker
ENV PGDATA=/data

EXPOSE 5432:5432
# final build stage
FROM postgres:11-alpine