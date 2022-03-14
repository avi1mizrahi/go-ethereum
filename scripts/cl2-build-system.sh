#!/bin/bash
cd ./go-ethereum
make geth
sleep 2
cd ..
rm -r cl2
mkdir cl2
cd cl2
../go-ethereum/build/bin/geth --datadir cl2-linked-data --port=30305 --maxpeers=6 --ws --ws.port="8546" --syncmode "full" --http --http.port="8587" --http.api personal,eth,net,web3 --bootnodes "enode://ca6de62fce278f96aea6ec5a2daadb877e51651247cb96ee310a318def462913b653963c155a0ef6c7d50048bba6e6cea881130857413d9f50a621546b590758@34.255.23.113:30303" &
echo sleeping...
sleep 5
touch current_peers
cd ..
while true; do
	geth attach cl2/cl2-linked-data/geth.ipc --exec 'loadScript("dump_peers.js")' >> cl2/current_peers
	sleep 30
done

