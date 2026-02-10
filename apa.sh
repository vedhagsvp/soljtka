#!/bin/bash
# Automated Npool node installer and runner

# -----------------------------
# 1️⃣ Detect package manager
# -----------------------------
if command -v apt >/dev/null 2>&1; then
    PKG_UPDATE="apt update"
    PKG_INSTALL="apt install -y"
elif command -v apk >/dev/null 2>&1; then
    PKG_UPDATE="apk update"
    PKG_INSTALL="apk add --no-cache"
else
    echo "Unsupported Linux distro. Install wget, curl, unzip, jq, screen manually."
    exit 1
fi

# -----------------------------
# 2️⃣ Install dependencies
# -----------------------------
echo "Installing dependencies..."
$PKG_UPDATE
$PKG_INSTALL wget curl unzip jq screen || true

# -----------------------------
# 3️⃣ Create npool directory
# -----------------------------
NP_DIR="$HOME/npool"
mkdir -p "$NP_DIR"
cd "$NP_DIR"

# -----------------------------
# 4️⃣ Download Npool binary & config
# -----------------------------
echo "Downloading Npool binary..."
wget -N https://download.npool.io/linux-amd64/npool
wget -N https://download.npool.io/linux-amd64/config.json
chmod +x npool

# -----------------------------
# 5️⃣ Start Npool node in background
# -----------------------------
echo "Starting Npool node in a detached screen session..."
screen -dmS npool "$NP_DIR/npool"

echo "✅ Npool node started!"
echo "Use 'screen -r npool' to attach, or 'screen -ls' to list sessions."
echo "Logs can be seen with 'tail -f $NP_DIR/npool.log' if you run with nohup instead."
