ARG PHP_VERSION=8.4
FROM php:${PHP_VERSION}-fpm-alpine

# PHP_CPPFLAGS are used by the docker-php-ext-* scripts
ARG PHP_CPPFLAGS="$PHP_CPPFLAGS"

SHELL ["/bin/ash", "-o", "pipefail", "-c"]

# Install Nginx & PHP packages and extensions
# If a package is not pinned, it's due to transient version needs per PHP version used
# hadolint ignore=DL3018
RUN apk add --no-cache --update \
    # Install nginx to serve the application
    nginx~=1 \
    # Install supervisor to run processes
    supervisor~=4 \
    # Install Laravel dependencies
    icu-dev \
    # Install JS dependencies
    nodejs~=22 \
    npm \
    # Install mail server
    msmtp~=1 \
    # Install gd for image functionality
    freetype~=2 \
    freetype-dev~=2 \
    libjpeg-turbo~=3 \
    libjpeg-turbo-dev~=3 \
    libpng~=1 \
    libpng-dev~=1 \
    libwebp~=1 \
    libwebp-dev~=1 \
    # Install zip for csv functionality
    libzip~=1 \
    libzip-dev~=1 \
    zlib~=1 \
    zlib-dev~=1 \
    zip~=3 \
    # Install Redis
    autoconf \
    gcc \
    g++ \
    make \
    libc-dev \
    && pecl install \
        redis \
    && docker-php-ext-enable \
        redis \
    # Configure image library
    && docker-php-ext-configure gd \
        --with-jpeg \
        --with-webp \
        --with-freetype \
    # Configure PHP extensions for use in Docker
    && docker-php-ext-install \
        bcmath \
        gd \
        intl \
        opcache \
        pdo_mysql \
        zip \
    # Remove dev packages once we're done using them
    && apk del \
        autoconf \
        freetype-dev \
        g++ \
        gcc \
        icu-dev \
        libc-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        libwebp-dev \
        libzip-dev \
        make \
    # Cleanup apk add
    && rm -rf /var/cache/apk/* /tmp/* \
    # Setup directories and permissions
    && mkdir -p /var/run/nginx /var/run/php-fpm \
    && chown -R www-data:www-data /var/run/nginx /var/run/php-fpm /var/lib/nginx /var/log/nginx \
    # Fix Nginx configuration
    && sed -i 's|ssl_protocols TLSv1.1|ssl_protocols|' /etc/nginx/nginx.conf \
    && sed -i 's|user nginx;|#user www-data;|' /etc/nginx/nginx.conf \
    # Setup supervisord log
    && touch /var/log/supervisord.log \
    && chown www-data:www-data /var/log/supervisord.log \
    # Enable Nginx stdout/stderr logging so Docker can see them
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log \
    # Setup msmtp log
    && touch /var/log/msmtp.log \
    && chown www-data:www-data /var/log/msmtp.log \
    # Install the latest version of Composer
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY config/nginx.conf /etc/nginx/http.d/default.conf
COPY config/php-fpm.conf /usr/local/etc/php-fpm.d/zz-docker.conf
COPY config/opcache.ini /usr/local/etc/php/conf.d/php-opocache-cfg.ini
COPY config/supervisord.conf /etc/supervisord.conf
COPY config/msmtp.ini /usr/local/etc/php/conf.d/php-msmtp-cfg.ini
COPY config/msmtprc /etc/msmtprc
COPY --chown=www-data:www-data src/ /var/www/html/public

WORKDIR /var/www/html

EXPOSE 80 443

USER www-data:www-data

ENTRYPOINT ["supervisord", "-c", "/etc/supervisord.conf"]
