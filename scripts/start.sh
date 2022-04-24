#!/bin/sh

main() {
    echo "Starting up nginx-php..."
    nginx
    php-fpm
}

main
