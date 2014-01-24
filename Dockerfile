FROM ubuntu:12.04
# Totes lifted from https://github.com/Painted-Fox/docker-postgresql
MAINTAINER Stan Bondi <stan@fixate.it>

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list && \
        apt-get update && \
        apt-get upgrade

# Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

# Install the latest postgresql
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
        apt-get update && \
        DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes postgresql-9.3 postgresql-contrib-9.3 && \
        /etc/init.d/postgresql stop

# Decouple our data from our container.
VOLUME ["/data"]

# Add scripts
ADD scripts/ /opt/fixate/
RUN DATADIR="/data" /opt/fixate/setup_db.sh

EXPOSE 5432
ENV DATADIR /data
ENTRYPOINT ["/opt/fixate/pg_start.sh"]
