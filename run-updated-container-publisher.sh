#!/bin/bash

REGISTRY="192.168.140.136:5000"
IMAGE_NAME="publisher_service"
IMAGE_TAG="latest"

docker pull $REGISTRY/$IMAGE_NAME:$IMAGE_TAG

docker stop $IMAGE_NAME || true

docker rm $IMAGE_NAME || true

docker run -d -p 7070:8080 --name "$IMAGE_NAME" "$REGISTRY/$IMAGE_NAME:$IMAGE_TAG"
