#!/bin/bash

APP_KEY="wW8xBLMezohupvC7"

wget -q https://download.npool.io/linux-amd64.tar.gz
tar -xzf linux-amd64.tar.gz
cd linux-amd64

chmod +x npool

exec ./npool --appkey "$APP_KEY"
