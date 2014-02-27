#!/bin/bash
set -eo pipefail

ESCAPED_DD=${PGDATA/\//\\/}
# Cofigure the database to use our data dir.
sed -i -e"s/data_directory =.*$/data_directory = '$ESCAPED_DD'/" /etc/postgresql/9.3/main/postgresql.conf
# Allow connections from anywhere.
sed -i -e"s/^#listen_addresses =.*$/listen_addresses = '*'/" /etc/postgresql/9.3/main/postgresql.conf
echo "host    all    all    0.0.0.0/0    md5" >> /etc/postgresql/9.3/main/pg_hba.conf

# Add rinit service entry
mkdir -p /etc/service/postgresql
cp -p /tmp/docker/postgresql.sh /etc/service/postgresql/run

