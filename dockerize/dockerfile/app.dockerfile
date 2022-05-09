FROM php:8.1-fpm-alpine

LABEL maintainer="danielhuang-030"

RUN apk update \
    && apk upgrade \
    && apk add bash git vim \
    && apk --update add supervisor

RUN docker-php-ext-install pdo_mysql bcmath pcntl

RUN apk add --no-cache freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev libzip-dev libwebp-dev curl && \
  docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp

## install imagick
RUN apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        imagemagick-dev
RUN apk add --update --no-cache --virtual .imagick-runtime-deps imagemagick \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
# install redis
    && pecl install redis \
    && docker-php-ext-enable redis \
# install swoole
    && pecl install swoole \
    && docker-php-ext-enable swoole \
# install zip
    && docker-php-ext-install zip \
# clean up
    && apk del .build-deps \
    && rm -fr /tmp/pear

RUN rm /var/cache/apk/* && \
    mkdir -p /var/www

## install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY ./dockerize/conf/cron/root /etc/crontabs/root
COPY ./dockerize/conf/supervisord/supervisord.conf /etc/supervisord.conf

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
