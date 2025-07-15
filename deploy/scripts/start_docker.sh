#!/bin/bash

# Login to AWS ECR
sudo aws ecr get-login-password --region eu-north-1 | \
sudo docker login --username AWS --password-stdin 888121514404.dkr.ecr.eu-north-1.amazonaws.com

# Pull the Docker image
sudo docker pull 888121514404.dkr.ecr.eu-north-1.amazonaws.com/onway_ecr:v3

# Stop and remove old container
sudo docker stop onway-app || true
sudo docker rm onway-app || true

# Run the Docker container in detached mode
sudo docker run -d -p 80:5000 \
  -e DAGSHUB_PAT=c900d827474e85a0334daa0d446a8218d2b9f611 \
  --name onway-app \
  888121514404.dkr.ecr.eu-north-1.amazonaws.com/onway_ecr:v3
