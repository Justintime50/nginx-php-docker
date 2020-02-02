#!/bin/bash

# Build and push all supported docker images to Docker Hub

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker build -t justintime50/nginx-php:7.4 --build-arg VERSION=7.4 .
docker push justintime50/nginx-php:7.4
docker build -t justintime50/nginx-php:7.3 --build-arg VERSION=7.3 .
docker push justintime50/nginx-php:7.3
docker build -t justintime50/nginx-php:7.2 --build-arg VERSION=7.2 .
docker push justintime50/nginx-php:7.2
docker build -t justintime50/nginx-php:7.1 --build-arg VERSION=7.1 .
docker push justintime50/nginx-php:7.1
docker build -t justintime50/nginx-php:7.0 --build-arg VERSION=7.0 .
docker push justintime50/nginx-php:7.0
