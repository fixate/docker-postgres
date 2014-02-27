#!/bin/bash

# Starts up postgresql within the container.
# test if PGDATA has content
[[ -d $PGDATA ]] || mkdir -p $PGDATA
chown -R postgres:postgres $PGDATA
chmod -R 700 $PGDATA

if [ ! "$(ls -A $PGDATA)" ]; then
  echo "Initializing Postgres at $PGDATA"

  # Ensure we have the right permissions set on the PGDATA
  chmod -R 700 $PGDATA

  # Copy the data that we generated within the container to the empty PGDATA.
  su postgres -c "cp -R /var/lib/postgresql/9.3/main/* $PGDATA"

  /etc/init.d/postgresql start
  su postgres -c 'createuser -d -r -s -l fixate' || true
  # Change this password or remove this user in production!
  su postgres -c 'psql -c "ALTER USER fixate WITH PASSWORD '"'"'password'"'"'"' || true
  /etc/init.d/postgresql stop
fi

[[ -d /logs ]] || mkdir /logs
chown -R postgres:postgres /logs

exec /sbin/setuser postgres /usr/lib/postgresql/9.3/bin/postgres -D /etc/postgresql/9.3/main >> /logs/postgres.log 2>> /logs/postgres.err

