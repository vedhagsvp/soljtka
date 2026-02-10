# Use a slim Python base
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl wget git unzip make jq libicu-dev ufw iptables procps && \
    rm -rf /var/lib/apt/lists/*

# Download and install Npool (without sudo/systemctl)
RUN mkdir -p /app/npool && cd /app/npool && \
    wget -q https://download.npool.io/npool.sh -O npool.sh && \
    chmod +x npool.sh && \
    ./npool.sh wW8xBLMezohupvC7

# Copy your trainer code
COPY trainer /app/trainer

# Create a directory for Npool data
RUN mkdir -p /app/npool_data

# Set entrypoint to run Npool and your trainer
ENTRYPOINT ["bash", "-c", "cd /app/npool/linux-amd64 && ./npool --datadir /app/npool_data & python -m trainer.task"]
