FROM debian:buster

ARG WP_DATABASE_NAME
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_ROOT_PASSWORD

RUN apt-get update \
    && apt-get install mariadb-server -y

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY tools/configure.sh /tmp/configure.sh

RUN service mysql start \
    && bash /tmp/configure.sh

EXPOSE 3306

CMD ["mysqld"]
