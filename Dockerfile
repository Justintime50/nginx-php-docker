ARG PHP_VERSION=8.0
FROM php:${PHP_VERSION}-fpm-alpine

# PHP_CPPFLAGS are used by the docker-php-ext-* scripts
ARG PHP_CPPFLAGS="$PHP_CPPFLAGS"

SHELL ["/bin/ash", "-o", "pipefail", "-c"]

# Install Nginx & PHP packages and extensions
RUN apk add --no-cache \
    # Install packages required by PHP/Laravel
    git~=2 \
    icu-dev~=67 \
    nginx~=1 \
    unzip~=6 \
    # Install mail server
    msmtp~=1 \
    # Install gd for image functions
    freetype-dev~=2 \
    libwebp-dev~=1 \
    libjpeg-turbo-dev~=2 \
    libpng-dev~=1 \
    # Install zip for csv functions
    libzip-dev~=1 \
    zip~=3 \
    # Configure image library
    && docker-php-ext-configure gd \
    --with-jpeg \
    --with-webp \
    --with-freetype \
    # Configure PHP extensions for use in Docker
    && docker-php-ext-install \
    pdo_mysql \
    opcache \
    zip \
    gd \
    # Setup Nginx directory
    && mkdir -p /run/nginx \
    # Install the latest version of Composer
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    # Clear apk cache to reduce file size and clutter
    && rm -rf /var/cache/apk/*

COPY /config/nginx.conf /etc/nginx/http.d/default.conf
COPY /config/opcache.ini /usr/local/etc/php/conf.d/php-opocache-cfg.ini
COPY /config/msmtprc /etc/msmtprc
COPY /scripts/start.sh /etc/start.sh
COPY --chown=www-data:www-data src/ /var/www/html

WORKDIR /var/www/html

EXPOSE 80 443

ENTRYPOINT ["/etc/start.sh"]
