#!/bin/bash
# login to AWS ECR

aws ecr get-login-password --region eu-north-1 | docker login --username AWS --password-stdin 888121514404.dkr.ecr.eu-north-1.amazonaws.com
docker pull 888121514404.dkr.ecr.eu-north-1.amazonaws.com/onway_ecr:v3
docker stop my-container || true
docker rm my-container || true
docker run -p 80:5000 -e DAGSHUB_PAT=c900d827474e85a0334daa0d446a8218d2b9f611 --name onway-app 888121514404.dkr.ecr.eu-north-1.amazonaws.com/onway_ecr:v3

