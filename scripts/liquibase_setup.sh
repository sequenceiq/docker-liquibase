#!/bin/bash
echo "Setting up liquibase"
: ${DB_ENV_POSTGRES_USER?"DB_ENV_POSTGRES_USER not set"}
: ${DB_ENV_POSTGRES_PASSWORD?"DB_ENV_POSTGRES_PASSWORD not set"}

cat <<CONF > /liquibase.properties
  driver: org.postgresql.Driver
  classpath:/usr/local/bin/postgresql-9.3-1102.jdbc41.jar
  url: jdbc:postgresql://$DB_PORT_5432_TCP_ADDR:$DB_PORT_5432_TCP_PORT/$POSTGRES_USER
  username: $DB_ENV_POSTGRES_USER
  password: $DB_ENV_POSTGRES_PASSWORD
CONF
