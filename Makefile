all: build
data:
	@cp ~/.env ./srcs/
	mkdir -p /home/sheila/data/mariadb && mkdir -p /home/sheila/data/wordpress

build: data
	cd srcs && docker compose up -d --build

down:
	cd srcs && docker compose down

clean: 
	cd srcs && docker compose down -v --rmi all
	
fclean: clean
	sudo rm -rf /home/sheila/data/mariadb /home/sheila/data/wordpress
	cd srcs && docker system prune -a
	@if [ "$$(docker volume ls -q)" ]; then \
    	docker volume rm $$(docker volume ls -q); \
	fi