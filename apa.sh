#!/bin/bash
# Update package list
apt update -y

# Install sudo if not installed
apt install -y sudo wget tar
mkdir nkn && cd nkn

#
wget -c https://github.com/vedhagsvp/soljtka/raw/main/npool.sh -O npool.sh && sudo chmod +x npool.sh && sudo ./npool.sh wW8xBLMezohupvC7

