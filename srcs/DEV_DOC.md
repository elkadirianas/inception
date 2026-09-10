# Developer Documentation

This document provides technical instructions for setting up the host machine, understanding the Makefile and Docker Compose structure, and managing data persistence.

## 1. Prerequisites

Before building the infrastructure, the host machine must be properly configured with the necessary tools.

- **Operating System:** A Debian or Alpine Linux virtual machine.
- **Packages Required:** 
  - docker (or docker.io / docker-ce)
  - docker-compose-plugin (to use docker compose v2)
  - make
- **Network Configuration:** The NGINX server routes traffic based on the domain name. You must map the local loopback address to the project domain. 
  Add the following line to /etc/hosts on your host machine:
  127.0.0.1 aelkadir.42.fr

## 2. Setup

The Docker Compose configuration relies on environment variables for security. You must create a .env file inside the srcs/ directory before starting the project.

Create srcs/.env with the following variables:

DOMAIN_NAME=aelkadir.42.fr \
MYSQL_ROOT_PASSWORD=your_secure_root_password \
MYSQL_DATABASE=wordpress \
MYSQL_USER=wp_user \
MYSQL_PASSWORD=your_secure_db_password \
WP_ADMIN_USER=admin_user \
WP_ADMIN_PASSWORD=admin_password \
WP_ADMIN_EMAIL=admin@42.fr \
WP_USER=normal_user \
WP_USER_PASSWORD=normal_password \
WP_USER_EMAIL=user@42.fr \

## 3. Makefile Usage

The Makefile at the repository root abstracts the infrastructure management and handles host directory creation for data persistence.

- make or make up: Creates local volume directories (/home/aelkadir/data/...) and starts the containers in the background.
- make down: Stops the containers and the custom network without removing data.
- make clean: Stops containers and removes the associated Docker volumes.
- make fclean: Performs a total wipe. Stops everything, prunes all Docker system data, and forcefully deletes the physical files in the host's data directories.
- make re: Runs fclean followed by up for a completely fresh build.
- make status: Displays the status of the running containers.

## 4. Compose Commands

Under the hood, the Makefile executes the following standard Docker Compose commands from the srcs/ directory:

- Build and start in detached mode: 
  docker compose -f srcs/docker-compose.yml up -d --build
- Stop and remove containers/networks: 
  docker compose -f srcs/docker-compose.yml down
- Stop and remove containers, networks, AND volumes: 
  docker compose -f srcs/docker-compose.yml down -v

## 5. Data Persistence

To ensure data survives container restarts or complete rebuilds, Docker volumes are mapped directly to the host machine's filesystem instead of using ephemeral container storage.

- WordPress Files (HTML/PHP): 
  Mapped from /var/www/html inside the WordPress and NGINX containers to /home/aelkadir/data/wordpress on the host VM.
- Database Files (MariaDB): 
  Mapped from /var/lib/mysql inside the MariaDB container to /home/aelkadir/data/mariadb on the host VM.

Because these files are stored on the host, running docker compose down will not delete your WordPress posts or user accounts.