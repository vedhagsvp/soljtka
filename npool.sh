#!/bin/bash

# Check appKey
app_key=$1
if [ -z "$app_key" ]; then
    echo "Usage: bash npool.sh YOUR_APP_KEY"
    exit 1
fi

# Detect architecture
arch_name=$(uname -m)
if [[ "$arch_name" == "x86_64" ]]; then
    arch_type="amd64"
elif [[ "$arch_name" == "aarch64" ]]; then
    arch_type="arm64"
else
    echo "Unsupported architecture: $arch_name"
    exit 1
fi

echo "Downloading npool for $arch_type..."

wget -q "https://download.npool.io/linux-${arch_type}.tar.gz" || {
    echo "Download failed"
    exit 1
}

tar -xzf "linux-${arch_type}.tar.gz" || {
    echo "Extraction failed"
    exit 1
}

cd "linux-${arch_type}" || exit 1

echo "Starting npool..."

nohup ./npool --appkey "$app_key" > npool.log 2>&1 &

echo "Npool started in background."
echo "Logs: linux-${arch_type}/npool.log"
