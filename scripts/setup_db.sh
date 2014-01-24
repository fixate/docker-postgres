#!/bin/bash
set -eo pipefail

ESCAPED_DD=${DATADIR/\//\\/}
# Cofigure the database to use our data dir.
sed -i -e"s/data_directory =.*$/data_directory = '$ESCAPED_DD'/" /etc/postgresql/9.3/main/postgresql.conf
# Allow connections from anywhere.
sed -i -e"s/^#listen_addresses =.*$/listen_addresses = '*'/" /etc/postgresql/9.3/main/postgresql.conf
echo "host    all    all    0.0.0.0/0    md5" >> /etc/postgresql/9.3/main/pg_hba.conf

echo "Initializing Postgres at $DATADIR"

[[ -d $DATADIR ]] || mkdir -p $DATADIR
# Ensure postgres owns the DATADIR
chown -R postgres:postgres $DATADIR
# Ensure we have the right permissions set on the DATADIR
chmod -R 700 $DATADIR

# Copy the data that we generated within the container to the empty DATADIR.
su postgres -c "cp -R /var/lib/postgresql/9.3/main/* $DATADIR"

/etc/init.d/postgresql start
  su postgres -c 'createuser -d -r -s -l docker'
  # Change this password or remove this user in production!
  su postgres -c 'psql -c "ALTER USER docker WITH PASSWORD '"'"'password'"'"'"'
/etc/init.d/postgresql stop

