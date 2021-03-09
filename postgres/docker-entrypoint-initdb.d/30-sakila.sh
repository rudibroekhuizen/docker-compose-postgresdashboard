#/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
     CREATE DATABASE sakila;
EOSQL

wget https://s3.amazonaws.com/assets.datacamp.com/course/sql/dvdrental.zip; unzip dvdrental.zip
pg_restore -U postgres -d sakila dvdrental.tar
