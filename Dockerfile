ARG VERSION=7.4
FROM php:${VERSION}-fpm-alpine

# Install Nginx
RUN apk update \
    && apk add --no-cache nginx

# PHP_CPPFLAGS are used by the docker-php-ext-* scripts
ENV PHP_CPPFLAGS="$PHP_CPPFLAGS"

# Install PHP packages and extensions
RUN apk add --no-cache icu-dev openssl git unzip zip \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl opcache \
    && apk del icu-dev
    
RUN { \
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

CMD ["/etc/start.sh"]
