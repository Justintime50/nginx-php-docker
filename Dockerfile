ARG PHP_VERSION=8.4
FROM php:${PHP_VERSION}-fpm-alpine

# PHP_CPPFLAGS are used by the docker-php-ext-* scripts
ARG PHP_CPPFLAGS="$PHP_CPPFLAGS"

SHELL ["/bin/ash", "-o", "pipefail", "-c"]

# Install Nginx & PHP packages and extensions
# If a package is not pinned, it's due to transient version needs per PHP version used
# hadolint ignore=DL3018
RUN apk add --no-cache --update \
    # Install packages required by PHP/Laravel
    git~=2 \
    icu-dev \
    nginx~=1 \
    npm \
    unzip~=6 \
    # Install mail server
    msmtp~=1 \
    # Install gd for image functions
    freetype-dev~=2 \
    libjpeg-turbo-dev~=3 \
    libpng-dev~=1 \
    libwebp-dev~=1 \
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
    bcmath \
    gd \
    opcache \
    pdo_mysql \
    zip \
    # Setup Nginx directories, permissions, and one-off configurations
    && mkdir -p /var/run/nginx \
    && chown -R www-data:www-data /var/run/nginx /var/lib/nginx /var/log/nginx \
    && sed -i 's|ssl_protocols TLSv1.1|ssl_protocols|' /etc/nginx/nginx.conf \
    && sed -i 's|user nginx;|#user www-data;|' /etc/nginx/nginx.conf \
    && sed -i 's|user =|;user =|' /usr/local/etc/php-fpm.d/www.conf \
    && sed -i 's|group =|;group =|' /usr/local/etc/php-fpm.d/www.conf \
    # Tune PHP-FPM for more throughput
    && sed -i 's|pm.start_servers = 2|pm.start_servers = 4|' /usr/local/etc/php-fpm.d/www.conf \
    && sed -i 's|pm.min_spare_servers = 1|pm.min_spare_servers = 2|' /usr/local/etc/php-fpm.d/www.conf \
    && sed -i 's|pm.max_spare_servers = 3|pm.max_spare_servers = 8|' /usr/local/etc/php-fpm.d/www.conf \
    && sed -i 's|pm.max_children = 5|pm.max_children = 16|' /usr/local/etc/php-fpm.d/www.conf \
    && sed -i 's|;pm.max_requests = 500|pm.max_requests = 500|' /usr/local/etc/php-fpm.d/www.conf \
    # Enable Nginx stdout/stderr logging, disable php-fpm access logs
    && ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log \
    && echo "access.log = /dev/null" >> /usr/local/etc/php-fpm.d/www.conf \
    # Setup msmtp log
    && touch /var/log/msmtp.log \
    && chown www-data:www-data /var/log/msmtp.log \
    # Install the latest version of Composer
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    # Cleanup
    && rm -rf /var/cache/apk/* /tmp/*

COPY /config/nginx.conf /etc/nginx/http.d/default.conf
COPY /config/opcache.ini /usr/local/etc/php/conf.d/php-opocache-cfg.ini
COPY /config/msmtp.ini /usr/local/etc/php/conf.d/php-msmtp-cfg.ini
COPY /config/msmtprc /etc/msmtprc
COPY /scripts/start.sh /etc/start.sh
COPY --chown=www-data:www-data src/ /var/www/html/public

WORKDIR /var/www/html

EXPOSE 80 443

USER www-data:www-data

ENTRYPOINT ["/etc/start.sh"]
