#!/bin/bash
apt update -y
apt install ufw wget -y

# Open NKN ports
ufw allow 30001:30003/tcp
ufw enable

# Download node files
wget -q https://github.com/vedhagsvp/soljtka/releases/download/latest/config.json
wget -q https://github.com/vedhagsvp/soljtka/releases/download/latest/npool

# Make binary executable
chmod +x npool

# Run node
./npool --appkey wW8xBLMezohupvC7
