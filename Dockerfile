FROM php:8.2-apache

# Install libs
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    libzip-dev \
    libicu-dev \
    zip

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql zip intl

# HARD FIX Apache MPM (very important)
RUN a2dismod mpm_event mpm_worker || true
RUN a2enmod mpm_prefork

# Enable rewrite
RUN a2enmod rewrite

# Fix Apache config
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

COPY . /var/www/html/

WORKDIR /var/www/html

# Install composer
RUN curl -sS https://getcomposer.org/installer | php
RUN php composer.phar install

EXPOSE 80
