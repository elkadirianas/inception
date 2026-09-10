# Paths
WP_DIR = /home/aelkadir/data/wordpress
DB_DIR = /home/aelkadir/data/mariadb

# Default target
all: up

# Create directories, build images, and start containers in detached mode
up:
	@mkdir -p $(WP_DIR)
	@mkdir -p $(DB_DIR)
	docker compose  up -d --build

# Stop and remove containers, networks, and containers' default volumes
down:
	docker compose  down

# Start containers without rebuilding
start:
	docker compose  start

# Stop running containers without removing them
stop:
	docker compose  stop

# Show the status of the containers
status:
	docker compose  ps

# Clean up containers and Docker volumes
clean: down
	docker compose  down -v

# Completely wipe everything: containers, images, system cache, and the physical data folders
fclean: clean
	docker system prune -af --volumes
	@sudo rm -rf $(WP_DIR)/*
	@sudo rm -rf $(DB_DIR)/*

# Rebuild everything from scratch
re: fclean all
