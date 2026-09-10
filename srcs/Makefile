# Paths
WP_DIR = /home/aelkadir/data/wordpress
DB_DIR = /home/aelkadir/data/mariadb


all: up

up:
	@mkdir -p $(WP_DIR)
	@mkdir -p $(DB_DIR)
	docker compose  up -d --build

down:
	docker compose  down

start:
	docker compose  start

stop:
	docker compose  stop


status:
	docker compose  ps

clean: down
	docker compose  down -v

fclean: clean
	docker system prune -af --volumes
	@sudo rm -rf $(WP_DIR)/*
	@sudo rm -rf $(DB_DIR)/*

re: fclean all
