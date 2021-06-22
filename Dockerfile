ARG VERSION=8.0
FROM php:${VERSION}-fpm-alpine

# PHP_CPPFLAGS are used by the docker-php-ext-* scripts
ARG PHP_CPPFLAGS="$PHP_CPPFLAGS"

SHELL ["/bin/ash", "-o", "pipefail", "-c"]

# Install Nginx & PHP packages and extensions
# hadolint ignore=DL3018
RUN apk add --no-cache \
    # Install packages required by PHP/Laravel
    git \
    icu-dev \
    nginx \
    unzip \
    # Install mail server
    msmtp \
    # Install gd for image functions
    freetype-dev \
    libwebp-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    # Install zip for csv functions
    libzip-dev \
    zip \
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
    # Configure OPcache for FPM PHP
    && { \
    echo 'opcache.enable_cli=1'; \
    echo 'opcache.memory_consumption=256'; \
    echo 'opcache.interned_strings_buffer=32'; \
    echo 'opcache.max_accelerated_files=20000'; \
    echo 'opcache.max_wasted_percentage=10'; \
    # we compromise some performance gains here by allowing cache-invalidation for dev projects via revalidate_freq
    echo 'opcache.revalidate_freq=2'; \
    echo 'opcache.fast_shutdown=1'; \
    } > /usr/local/etc/php/conf.d/php-opocache-cfg.ini \
    # Setup Nginx directory
    && mkdir -p /run/nginx \
    # Install Composer
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY /config/nginx.conf /etc/nginx/conf.d/default.conf
COPY /config/msmtprc /etc/msmtprc
COPY /scripts/start.sh /etc/start.sh
COPY --chown=www-data:www-data src/ /var/www/html

WORKDIR /var/www/html

EXPOSE 80 443

ENTRYPOINT ["/etc/start.sh"]
