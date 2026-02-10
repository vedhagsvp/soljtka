#!/bin/bash

# 1️⃣ Create 2GB swap (will fail if you don't have root privileges)
dd if=/dev/zero of=/tmp/swap bs=1M count=2048
mkswap /tmp/swap
swapon /tmp/swap
swapon -s

# 2️⃣ Make a user-writable npool folder
mkdir -p $HOME/npool
cd $HOME/npool

# 3️⃣ Download and install nPool as current user
wget https://download.npool.io/npool.sh
chmod +x npool.sh
./npool.sh wW8xBLMezohupvC7
