# Base Python slim image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Install essential tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl wget git tar unzip jq procps && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy your trainer folder into container
COPY trainer /app/trainer

# Set Python module to run
ENTRYPOINT ["python", "-m", "trainer.task"]
