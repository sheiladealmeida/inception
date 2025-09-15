all: build

secrets:
	@mkdir -p ./secrets
	@if [ ! -f ./secrets/db_root_password.txt ]; then \
		openssl rand -base64 16 > ./secrets/db_root_password.txt; \
	fi
	@if [ ! -f ./secrets/db_password.txt ]; then \
		openssl rand -base64 16 > ./secrets/db_password.txt; \
	fi
	@if [ ! -f ./secrets/wp_admin_password.txt ]; then \
		openssl rand -base64 16 > ./secrets/wp_admin_password.txt; \
	fi
	@if [ ! -f ./secrets/wp_guest_password.txt ]; then \
		openssl rand -base64 16 > ./secrets/wp_guest_password.txt; \
	fi

show-secrets: secrets
	@echo "db_root_password:"; cat ./secrets/db_root_password.txt
	@echo "db_password:"; cat ./secrets/db_password.txt
	@echo "wp_admin_password:"; cat ./secrets/wp_admin_password.txt
	@echo "wp_guest_password:"; cat ./secrets/wp_guest_password.txt

data: show-secrets
	@cp ~/.env ./srcs/
	mkdir -p /home/shrodrig/data/mariadb && mkdir -p /home/shrodrig/data/wordpress

build: data
	cd srcs && docker compose up --build

down:
	cd srcs && docker compose down

clean: 
	cd srcs && docker compose down -v --rmi all
	
fclean: clean
	sudo rm -rf /home/shrodrig/data/mariadb /home/shrodrig/data/wordpress ./srcs/.env ./secrets
	cd srcs && docker system prune -a
	@if [ "$$(docker volume ls -q)" ]; then \
		docker volume rm $$(docker volume ls -q); \
	fi
	