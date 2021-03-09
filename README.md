# docker-compose-postgredashboard


## Overview
PostgreSQL playground running on Docker with info, stats and logs displayed in a Grafana dashboard. Additional services running are pgAdmin, Schemaspy and Sqlpad.

## Usage
Install docker and docker-compose. Clone this repo to your local machine. Start containers:

```sh
docker-compose up
```

### Open pgAdmin webinterface

[pgAdmin webinterface](http://pgadmin.docker.localhost)

Database, username and password: postgres

### Connect to Postgres container
```sh
docker-compose exec postgres sh
```
Additional commands to start psql:
```sh
su postgres
psql
```
Start psql directly:
```sh
docker-compose exec postgres psql -U postgres
```

### Download and unzip test database (in the container)
```sh
wget https://s3.amazonaws.com/assets.datacamp.com/course/sql/dvdrental.zip; unzip dvdrental.zip
```

### Create database (psql)
```sh
docker-compose exec postgres psql -U postgres
CREATE DATABASE sakila;
exit
```

### Load database using pg_restore
```sh
pg_restore -U postgres -d sakila dvdrental.tar
```

### Collect logs
```sh
docker-compose exec postgres bash /scripts/pglog.sh
```

### Run 1000 queries
```sh
yes "select * from public.film_actor;" | head -n 1000 | parallel "psql -U postgres -d sakila -c {1}"
```

## Pgbench
```sh
psql> CREATE DATABASE pgbenchdb;
pgbench -i -s 50 pgbenchdb
pgbench -c 10 -j 2 -t 1000 pgbenchdb
```

### Useful commands
```bash
# Check CPU consumption
$ docker stats $(docker inspect -f "{{ .Name }}" $(docker ps -q))

# Remove containers plus volumes
$ docker-compose down -v --remove-orphans --rmi all

# docker-compose Elasticsearch
```

![postgres](diagram.png?raw=true)
