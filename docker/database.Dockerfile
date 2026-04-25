FROM mariadb:11.4

LABEL description="MariaDB image for local development"

COPY docker/init.sql /docker-entrypoint-initdb.d/

EXPOSE 3306
