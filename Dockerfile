ARG VERSION=7.4
FROM php:${VERSION}-fpm-alpine

# PHP_CPPFLAGS are used by the docker-php-ext-* scripts
ENV PHP_CPPFLAGS="$PHP_CPPFLAGS"

# Install Nginx & PHP packages and extensions -- locking versions here creates stale packages quickly so we ignore that in linting
# hadolint ignore=DL3018,DL3019
RUN apk add --no-cache \
        git \
        icu-dev \
        msmtp \
        nginx \
        unzip \
        zip \
    && mkdir -p /run/nginx \
    && docker-php-ext-install \
        pdo_mysql \
        opcache \
    && apk del icu-dev

COPY /config/php-opcache-cfg.ini /usr/local/etc/php/conf.d/php-opocache-cfg.ini
COPY /config/nginx.conf /etc/nginx/conf.d/default.conf
COPY /config/msmtprc /etc/msmtprc
COPY /scripts/start.sh /etc/start.sh
COPY --chown=www-data:www-data src/ /var/www/html

WORKDIR /var/www/html

EXPOSE 80 443

ENTRYPOINT ["/etc/start.sh"]
