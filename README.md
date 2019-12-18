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

## Tags

- `latest` - uses the latest release of PHP-FPM Alpine & Nginx
- `dev` - the testing branch of this image. Don't use this tag in production.

## Examples
These example configurations can be used for your application.

- Laravel

## Links
- [Docker Hub](https://hub.docker.com/repository/docker/justintime50/nginx-php)
- [Github](https://github.com/Justintime50/nginx-php-docker)
