FROM php:8.2-apache

# Required extensions
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    libzip-dev \
    libicu-dev \
    zip

RUN docker-php-ext-install pdo pdo_mysql zip intl

# Enable Apache mod_rewrite (Laravel দরকার)
RUN a2enmod rewrite

COPY . /var/www/html/

WORKDIR /var/www/html

# Composer install
RUN curl -sS https://getcomposer.org/installer | php
RUN php composer.phar install

EXPOSE 80
