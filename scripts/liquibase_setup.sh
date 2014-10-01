#!/bin/bash
echo "Setting up liquidbase"
: ${DB_PORT_5432_TCP_ADDR?"DB_PORT_5432_TCP_ADDR not set"}
: ${DB_PORT_5432_TCP_PORT?"DB_PORT_5432_TCP_PORT not set"}
: ${DB_ENV_USER?"DB_ENV_USER not set"}
: ${DB_ENV_PASS?"DB_ENV_PASS not set"}
: ${DB_ENV_DB?"DB_ENV_DB not set"}

cat <<CONF > /liquibase.properties
  driver: org.postgresql.Driver
  classpath:/usr/local/bin/postgresql-9.3-1102.jdbc41.jar
  url: jdbc:postgresql://$DB_PORT_5432_TCP_ADDR:$DB_PORT_5432_TCP_PORT/$DB_ENV_DB
  username: $DB_ENV_USER
  password: $DB_ENV_PASS
CONF
