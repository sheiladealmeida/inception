FROM debian:trixie
RUN apt update && apt upgrade -y && apt install -y mariadb-server
COPY 50-server.cnf /etc/mysql/mariadb.conf.d/.
RUN mkdir /run/mysqld
COPY mariadb-run.sh .
RUN chmod +x ./mariadb-run.sh
ENTRYPOINT ["./mariadb-run.sh"]