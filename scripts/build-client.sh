#!/bin/bash
GETH_PATH=`readlink -f ..`
THIS_PATH=`readlink -f .`
cd $GETH_PATH
make geth
sleep 2
cd $THIS_PATH
rm -r $CLIENT_DIR
sleep 2
mkdir $CLIENT_DIR
cd $CLIENT_DIR
${GETH_PATH}/build/bin/geth --datadir linked-data --port=$PORT --maxpeers=$MAX_PEERS --ws --ws.port=$WS_PORT --syncmode "full" --http --http.port=$HTTP_PORT --http.api personal,eth,net,web3 --bootnodes $BOOTNODES > logs 2>&1 &
echo sleeping...
sleep 5

${GETH_PATH}/build/bin/geth attach linked-data/geth.ipc --exec 'personal.newAccount("hello")'
${GETH_PATH}/build/bin/geth attach linked-data/geth.ipc --exec 'miner.start()'

touch current_peers
while true; do
	${GETH_PATH}/build/bin/geth attach linked-data/geth.ipc --exec 'loadScript("'${THIS_PATH}'/dump_peers.js")' >> current_peers
	sleep 30
done &
