ARG VERSION=7.4
FROM php:${VERSION}-fpm-alpine

# PHP_CPPFLAGS are used by the docker-php-ext-* scripts
ENV PHP_CPPFLAGS="$PHP_CPPFLAGS"

# Install zip for csv stuff
# hadolint ignore=DL3018
RUN apk add --no-cache \
    libzip-dev \
    zip \
&& docker-php-ext-install zip \
&& apk del libzip-dev

# Install gd for image stuff
# hadolint ignore=DL3018
RUN apk add --no-cache libpng libpng-dev libjpeg-turbo-dev libwebp-dev zlib-dev libxpm-dev \
    && docker-php-ext-install gd \
    && apk del libpng-dev libjpeg-turbo-dev libwebp-dev zlib-dev libxpm-dev

# Install Nginx & PHP packages and extensions
# hadolint ignore=DL3018
RUN apk add --no-cache \
    # for PHP/Laravel
    git \
    icu-dev \
    msmtp \
    nginx \
    unzip \
    # zip \
    && mkdir -p /run/nginx \
    && docker-php-ext-install \
        pdo_mysql \
        opcache \
    && { \
        echo 'opcache.memory_consumption=128'; \
        echo 'opcache.interned_strings_buffer=8'; \
        echo 'opcache.max_accelerated_files=4000'; \
        echo 'opcache.revalidate_freq=2'; \
        echo 'opcache.fast_shutdown=1'; \
        echo 'opcache.enable_cli=1'; \
    } > /usr/local/etc/php/conf.d/php-opocache-cfg.ini \
    && apk del icu-dev

COPY /config/nginx.conf /etc/nginx/conf.d/default.conf
COPY /config/msmtprc /etc/msmtprc
COPY /scripts/start.sh /etc/start.sh
COPY --chown=www-data:www-data src/ /var/www/html

WORKDIR /var/www/html

EXPOSE 80 443

ENTRYPOINT ["/etc/start.sh"]
