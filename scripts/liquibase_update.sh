#!/bin/bash
: ${CHANGELOG_FILE:="/changelogs/changelogs.xml"}

echo "Applying changes to the database ...."
liquibase --changeLogFile="/changelogs/$CHANGELOG_FILE" update
