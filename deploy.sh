#!/bin/bash

# Define variables
IMAGE_NAME="my-static-site"
CONTAINER_NAME="static-site"
PORT=8080

# Stop and remove any existing container
echo "Stopping old container (if any)..."
docker stop $CONTAINER_NAME 2>/dev/null || true
docker rm $CONTAINER_NAME 2>/dev/null || true

# Run the container
echo "Starting new container..."
docker run -d --name $CONTAINER_NAME -p $PORT:80 $IMAGE_NAME

echo "Deployed '$CONTAINER_NAME' on port $PORT"
