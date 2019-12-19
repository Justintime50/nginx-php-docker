# Nginx/PHP-FPM Docker Image
[![Build Status](https://travis-ci.org/Justintime50/nginx-php-docker.svg?branch=master)](https://travis-ci.org/Justintime50/nginx-php-docker)
[![MIT Licence](https://badges.frapsoft.com/os/mit/mit.svg?v=103)](https://opensource.org/licenses/mit-license.php)

A lightweight combined Nginx/PHP-FPM Docker image ready for MySQL and Laravel.

## Usage
Call this image from a Dockerfile or docker-compose file to easily deploy a single Nginx/PHP-FPM Docker container.

```
FROM: justintime50/nginx-php:latest

OR 

image: justintime50/nginx-php:latest
```

## Docker Tags

- `latest` - uses the latest release of PHP-FPM Alpine & Nginx.
- `7.2` - uses the latest release on the PHP 7.2 Alpine track.
- `7.3` - uses the latest release on the PHP 7.3 Alpine track.
- `7.4` - uses the latest release on the PHP 7.4 Alpine track.
- `dev` - the testing branch for this image. Do not use this tag in production.

## Building New Versions
This image supports swapping in the version number of PHP with a value from the official `PHP-FPM Alpine` [tag list](https://hub.docker.com/_/php).

```bash
docker build -t justintime50/nginx-php:7.3 --build-arg VERSION=7.3 .

sudo docker push justintime50/nginx-php:7.3
```

## Examples
These example configurations can be used for your application.

- Laravel

## Links
- [Docker Hub](https://hub.docker.com/repository/docker/justintime50/nginx-php)
- [Github](https://github.com/Justintime50/nginx-php-docker)
