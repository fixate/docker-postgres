#!/bin/bash

# Starts up postgresql within the container.
# test if DATADIR has content
[[ -d $DATADIR ]] || mkdir -p $DATADIR
chown -R postgres:postgres $DATADIR
chmod -R 700 $DATADIR

if [ ! "$(ls -A $DATADIR)" ]; then
  echo "Initializing Postgres at $DATADIR"

  # Copy the data that we generated within the container to the empty DATADIR.
  su postgres -c "cp -R /var/lib/postgresql/9.3/main/* $DATADIR"
fi

[[ -d /logs ]] || mkdir /logs
chown -R postgres:postgres /logs

exec /sbin/setuser postgres /usr/lib/postgresql/9.3/bin/postgres -D /etc/postgresql/9.3/main >> /logs/postgres.log 2>> /logs/postgres.err

