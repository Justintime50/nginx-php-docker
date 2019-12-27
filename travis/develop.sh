#!/bin/bash

docker-compose up -d --build
docker ps | grep -q nginx-php
