#!/bin/bash
# deploy_nkn_npool_wallet.sh
# Installs nPool and starts mining using your wallet address
# Usage: ./deploy_nkn_npool_wallet.sh

set -e

APPKEY="wW8xBLMezohupvC7"
WALLET_ADDR="NKNMHT4h3PbYGWwXuRQBrXmDVKm2uEmxwzyY"
INSTALL_DIR="$HOME/npool"   # install in your home folder

echo "📦 Installing dependencies..."
# Update & install dependencies
apt update
apt install -y wget unzip jq curl git python3

# Create installation folder
mkdir -p "$INSTALL_DIR"

# Download nPool installer
echo "⬇️ Downloading nPool installer..."
wget -O "$INSTALL_DIR/npool.sh" https://download.npool.io/npool.sh
chmod +x "$INSTALL_DIR/npool.sh"

# Run nPool installer
echo "⚙️ Installing nPool..."
bash "$INSTALL_DIR/npool.sh" "$APPKEY"

# Ensure linux-amd64 folder exists
if [ ! -d "$INSTALL_DIR/linux-amd64" ]; then
    mkdir -p "$INSTALL_DIR/linux-amd64"
fi

# Add wallet
echo "💰 Adding wallet $WALLET_ADDR..."
wget -O "$INSTALL_DIR/add_wallet_npool.sh" https://download.npool.io/add_wallet_npool.sh
chmod +x "$INSTALL_DIR/add_wallet_npool.sh"
"$INSTALL_DIR/add_wallet_npool.sh" "$APPKEY" "$WALLET_ADDR"

# Start nPool manually
echo "🚀 Starting nPool node..."
cd "$INSTALL_DIR/linux-amd64"
./npool &   # run in background

echo "✅ nPool node started!"
echo "Logs are printed in the terminal. To stop: kill the process manually."
