<div align="center">

# Nginx/PHP-FPM Docker Image

A lightweight combined Nginx/PHP-FPM Docker image.

[![Build Status](https://travis-ci.com/Justintime50/nginx-php-docker.svg?branch=master)](https://travis-ci.com/Justintime50/nginx-php-docker)
[![Docker Version](https://img.shields.io/docker/v/justintime50/nginx-php)](https://hub.docker.com/repository/docker/justintime50/nginx-php)
[![Image Size](https://img.shields.io/docker/image-size/justintime50/nginx-php)](https://hub.docker.com/repository/docker/justintime50/nginx-php)
[![Docker Pulls](https://img.shields.io/docker/pulls/justintime50/nginx-php)](https://hub.docker.com/repository/docker/justintime50/nginx-php)
[![Licence](https://img.shields.io/github/license/justintime50/nginx-php-docker)](LICENSE)

</div>

This image has `msmtp` installed and configured `config/msmtprc` to send mail locally for testing via apps like `Mailcatcher` which will work out of the box (if Mailcatcher container is titled `mailcatcher`).  This image also has `mysql_pdo` enabled to use with a database. There is a sample `nginx.conf` file in the `config` folder. `GD` is enabled for image processing and `zip` is installed for items that may need that.

## Usage

```bash
# Dockerfile usage
FROM: justintime50/nginx-php:latest

# docker-compose usage
image: justintime50/nginx-php:latest
```

## Docker Tags

This image is intended to be used with recent PHP tags. Some packages may not install properly on anything `< 7.3`.

- `latest` - uses the latest explicitly requested release on the PHP Alpine track.
- `7.4` - uses the latest release on the PHP 7.4 Alpine track.
- `7.3` - uses the latest release on the PHP 7.3 Alpine track.
- `7.2` - uses the latest release on the PHP 7.2 Alpine track.
- `7.1` - uses the latest release on the PHP 7.1 Alpine track. - `Deprecated`
- `7.0` - uses the latest release on the PHP 7.0 Alpine track. - `Deprecated`
- `dev` - the testing branch for this image. Do not use this tag in production.

## Building New Versions
This image supports swapping in the version number of PHP with a value from the official `PHP-FPM Alpine` [tag list](https://hub.docker.com/_/php).

**Automated Builds**

Travis CI will automatically build and push supported tags to the Docker Hub on each new commit to master.

**Manual Builds**

```bash
docker build -t justintime50/nginx-php:7.3 --build-arg VERSION=7.3 .

sudo docker push justintime50/nginx-php:7.3
```

## Examples
These example configurations can be used for your application.

- [Laravel](/examples/laravel)
