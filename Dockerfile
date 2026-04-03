FROM php:8.2-apache

# Install required libs
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    libzip-dev \
    libicu-dev \
    zip

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql zip intl

# Fix Apache MPM issue
RUN a2dismod mpm_event && a2enmod mpm_prefork

# Enable rewrite (Laravel)
RUN a2enmod rewrite

COPY . /var/www/html/

WORKDIR /var/www/html

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php
RUN php composer.phar install

EXPOSE 80
