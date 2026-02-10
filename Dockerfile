FROM python:3.9-slim

WORKDIR /

# Install required system packages
RUN apt update && \
    apt install -y curl wget git libicu-dev unzip jq sudo && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# Create a non-root user to run npool/trainer safely
RUN useradd -m appuser
USER appuser
WORKDIR /home/appuser

# Copy trainer code
COPY trainer /home/appuser/trainer

# Make entrypoint
ENTRYPOINT ["python", "-m", "trainer.task"]
