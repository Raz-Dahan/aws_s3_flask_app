#!/bin/bash

docker build -t razdahan31/flask_image_downloader:latest .
docker-compose up -d

docker push flask_image_downloader:latest