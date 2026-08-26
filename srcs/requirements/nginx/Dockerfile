FROM debian:bookworm

# Install NGINX and OpenSSL (for generating the security certificates)
RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

# Generate a self-signed SSL certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/inception.key \
    -out /etc/ssl/certs/inception.crt \
    -subj "/C=MA/ST=BeniMellalKhenifra/L=Khouribga/O=1337/OU=Student/CN=aelkadir.42.fr"

# Copy our custom configuration into the NGINX settings directory
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

# Expose the HTTPS port
EXPOSE 443

# Start NGINX in the foreground (PID 1)
CMD ["nginx", "-g", "daemon off;"]