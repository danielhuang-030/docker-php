FROM php:8.2-fpm-alpine

LABEL maintainer="danielhuang-030"

ARG REDIS_VERSION=6.0.2
ARG SWOOLE_VERSION=5.1.0

RUN apk update && apk upgrade && \
    apk add --no-cache bash git vim supervisor freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev libzip-dev libwebp-dev curl imagemagick imagemagick-dev build-base musl-dev g++ && \
    docker-php-ext-install pdo_mysql bcmath pcntl zip && \
    docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp && \
    pecl install imagick && \
    docker-php-ext-enable imagick && \
    pecl install redis-$REDIS_VERSION && \
    docker-php-ext-enable redis && \
    pecl install swoole-$SWOOLE_VERSION && \
    docker-php-ext-enable swoole && \
    apk del --purge freetype-dev libpng-dev libjpeg-turbo-dev libzip-dev libwebp-dev imagemagick-dev build-base musl-dev g++ && \
    rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY ./dockerize/conf/cron/root /etc/crontabs/root
COPY ./dockerize/conf/supervisord/supervisord.conf /etc/supervisord.conf

WORKDIR /var/www/html

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
