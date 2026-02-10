#!/bin/bash
# deploy_nkn_npool_wallet_nonroot.sh
# Installs nPool and starts mining using your wallet address
# Usage: ./deploy_nkn_npool_wallet_nonroot.sh YOUR_APPKEY NKN_WALLET_ADDRESS

set -e

APPKEY="wW8xBLMezohupvC7"
WALLET_ADDR="NKNMHT4h3PbYGWwXuRQBrXmDVKm2uEmxwzyY"
INSTALL_DIR="$HOME/npool"

if [[ -z "$APPKEY" || -z "$WALLET_ADDR" ]]; then
    echo "Usage: $0 YOUR_APPKEY NKN_WALLET_ADDRESS"
    exit 1
fi

# --- Create installation directory ---
mkdir -p "$INSTALL_DIR"

# --- Install dependencies locally ---
echo "Installing dependencies (system-wide install required for some packages)..."
# On non-root systems, you must ensure wget, unzip, jq, curl, git, python3 are already installed
for cmd in wget unzip jq curl git python3; do
    if ! command -v $cmd >/dev/null 2>&1; then
        echo "⚠️  $cmd not found. Please install it manually before proceeding."
    fi
done

# --- Create 2GB swap safely ---
SWAP_FILE="/tmp/npool.swap"
if [ ! -f "$SWAP_FILE" ]; then
    echo "Creating 2GB swap..."
    dd if=/dev/zero of="$SWAP_FILE" bs=1M count=2048
    chmod 600 "$SWAP_FILE"      # fix permissions for mkswap
    mkswap "$SWAP_FILE"
    swapon "$SWAP_FILE"
    swapon -s
fi

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

echo "✅ nPool setup finished!"
echo "You may need to run ./npool.sh manually to start mining as non-root."
echo "Logs will be in the same directory: $INSTALL_DIR/logs/"
