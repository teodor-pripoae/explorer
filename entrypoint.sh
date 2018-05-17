#!/bin/bash

set -ex

sed -i 's/138.68.77.24:46657/'$RPC_URL'/g' src/store/modules/blockchain.js

yarn build

rm -rf /explorer/dist
cp -r /usr/src/app/dist /explorer
