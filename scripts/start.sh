#!/bin/sh

main() {
    echo "Starting up image services..."
    nginx
    php-fpm
}

main
