#/bin/bash
set -e

psql -v ON_ERROR_STOP=0 --username "$POSTGRES_USER" <<-EOSQL
     CREATE DATABASE sakila;
EOSQL

cd /tmp
wget https://sp.postgresqltutorial.com/wp-content/uploads/2019/05/dvdrental.zip; unzip dvdrental.zip
pg_restore -U postgres -d sakila dvdrental.tar
