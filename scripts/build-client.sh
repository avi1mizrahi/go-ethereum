#!/bin/bash
cd ..
make geth
sleep 2
cd scripts
rm -r $CLIENT_DIR
sleep 2
mkdir $CLIENT_DIR
cd $CLIENT_DIR
../../build/bin/geth --datadir linked-data --port=$PORT --maxpeers=$MAX_PEERS --ws --ws.port=$WS_PORT --syncmode "full" --http --http.port=$HTTP_PORT --http.api personal,eth,net,web3 --bootnodes $BOOTNODES > logs 2>&1 &
echo sleeping...
sleep 5

../../build/bin/geth attach linked-data/geth.ipc --exec 'personal.newAccount("hello")'
../../build/bin/geth attach linked-data/geth.ipc --exec 'miner.start()'

touch current_peers
while true; do
	../../build/bin/geth attach linked-data/geth.ipc --exec 'loadScript("../dump_peers.js")' >> current_peers
	sleep 30
done &
