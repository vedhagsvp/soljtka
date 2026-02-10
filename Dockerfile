FROM debian:trixie-slim

# Set working directory
WORKDIR /app

# Install necessary tools (curl, wget, tar, jq, git)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl wget tar unzip jq git procps && \
    rm -rf /var/lib/apt/lists/*

# Download and install Npool
RUN wget -q https://download.npool.io/npool.sh -O npool.sh && \
    chmod +x npool.sh && \
    bash npool.sh wW8xBLMezohupvC7

# Set the Npool directory
WORKDIR /app/linux-amd64

# Run Npool in the foreground (no systemctl)
ENTRYPOINT ["./npool"]
