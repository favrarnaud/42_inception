DOCKERFILE = ./srcs/docker-compose.yml

all: up

up:
	@sudo mkdir -p /home/afavre/data/mariadb/
	@sudo mkdir -p /home/afavre/data/wordpress/
	@sudo echo "127.0.0.1 afavre.42.fr" >> /etc/hosts
	sudo docker compose -f $(DOCKERFILE) up

down:
	sudo docker compose -f $(DOCKERFILE) down

re:
	sudo docker compose -f $(DOCKERFILE) up --build

clean: down
	docker system prune -f
	docker image rm srcs-nginx srcs-wordpress srcs-mariadb
	docker volume rm db_data wp_data
	rm -rf /home/afavre

.PHONY: all up down re clean
