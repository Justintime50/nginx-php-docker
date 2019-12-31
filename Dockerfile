ARG VERSION=7.4
FROM php:${VERSION}-fpm-alpine

# PHP_CPPFLAGS are used by the docker-php-ext-* scripts
ENV PHP_CPPFLAGS="$PHP_CPPFLAGS"

# Install Nginx & PHP packages and extensions -- locking versions here creates stale packages quickly so we ignore that in linting
# hadolint ignore=DL3018,DL3019
RUN apk add --update \
        nginx \
        icu-dev \
        git \
        unzip \
        zip \
    && mkdir -p /run/nginx \
    && docker-php-ext-install \
        pdo_mysql \
        opcache \
    && apk del icu-dev \
    && rm -rf /var/cache/apk/* \
    && { \
        echo 'opcache.memory_consumption=128'; \
        echo 'opcache.interned_strings_buffer=8'; \
        echo 'opcache.max_accelerated_files=4000'; \
        echo 'opcache.revalidate_freq=2'; \
        echo 'opcache.fast_shutdown=1'; \
        echo 'opcache.enable_cli=1'; \
    } > /usr/local/etc/php/conf.d/php-opocache-cfg.ini

COPY /conf/nginx.conf /etc/nginx/conf.d/default.conf
COPY /scripts/start.sh /etc/start.sh
COPY --chown=www-data:www-data src/ /var/www/html

WORKDIR /var/www/html

EXPOSE 80 443

ENTRYPOINT ["/etc/start.sh"]
