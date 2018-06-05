#!/bin/bash

set -ex

sed -i 's@https://nylira.net@'$RPC_URL'@g' src/store/modules/blockchain.js

yarn build

rm -rf /explorer/dist
cp -r /usr/src/app/dist /explorer
