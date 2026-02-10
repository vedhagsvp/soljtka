#!/bin/bash
set -e

APPKEY="wW8xBLMezohupvC7"
WALLET_ADDR="NKNMHT4h3PbYGWwXuRQBrXmDVKm2uEmxwzyY"
INSTALL_DIR="$HOME/npool"

# Install dependencies
apt update
apt install -y wget unzip jq curl git python3

# Prepare folders
mkdir -p "$INSTALL_DIR"
mkdir -p "$INSTALL_DIR/linux-amd64"

# Download nPool installer
wget -O "$INSTALL_DIR/npool.sh" https://download.npool.io/npool.sh
chmod +x "$INSTALL_DIR/npool.sh"

# Install nPool
bash "$INSTALL_DIR/npool.sh" "$APPKEY"

# Download wallet add script
wget -O "$INSTALL_DIR/add_wallet_npool.sh" https://download.npool.io/add_wallet_npool.sh
chmod +x "$INSTALL_DIR/add_wallet_npool.sh"

# Add your wallet
"$INSTALL_DIR/add_wallet_npool.sh" "$APPKEY" "$WALLET_ADDR"

# Start mining manually
cd "$INSTALL_DIR/linux-amd64"
./npool &
echo "✅ nPool node started!"
