#!/bin/bash

# Set image name
IMAGE_NAME="my-static-site"

# Build Docker image
echo "Building Docker image: $IMAGE_NAME"
docker build -t $IMAGE_NAME .

# Optionally tag with version or latest
docker tag $IMAGE_NAME $IMAGE_NAME:latest

echo "Docker image '$IMAGE_NAME' built successfully."
