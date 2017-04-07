docker-liquibase
================

Docker image with Liquibase installation.

### Default behavior

By default runs a simple container with Liquibase:

```docker run -it --name liquibase sequenceiq/liquibase```

In the shell you can perform the usual `liquibase` operations.

### Support for automation

Additionally the image has a set of scripts that help automating a few liquibase commands:
* _diff_
* _update_

The image comes with a preinstalled postgres jdbc driver.

Linked with a postgres database and provided with a volume, the container can be used
to automatically perform diff and update operations.

#### diff

```
docker run -it \
--name $LIQUIBASE_CONTAINER \
--link $REFERENCE_DB_CONTAINER:db \
--entrypoint="/scripts/liquibase_command.sh" \
-e CONNECTION_STRING="jdbc:postgresql://$DB_IP:5432/$DB_NAME" \
-e DB_USER="$DB_USER" \
-e DB_PASS="$DB_PASS" \
-e LIQUIBASE_INCLUSION_FILE="$LIQUIBASE_INCLUSION_FILE" \
-v /$LIQUIBASE_CHANGELOGS:/changelogs \
sequenceiq/liquibase \
"diff"
```

The variables should be set as follows:

LIQUIBASE_CONTAINER - the name of the docker container  
REFERENCE_DB_CONTAINER - the docker container running a (postgres) database being the reference of the diff command  
CONNECTION_STRING - the connection to the target database  
DB_IP - the IP address of the target database  
DB_NAME - the target database name  
DB_USER - the user to the target database  
DB_PASS - password to the target database  
LIQUIBASE_INCLUSION_FILE - changelog file name in the _changelogs_ folder, the generated diff file will be added as an include tag to it if provided  
LIQUIBASE_CHANGELOGS - volume on the host machine, where the generated file will be written  

By running the command above , you'll get on the volume:

1. a new changelog file with the diff results
2. the new changelog file included in the provided include-file


#### update

```
docker run -it \
--name $LIQUIBASE_CONTAINER \
--link $DB_CONTAINER:db \
--entrypoint="/scripts/liquibase_command.sh" \
-v /$LIQUIBASE_CHANGELOGS:/changelogs \
-e CHANGELOG_FILE=$LIQUIBASE_CHANGELOG_FILE \
sequenceiq/liquibase\
"update"
```

Variables:

LIQUIBASE_CONTAINER - the name of the docker container  
DB_CONTAINER - the container name running the target database  
LIQUIBASE_CHANGELOGS - volume with the changelogs to be applied  
LIQUIBASE_CHANGELOG_FILE - the name of the changelog file to be applied

#### generate

```
docker run -it \
--name $LIQUIBASE_CONTAINER \
--link $DB_CONTAINER:db \
--entrypoint="/scripts/liquibase_command.sh" \
-v /$LIQUIBASE_CHANGELOGS:/changelogs \
-e CHANGELOG_FILE=$LIQUIBASE_CHANGELOG_FILE \
-e DB_SCHEMA_NAME=$SCHEMA_NAME \
-e DIFF_TYPES=data \
sequenceiq/liquibase\
"generate"
```

Variables:

LIQUIBASE_CONTAINER - the name of the docker container
DB_CONTAINER - the container name running the target database
LIQUIBASE_CHANGELOGS - volume with the changelogs to be applied
LIQUIBASE_CHANGELOG_FILE - the name of the changelog file to be applied
SCHEMA_NAME(optional) - which schema to run against
DIFF_TYPES(optional) - which diff type to use
