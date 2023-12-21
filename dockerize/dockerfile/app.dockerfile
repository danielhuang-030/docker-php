FROM php:8.2-fpm-alpine

LABEL maintainer="danielhuang-030"

# Define the versions for Redis and Swoole
ARG REDIS_VERSION=6.0.2
ARG SWOOLE_VERSION=5.1.0

# Install basic dependencies and Node.js/npm
RUN apk update && apk upgrade && \
    apk add --no-cache bash git vim supervisor freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev libzip-dev libwebp-dev curl imagemagick imagemagick-dev build-base nodejs npm

# Download and install mlocati/docker-php-extension-installer script
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions

# Use the script to install PHP extensions
RUN install-php-extensions pdo_mysql bcmath pcntl zip gd imagick redis-$REDIS_VERSION swoole-$SWOOLE_VERSION

# Clean up unnecessary packages and cache to reduce the image size
RUN apk del --purge freetype-dev libpng-dev libjpeg-turbo-dev libzip-dev libwebp-dev imagemagick-dev build-base musl-dev g++ && \
    rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy configuration files
COPY ./dockerize/conf/cron/root /etc/crontabs/root
COPY ./dockerize/conf/supervisord/supervisord.conf /etc/supervisord.conf

# Set the working directory
WORKDIR /var/www/html

# Set the entrypoint
ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
