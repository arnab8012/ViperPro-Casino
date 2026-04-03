FROM php:8.2-cli

# Install dependencies
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    libzip-dev \
    libicu-dev \
    zip

# PHP extensions
RUN docker-php-ext-install pdo pdo_mysql zip intl

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php

WORKDIR /app

COPY . .

RUN php composer.phar install

# Laravel serve
CMD php -S 0.0.0.0:8080 -t public

EXPOSE 8080
