#!/bin/bash
: ${CHANGELOG_FILE:="changelog_diff.xml"}

TS=$(date +%s)
echo "Generating changelog ...."
liquibase --diffTypes="$DIFF_TYPES" --defaultSchemaName="$DB_SCHEMA_NAME" --changeLogFile="/changelogs/$TS-$CHANGELOG_FILE" generateChangeLog

echo "Changelog generated into: /changelogs/$TS-$CHANGELOG_FILE"
