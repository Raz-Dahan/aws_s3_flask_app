#!/bin/bash

if docker ps | grep razdahan31/aws_s3_flask_app:latest; then
  docker-compose down
fi
docker build -t razdahan31/aws_s3_flask_app:latest
docker-compose up -d