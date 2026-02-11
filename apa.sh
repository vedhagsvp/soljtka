#!/bin/bash

APP_KEY="wW8xBLMezohupvC7"
IMAGE="pavankumarbalim/nkmans:latest"

# Pull the image if not present
!udocker --allow-root pull $IMAGE

# Create container if not exists
if ! !udocker --allow-root ps -a | grep -q nkmans-container; then
    !udocker --allow-root create --name=nkmans-container $IMAGE
fi

# Run the container in foreground
echo "Starting npool in udocker container..."
!udocker --allow-root run nkmans-container \
    ./npool --appkey "$APP_KEY"
