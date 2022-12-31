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

- `PHP-FPM/OPcache` for fast performance in the browser and on the CLI
- `Nginx` serves as the web host and reverse proxy
- `msmtp` is installed and configured (see `config/msmtprc`) to send mail locally for testing via apps like `Mailcatcher` which will work out of the box (if Mailcatcher container is titled `mailcatcher`)
- `mysql_pdo` is installed as the driver for database connections
- `gd` is installed for image processing
- `zip` is installed for items that may need that
- `composer` is installed and ready to use to setup all your dependencies

## Platforms

This image offers platform support for the following architectures starting from image version `8`:

- `linux/amd64`
- `linux/arm/v7`
- `linux/arm64`

## Install

```bash
# Dockerfile
FROM: justintime50/nginx-php:latest

# docker-compose
image: justintime50/nginx-php:latest
```

## Usage

### Vanilla PHP and HTML

Place your `PHP` or `HTML` site files into `/var/www/html/public` inside the container to get started with this image. This can be achieved by using a volume in a `docker-compose` file or by copying them over in a `Dockerfile`. If you are using HTML instead of PHP, ensure you remove the `index.php` file so that your `index.html` file can take priority.

### Laravel

Place the root of your laravel project in `/var/www/html` so that the `public` folder of laravel lines up with the directory served by this nginx image (see `examples/laravel` for more details).

Want to give this image a spin? Simply run the following:

```bash
docker compose up -d
```

Once the container spins up, navigate to `http://localhost:8888` in a browser.

## Docker Tags

Tags for this image follow the syntax of `PHP_VERSION-IMAGE_VERSION`; for instance, a valid tag would be `7.4-9` signifying to use PHP v7.4 and the 9th version of this image (nginx config, Dockerfile, etc).

### PHP Versions

- `8.2` - uses the latest release on the PHP 8.2 Alpine track. (Starting with image version `12`)
- `8.1` - uses the latest release on the PHP 8.1 Alpine track. (Starting with image version `9`)
- `8.0` - uses the latest release on the PHP 8.0 Alpine track.
- `7.4` - uses the latest release on the PHP 7.4 Alpine track.

### Image Versions (see CHANGELOG for more details)

- `12`
- `11`
- `10`
- `9`
- `8`
- `7`

### Standalone Tags

- `latest` - uses the latest release of this image with all defaults.
- `dev` - the testing branch for this image. Do not use this tag in production.

## Development

**Note:** Alpine Linux does not keep old versions of packages. This image pins to the relative major version to try staying flexibile. Future builds may need to be altered if packages are no longer offered.

```bash
# Test nginx configuration
nginx -T
```

### Releasing

When releasing this project, cut a new GitHub tag/release that simply iterates the number (eg: 4, 5, 6...). We won't use semver here for simplicity when tagging images.

If you are adding a new PHP version, make sure to add it to the list in the GitHub Workflow files.

### Building New Versions

This image supports swapping in the version number of PHP with a value from the official `PHP-FPM Alpine` [tag list](https://hub.docker.com/_/php).

### Automated Builds

GitHub Actions will automatically build and push supported tags to Docker Hub on each new release. Additionally GitHub Actions will automatically build the `latest` tag on any push to the main branch. It is highly recommended that you use a versioned release of this image to avoid any transient changes introduced in any given `latest` build.

### Manual Builds

```bash
docker build -t justintime50/nginx-php:8.0-7 --build-arg PHP_VERSION=8.0 .

sudo docker push justintime50/nginx-php:8.0-7
```
