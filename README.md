# docker-compose-postgresdashboard


## Overview
PostgreSQL playground running on Docker with info, stats and logs displayed in a Grafana dashboard. Additional services running are pgAdmin, Schemaspy and Sqlpad.

## Usage
Install docker and docker-compose. Clone this repo to your local machine. Start containers:

```sh
$ docker-compose up
```

### Open pgAdmin webinterface

[pgAdmin webinterface](http://pgadmin.docker.localhost)

- Username: dba@naturalis.nl
- Password: postgres
- Database password: postgres

### Connect to Postgres container
```sh
$ docker-compose exec postgres bash
```
Additional commands to start psql:
```sh
$ su postgres
$ psql
```
Start psql directly:
```sh
$ docker-compose exec postgres psql -U postgres
```
### Collect logs
```sh
$ docker-compose exec postgres bash /scripts/pglog.sh
```

### Run 1000 queries
```sh
$ yes "select * from public.film_actor;" | head -n 1000 | parallel "psql -U postgres -d sakila -c {1}"
```

## Pgbench
```sh
psql> CREATE DATABASE pgbenchdb;
$ pgbench -i -s 50 pgbenchdb
$ pgbench -c 10 -j 2 -t 1000 pgbenchdb
```

### Useful commands
```bash
# Check CPU consumption
$ docker stats $(docker inspect -f "{{ .Name }}" $(docker ps -q))

# Remove containers plus volumes
$ docker-compose down -v --remove-orphans --rmi all
```
