FROM mariadb:11.4

LABEL description="MariaDB image for local development"

ENV MYSQL_ROOT_PASSWORD=root123

COPY init.sql /docker-entrypoint-initdb.d/

EXPOSE 3306
