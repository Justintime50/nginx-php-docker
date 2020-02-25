ARG VERSION=7.4
FROM php:${VERSION}-fpm-alpine

# PHP_CPPFLAGS are used by the docker-php-ext-* scripts
ENV PHP_CPPFLAGS="$PHP_CPPFLAGS"

# Install Nginx & PHP packages and extensions
# hadolint ignore=DL3018
RUN apk add --no-cache \
        # Install mail server
        msmtp \
        # for PHP/Laravel
        git \
        icu-dev \
        nginx \
        unzip \
        # Install gd for image stuff
        freetype-dev \
        libwebp-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        # Install zip for csv stuff
        libzip-dev \
        zip \
    && docker-php-ext-configure gd \
        --with-jpeg=/usr/include \
        --with-webp=/usr/include \
        --with-freetype=/usr/include \
    && docker-php-ext-install \
        pdo_mysql \
        opcache \
        zip \
        gd \
    && { \
        echo 'opcache.memory_consumption=128'; \
        echo 'opcache.interned_strings_buffer=8'; \
        echo 'opcache.max_accelerated_files=4000'; \
        echo 'opcache.revalidate_freq=2'; \
        echo 'opcache.fast_shutdown=1'; \
        echo 'opcache.enable_cli=1'; \
    } > /usr/local/etc/php/conf.d/php-opocache-cfg.ini \
    && mkdir -p /run/nginx  

COPY /config/nginx.conf /etc/nginx/conf.d/default.conf
COPY /config/msmtprc /etc/msmtprc
COPY /scripts/start.sh /etc/start.sh
COPY --chown=www-data:www-data src/ /var/www/html

WORKDIR /var/www/html

EXPOSE 80 443

ENTRYPOINT ["/etc/start.sh"]
