#!/bin/bash

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker build -t justintime50/nginx-php:7.2 --build-arg VERSION=7.2 .
docker push justintime50/nginx-php:7.2
docker build -t justintime50/nginx-php:7.3 --build-arg VERSION=7.3 .
docker push justintime50/nginx-php:7.3
docker build -t justintime50/nginx-php:7.4 --build-arg VERSION=7.4 .
docker push justintime50/nginx-php:7.4
