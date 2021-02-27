<div align="center">

# Nginx/PHP-FPM Docker Image

A lightweight combined Nginx/PHP-FPM Docker image.

[![Build Status](https://github.com/Justintime50/nginx-php-docker/workflows/build/badge.svg)](https://github.com/Justintime50/nginx-php-docker/actions)
[![Image Size](https://img.shields.io/docker/image-size/justintime50/nginx-php)](https://hub.docker.com/repository/docker/justintime50/nginx-php)
[![Docker Pulls](https://img.shields.io/docker/pulls/justintime50/nginx-php)](https://hub.docker.com/repository/docker/justintime50/nginx-php)
[![Licence](https://img.shields.io/github/license/justintime50/nginx-php-docker)](LICENSE)

</div>

## Features

The following features work out of the box without any configuration:

* `PHP-FPM` for fast performance
* `Nginx` serves as the web host
* `msmtp` is installed and configured (see `config/msmtprc`) to send mail locally for testing via apps like `Mailcatcher` which will work out of the box (if Mailcatcher container is titled `mailcatcher`) 
* `mysql_pdo` is installed as the driver for database connections
* `gd` is installed for image processing
* `zip` is installed for items that may need that

## Install

```bash
# Dockerfile
FROM: justintime50/nginx-php:latest

# docker-compose
image: justintime50/nginx-php:latest
```

## Usage

Place your site files into `/var/www/html` inside the container to get started with this image. This can be achieved by using a volume in a `docker-compose` file or by copying them in a `Dockerfile`.

Want to give this image a spin? Simply run the following:

```bash
docker-compose up -d
```

## Docker Tags

- `latest` - uses the latest explicitly requested release on the PHP Alpine track.
- `8.0` - uses the latest release on the PHP 8.0 Alpine track.
- `7.4` - uses the latest release on the PHP 7.4 Alpine track.
- `7.3` - uses the latest release on the PHP 7.3 Alpine track. - `Deprecated`
- `7.2` - uses the latest release on the PHP 7.2 Alpine track. - `Deprecated`
- `7.1` - uses the latest release on the PHP 7.1 Alpine track. - `Deprecated`
- `7.0` - uses the latest release on the PHP 7.0 Alpine track. - `Deprecated`
- `dev` - the testing branch for this image. Do not use this tag in production.

## Building New Versions

This image supports swapping in the version number of PHP with a value from the official `PHP-FPM Alpine` [tag list](https://hub.docker.com/_/php).

**Automated Builds**

GitHub Actions will automatically build and push supported tags to the Docker Hub on each new release.

**Manual Builds**

```bash
docker build -t justintime50/nginx-php:8.0 --build-arg VERSION=8.0 .

sudo docker push justintime50/nginx-php:8.0
```
