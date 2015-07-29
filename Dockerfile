FROM java

MAINTAINER SequenceIq

# download liquibase
# ADD http://sourceforge.net/projects/liquibase/files/Liquibase%20Core/liquibase-3.2.2-bin.tar.gz/download /tmp/liquibase-3.2.2-bin.tar.gz
COPY lib/liquibase-3.2.2-bin.tar.gz /tmp/liquibase-3.2.2-bin.tar.gz

# Create a directory for liquibase
RUN mkdir /opt/liquibase

# Unpack the distribution
RUN tar -xzf /tmp/liquibase-3.2.2-bin.tar.gz -C /opt/liquibase
RUN chmod +x /opt/liquibase/liquibase

# Symlink to liquibase to be on the path
RUN ln -s /opt/liquibase/liquibase /usr/local/bin/

# Get the postgres JDBC driver from http://jdbc.postgresql.org/download.html
# ADD http://jdbc.postgresql.org/download/postgresql-9.3-1102.jdbc41.jar /opt/jdbc_drivers/
COPY lib/postgresql-9.3-1102.jdbc41.jar /opt/jdbc_drivers/

RUN ln -s /opt/jdbc_drivers/postgresql-9.3-1102.jdbc41.jar /usr/local/bin/

# Add command scripts
ADD scripts /scripts
RUN chmod -R +x /scripts

VOLUME ["/changelogs"]

WORKDIR /

ENTRYPOINT ["/scripts/liquibase_command.sh"]
