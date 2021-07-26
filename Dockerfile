# syntax=docker/dockerfile:1
FROM ubuntu:16.04

RUN apt-get update && apt-get install -y postgresql

RUN service postgresql

RUN  su - postgres

RUN  psql --command "CREATE USER builders WITH SUPERUSER PASSWORD 'docker';" &&\
    createdb -O builders docker


# Adjust PostgreSQL configuration so that remote connections to the
# database are possible.


RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/12/main/pg_hba.conf

# And add ``listen_addresses`` to ``/etc/postgresql/9.3/main/postgresql.conf``
RUN echo "listen_addresses='*'" >> /etc/postgresql/12/main/postgresql.conf

# Expose the PostgreSQL port
EXPOSE 5432

# Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

# Set the default command to run when starting the container
#CMD ["/usr/lib/postgresql/13/bin/postgres", "-D", "/var/lib/postgresql/13/main", "-c", "config_file=/etc/postgresql/13/main/postgresql.conf"]
