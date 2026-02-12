#!/bin/bash
sudo apt update -y
sudo apt install ufw wget -y
sudo ufw allow 30001:30003/tcp
sudo ufw enable
wget https://download.npool.io/npool.sh && sudo chmod +x npool.sh && sudo ./npool.sh wW8xBLMezohupvC7
