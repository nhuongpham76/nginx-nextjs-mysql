FROM php:8.2-fpm

WORKDIR /var/www/html

# Installing dependencies for the PHP modules
RUN apt-get update && apt-get install -y \
        libfreetype-dev libjpeg62-turbo-dev zip curl libcurl3-dev libzip-dev libpng-dev libonig-dev libxml2-dev wget \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) exif curl gd mbstring mysqli pdo pdo_mysql xml zip bcmath

# Installing additional PHP modules
#RUN docker-php-ext-install exif curl gd mbstring mysqli pdo pdo_mysql xml bcmath gd ctype fileinfo json openssl pcre tokenizer pdo_sqlite zip

# Install Composer so it's available
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

USER root

RUN chmod 777 -R /var/www/html
