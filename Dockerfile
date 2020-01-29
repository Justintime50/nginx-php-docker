ARG VERSION=7.4
FROM php:${VERSION}-fpm-alpine

# PHP_CPPFLAGS are used by the docker-php-ext-* scripts
ENV PHP_CPPFLAGS="$PHP_CPPFLAGS"

# Install Nginx & PHP packages and extensions -- locking versions here creates stale packages quickly so we ignore that in linting
# hadolint ignore=DL3018,DL3019
RUN apk add --no-cache \
        # for PHP/Laravel
        git \
        icu-dev \
        msmtp \
        nginx \
        unzip \
        zip \
        # for gd
        freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev \
        && docker-php-ext-configure gd \
            --with-gd \
            --with-freetype-dir=/usr/include/ \
            --with-png-dir=/usr/include/ \
            --with-jpeg-dir=/usr/include/ \
        && NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
        && docker-php-ext-install -j${NPROC} gd  \
        && apk del --no-cache freetype-dev libpng-dev libjpeg-turbo-dev \
    && mkdir -p /run/nginx \
    && docker-php-ext-install \
        gd \
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
