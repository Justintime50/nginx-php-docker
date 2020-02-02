#!/bin/bash

# Test if all supported tags can be built

# Build supported tags
docker build -t nginx-php:7.4 --build-arg VERSION=7.4 .
docker run -it nginx-php:7.4
docker build -t nginx-php:7.3 --build-arg VERSION=7.3 .
docker run -it nginx-php:7.3
docker build -t nginx-php:7.2 --build-arg VERSION=7.2 .
docker run -it nginx-php:7.2
docker build -t nginx-php:7.1 --build-arg VERSION=7.1 .
docker run -it nginx-php:7.1
docker build -t nginx-php:7.0 --build-arg VERSION=7.0 .
docker run -it nginx-php:7.0

# Check if supported images are running
docker ps | grep -q nginx-php:7.4
docker ps | grep -q nginx-php:7.3
docker ps | grep -q nginx-php:7.2
docker ps | grep -q nginx-php:7.1
docker ps | grep -q nginx-php:7.0
