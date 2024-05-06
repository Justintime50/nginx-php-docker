FROM justintime50/nginx-php:8.3-18

COPY --chown=www-data:www-data ./src /var/www/html

RUN composer install -q --no-ansi --no-interaction --no-scripts --no-plugins --no-progress --prefer-dist --optimize-autoloader --no-dev \
    # Setup Laravel
    && php artisan storage:link \
    && php artisan optimize:clear
