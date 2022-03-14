#!/bin/bash
cd ..
make geth
sleep 2
cd scripts
rm -r cl1
sleep 2
mkdir cl1
cd cl1
../../build/bin/geth --datadir cl1-linked-data --port=30303 --maxpeers=6 --ws --ws.port="8545" --syncmode "full" --http --http.api personal,eth,net,web3 --bootnodes "enode://22a8232c3abc76a16ae9d6c3b164f98775fe226f0917b0ca871128a74a8e9630b458460865bab457221f1d448dd9791d24c4e5d88786180ac185df813a68d4de@3.209.45.79:30303" &
echo sleeping...
sleep 5
touch current_peers
while true; do
	../../build/bin/geth attach cl1-linked-data/geth.ipc --exec 'loadScript("../dump_peers.js")' >> current_peers
	sleep 30
done
