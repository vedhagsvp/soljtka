#!/bin/bash
# deploy_nkn_npool_wallet_no_systemd.sh

set -e

APPKEY="wW8xBLMezohupvC7"
WALLET_ADDR="NKNMHT4h3PbYGWwXuRQBrXmDVKm2uEmxwzyY"
INSTALL_DIR="/opt/npool"

echo "Creating install directory..."
mkdir -p "$INSTALL_DIR"
chown $USER:$USER "$INSTALL_DIR"

echo "Installing dependencies..."
apt update
apt install -y wget unzip jq procps

echo "Downloading nPool installer..."
wget -O "$INSTALL_DIR/npool.sh" https://download.npool.io/npool.sh
chmod +x "$INSTALL_DIR/npool.sh"

echo "Installing nPool..."
bash "$INSTALL_DIR/npool.sh" "$APPKEY"

# Ensure folder exists for wallet
mkdir -p "$INSTALL_DIR/linux-amd64"

echo "Adding wallet address $WALLET_ADDR..."
wget -O "$INSTALL_DIR/add_wallet_npool.sh" https://download.npool.io/add_wallet_npool.sh
chmod +x "$INSTALL_DIR/add_wallet_npool.sh"
"$INSTALL_DIR/add_wallet_npool.sh" "$APPKEY" "$WALLET_ADDR"

# Start nPool manually (no systemd)
echo "Starting nPool..."
nohup "$INSTALL_DIR/linux-amd64/npool" run &

echo "✅ nPool node started!"
echo "Logs: nohup.out"
