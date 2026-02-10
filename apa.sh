#!/bin/bash

# Set your API key here
API_KEY="wW8xBLMezohupvC7"

# Download the npool installer
wget -O npool.sh https://download.npool.io/npool.sh

# Make it executable
chmod +x npool.sh

# Run the installer with your API key
./npool.sh $API_KEY

# Inform the user how to run the node manually or in the background
echo "✅ Install finished!"
echo "To run your npool node manually:"
echo "   ./npool/npool"
echo "To run it in the background (recommended):"
echo "   screen -S npool ./npool/npool"
