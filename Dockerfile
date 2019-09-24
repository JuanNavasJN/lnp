FROM debian:stretch-slim
MAINTAINER Juan Navas <yo@juannavas.xyz>

RUN apt-get update && apt-get install -y systemd && apt install -y git unzip curl nano

RUN apt install -y apt-transport-https lsb-release ca-certificates wget && \
    wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list && \
    apt update && apt install -y php7.2 && \
    apt install -y php7.2 php7.2-cli php7.2-common php7.2-json php7.2-opcache php7.2-curl php7.2-gd php7.2-xml php7.2-mysql php7.2-zip php7.2-fpm php7.2-mbstring
  
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    chmod +x /usr/local/bin/composer

RUN apt-get install -y nginx

RUN chown -R www-data:www-data /var/www/html/* && \
    chmod -R 755 /var/www/html/*

EXPOSE 80 3306 8000

ENTRYPOINT service nginx restart && service php7.2-fpm start && tail -f /dev/null
