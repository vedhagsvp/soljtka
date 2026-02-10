#!/bin/bash
# deploy_nkn_npool_wallet.sh
# Installs nPool and starts mining using your wallet address
# Usage: ./deploy_nkn_npool_wallet.sh

set -e

APPKEY="wW8xBLMezohupvC7"
WALLET_ADDR="NKNMHT4h3PbYGWwXuRQBrXmDVKm2uEmxwzyY"
INSTALL_DIR="$HOME/npool"             # changed to home directory to avoid sudo
BIN_DIR="$INSTALL_DIR/linux-amd64"

echo "🚀 Starting nPool deployment..."

# --- Create installation directories ---
mkdir -p "$BIN_DIR"

# --- Install dependencies ---
echo "📦 Installing dependencies..."
apt update
apt install -y wget unzip jq curl git

# --- Download nPool installer ---
echo "⬇️ Downloading nPool installer..."
wget -O "$INSTALL_DIR/npool.sh" https://download.npool.io/npool.sh
chmod +x "$INSTALL_DIR/npool.sh"

# --- Install nPool ---
echo "⚙️ Installing nPool..."
bash "$INSTALL_DIR/npool.sh" "$APPKEY"

# --- Ensure linux-amd64 folder exists ---
mkdir -p "$BIN_DIR"

# --- Download wallet script ---
echo "⬇️ Downloading wallet script..."
wget -O "$INSTALL_DIR/add_wallet_npool.sh" https://download.npool.io/add_wallet_npool.sh
chmod +x "$INSTALL_DIR/add_wallet_npool.sh"

# --- Add wallet ---
echo "💰 Adding wallet $WALLET_ADDR..."
bash "$INSTALL_DIR/add_wallet_npool.sh" "$APPKEY" "$WALLET_ADDR"

echo "✅ nPool installation complete!"
echo "nPool directory: $BIN_DIR"
echo "You can start mining using the nPool binary inside $BIN_DIR"
