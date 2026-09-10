FROM debian:bookworm

# Install MariaDB
RUN apt-get update && apt-get install -y mariadb-server \
    && rm -rf /var/lib/apt/lists/*

# Use sed to change the bind-address directly in the default config file
RUN sed -i 's/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf

# Copy the initialization script and give it execution rights
COPY tools/init.sh /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/init.sh

# Expose the MariaDB port
EXPOSE 3306

# Run the initialization script when the container starts
ENTRYPOINT ["/usr/local/bin/init.sh"]