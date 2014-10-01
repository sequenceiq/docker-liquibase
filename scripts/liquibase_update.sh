#!/bin/bash
: ${CHANGELOG_FILE:="/changelogs/changelogs.xml"}

echo "Applying changes to the database. Changelog: $CHANGELOG_FILE"
liquibase --changeLogFile="/changelogs/$CHANGELOG_FILE" update
