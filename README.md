# Dockerfile for Postgres 9.3 on Ubuntu 14.04 (TAGS: 9.3)

[Docker index](https://index.docker.io/u/fixate/postgres/)

**Notes:**

 - Creates a superuser called `docker` with password 'password'.
 - Postgres data is decoupled from the image in a `/data` volume.

### Next steps

To run from docker index:

```shell
First run:
$ CONTAINER=$(docker run -d \
             --name postgres \
             -p 5432 \
             -v="/var/postgresql/data:/var/postgresql/data:rw" \
             -v="/var/postgresql/logs:/var/postgresql/logs:rw" \
             -e PGDATA=/var/postgresql/data -d "fixate/postgresql:9.3-1")
Start up:
$ CONTAINER=$(docker start postgres)
Get the IP:
$ IP=`$(docker inspect -format='{{ .NetworkSettings.IPAddress }}' $CONTAINER )
```

Access the database in a container:

```shell
# Check if running and get the port
docker ps 
# Connect using IP
$ psql -U docker -h $IP -p [your port] template1
(password: password)
```
