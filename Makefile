all: build
data:
	@cp ~/.env ./srcs/
	mkdir -p /home/shrodrig/data/mariadb && mkdir -p /home/shrodrig/data/wordpress

build: data
	cd srcs && docker compose up --build

clean:
	cd srcs && docker system prune -a
	docker volume rm $$(docker volume ls -q)