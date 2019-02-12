FROM atlassian/bitbucket-server
MAINTAINER Jeroen Geusebroek <me@jeroengeusebroek.nl>

ENV MYSQL_CONNECTOR_VERSION 8.0.15
ENV DOWNLOAD_URL_MYSQL_CONNECTOR        http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.tar.gz

RUN curl -L --silent ${DOWNLOAD_URL_MYSQL_CONNECTOR} | tar -xz --strip=1 -C "${BITBUCKET_INSTALL_DIR}/app/WEB-INF/lib" mysql-connector-java-${MYSQL_CONNECTOR_VERSION}/mysql-connector-java-${MYSQL_CONNECTOR_VERSION}.jar
