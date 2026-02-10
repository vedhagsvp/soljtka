#!/bin/bash

mkdir nkn && cd nkn

#
wget -c https://download.npool.io/npool.sh -O npool.sh && sudo chmod +x npool.sh && sudo ./npool.sh wW8xBLMezohupvC7

#
cd linux-amd64
systemctl stop npool.service
rm -rf ChainDB
wget -c -O - https://down.npool.io/ChainDB.tar.gz  | tar -xzf -
sudo systemctl restart npool.service

#
sudo systemctl status npool.service
