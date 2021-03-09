#/bin/bash
set -e

# Override settings
echo "include_dir = '/conf.d'" >> "$PGDATA/postgresql.conf"

# Create pg_hba entry for replication
echo "host replication $REPLICATION_USER 0.0.0.0/0 trust" >> "$PGDATA/pg_hba.conf"

# Create users
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
     CREATE EXTENSION pg_stat_statements;
     CREATE ROLE analytics WITH SUPERUSER PASSWORD 'postgres' LOGIN;
EOSQL
