FROM debian:trixie
RUN apt update && apt upgrade -y && apt install -y \
php8.4-fpm \
php8.4-mysqli \
curl
RUN mkdir -p /run/php && chown -R www-data:www-data /run/php
COPY conf/www.conf /etc/php/8.4/fpm/pool.d/.
COPY wp-install.sh .
RUN chmod +x wp-install.sh
ENTRYPOINT ["./wp-install.sh"]