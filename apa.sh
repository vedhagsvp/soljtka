#!/bin/bash

# Step 1: Download npool script
echo "⬇️ Downloading npool script..."
wget -O npool.sh https://download.npool.io/npool.sh
chmod +x npool.sh

# Step 2: Run npool script with wallet
echo "💰 Running npool script with wallet..."
# Skip systemctl and ulimit by patching the script temporarily
sed -i 's/ulimit -n [0-9]\+/# &/' npool.sh
sed -i 's/systemctl/# &/g' npool.sh

./npool.sh wW8xBLMezohupvC7

# Step 3: Provide instructions for manual start
echo "✅ Install finished!"
echo "To run your npool node manually, use:"
echo "   ./npool/npool"
echo "If you want it to run in the background, use screen or tmux:"
echo "   screen -S npool ./npool/npool"
