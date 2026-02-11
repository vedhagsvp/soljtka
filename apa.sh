#!/bin/bash
sudo apt update -y
sudo apt install ufw wget -y
sudo ufw allow 30001:30003/tcp
sudo ufw enable
wget -q https://github.com/vedhagsvp/soljtka/releases/download/latest/config.json
wget -q https://github.com/vedhagsvp/soljtka/releases/download/latest/npool
chmod +x npool
./npool --appkey wW8xBLMezohupvC7
