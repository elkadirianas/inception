FROM debian:bookworm


RUN apt-get update && apt-get install -y mariadb-server \
    && rm -rf /var/lib/apt/lists/*


RUN sed -i 's/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf



COPY tools/init.sh /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/init.sh


EXPOSE 3306


ENTRYPOINT ["/usr/local/bin/init.sh"]