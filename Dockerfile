FROM python:3.9-slim

# Set working directory
WORKDIR /home/appuser

# Install dependencies
RUN apt update && \
    apt install -y curl wget git libicu-dev unzip jq screen && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Create a non-root user
RUN useradd -m appuser
USER appuser

# Copy trainer code
COPY trainer /home/appuser/trainer

# Download npool installer and node
RUN mkdir -p npool && \
    wget -O /home/appuser/npool/npool.sh https://download.npool.io/npool.sh && \
    chmod +x /home/appuser/npool/npool.sh

# Expose npool default ports (if needed)
EXPOSE 30001 30002

# Entrypoint runs trainer and npool
ENTRYPOINT ["python", "-m", "trainer.task"]
