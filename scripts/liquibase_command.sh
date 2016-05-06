#!/bin/bash -e

echo "Setting up liquibase..."
./scripts/liquibase_setup.sh

echo "Processing liquibase tasks ..."
case "$1" in
    "diff" )
        echo "Generating diff ..."
        ./scripts/liquibase_diff.sh
        ;;
    "update" )
        echo "Applying changelogs ..."
        ./scripts/liquibase_update.sh
        ;;
    "generate" )
        echo "Generating changelog ..."
        ./scripts/liquibase_generate.sh
        ;;
     * )
        exec "$@"
esac
