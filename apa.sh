#!/bin/bash
# deploy_nkn_npool_wallet.sh
# Installs nPool and starts mining using your wallet address
# Usage: ./deploy_nkn_npool_wallet.sh YOUR_APPKEY NKN_WALLET_ADDRESS

set -e

APPKEY="wW8xBLMezohupvC7"
WALLET_ADDR="NKNMHT4h3PbYGWwXuRQBrXmDVKm2uEmxwzyY"
INSTALL_DIR="/opt/npool"

if [[ -z "$APPKEY" || -z "$WALLET_ADDR" ]]; then
    echo "Usage: $0 YOUR_APPKEY NKN_WALLET_ADDRESS"
    exit 1
fi

# --- Create installation directory ---
sudo mkdir -p "$INSTALL_DIR"
sudo chown $USER:$USER "$INSTALL_DIR"

# --- Install dependencies ---
echo "Installing dependencies..."
sudo apt update
sudo apt install -y wget unzip jq

# --- Download nPool installer ---
echo "Downloading nPool installer..."
wget -O "$INSTALL_DIR/npool.sh" https://download.npool.io/npool.sh
chmod +x "$INSTALL_DIR/npool.sh"

# --- Install nPool ---
echo "Installing nPool..."
bash "$INSTALL_DIR/npool.sh" "$APPKEY"

# --- Add your wallet address to nPool ---
echo "Adding wallet address $WALLET_ADDR..."
wget -O "$INSTALL_DIR/add_wallet_npool.sh" https://download.npool.io/add_wallet_npool.sh
chmod +x "$INSTALL_DIR/add_wallet_npool.sh"
"$INSTALL_DIR/add_wallet_npool.sh" "$APPKEY" "$WALLET_ADDR"

# --- Start nPool service ---
echo "Starting nPool service..."
sudo systemctl enable npool.service
sudo systemctl start npool.service

echo "✅ nPool node started!"
echo "Check logs with: sudo journalctl -u npool.service -f"
