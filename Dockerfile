FROM openjdk:8-jre-alpine
MAINTAINER Jeroen Geusebroek <me@jeroengeusebroek.nl>

# Install git, download and extract Bitbucket Server and create the required directory layout.
# Try to limit the number of RUN instructions to minimise the number of layers that will need to be created.
RUN apk add --no-cache git bash tar curl perl

# Use the default unprivileged account. This could be considered bad practice
# on systems where multiple processes end up being executed by 'daemon' but
# here we only ever run one process anyway.
ENV RUN_USER            daemon
ENV RUN_GROUP           daemon

# https://confluence.atlassian.com/display/BitbucketServer/Bitbucket+Server+home+directory
ENV BITBUCKET_HOME          /var/atlassian/application-data/bitbucket

# Install Atlassian Bitbucket Server to the following location
ENV BITBUCKET_INSTALL_DIR   /opt/atlassian/bitbucket

ENV BITBUCKET_VERSION 4.11.1
ENV DOWNLOAD_URL        https://downloads.atlassian.com/software/stash/downloads/atlassian-bitbucket-${BITBUCKET_VERSION}.tar.gz

ENV MYSQL_CONNECTOR_VERSION 5.1.40
ENV DOWNLOAD_URL_MYSQL_CONNECTOR        http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.tar.gz

ENV UMASK 0027
ENV JVM_MINIMUM_MEMORY 384m
ENV JVM_MAXIMUM_MEMORY 512m

RUN mkdir -p                             ${BITBUCKET_INSTALL_DIR} \
    && curl -L --silent                  ${DOWNLOAD_URL} | tar -xz --strip=1 -C "$BITBUCKET_INSTALL_DIR" \
    && curl -L --silent                  ${DOWNLOAD_URL_MYSQL_CONNECTOR} | tar -xz --strip=1 -C "${BITBUCKET_INSTALL_DIR}/lib" mysql-connector-java-${MYSQL_CONNECTOR_VERSION}/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}-bin.jar \
    && mkdir -p                          ${BITBUCKET_INSTALL_DIR}/conf/Catalina      \
    && chmod -R 700                      ${BITBUCKET_INSTALL_DIR}/conf/Catalina      \
    && chmod -R 700                      ${BITBUCKET_INSTALL_DIR}/logs               \
    && chmod -R 700                      ${BITBUCKET_INSTALL_DIR}/temp               \
    && chmod -R 700                      ${BITBUCKET_INSTALL_DIR}/work               \
    && chown -R ${RUN_USER}:${RUN_GROUP} ${BITBUCKET_INSTALL_DIR}/                   \

    && sed -i -e "s/^# \(umask ${UMASK}\)$/\1/g;" \
              -e "s/^\(JVM_MINIMUM_MEMORY\).*$/\1=\"${JVM_MINIMUM_MEMORY}\"/g" \
              -e "s/^\(JVM_MAXIMUM_MEMORY\).*$/\1=\"${JVM_MAXIMUM_MEMORY}\"/g" \
              /opt/atlassian/bitbucket/bin/setenv.sh

USER ${RUN_USER}:${RUN_GROUP}

VOLUME ["${BITBUCKET_HOME}"]

# HTTP Port
EXPOSE 7990

# SSH Port
EXPOSE 7999

WORKDIR $BITBUCKET_INSTALL_DIR

# Run in foreground
CMD ["./bin/start-bitbucket.sh", "-fg"]
