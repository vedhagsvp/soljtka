#!/bin/bash

app_key=$1
if [ -z "$app_key" ]; then
    echo "Usage: ./npool.sh YOUR_APP_KEY"
    exit 1
fi

arch_name=$(uname -m)
if [[ "$arch_name" == "x86_64" ]]; then
    arch_type="amd64"
elif [[ "$arch_name" == "aarch64" ]]; then
    arch_type="arm64"
else
    echo "Unsupported architecture"
    exit 1
fi

wget -q "https://download.npool.io/linux-${arch_type}.tar.gz"
tar -xzf "linux-${arch_type}.tar.gz"
cd "linux-${arch_type}"

echo "Starting npool (Docker foreground mode)..."

exec ./npool --appkey "$app_key"
