# Dockerfile for Postgres 9.3 on Ubuntu (TAGS: 12.04)

[Docker index](https://index.docker.io/u/fixate/postgres/)

**Notes:**

 - Creates a superuser called `docker` with password 'password'.
 - Postgres data is decoupled from the image in a `/data` volume.

### Next steps

To run from docker index:

```shell
First run:
$ CONTAINER=$(docker run -name fixate_postgres fixate/postgresql)
Start up:
$ CONTAINER=$(docker start fixate_postgres)
Get the IP:
$ IP=`$(docker inspect -format='{{ .NetworkSettings.IPAddress }}' $CONTAINER )
```

Access the database in a container:

```shell
# Connect using IP
$ psql -U docker -h $IP -p 5432 template1
(password: password)
```
