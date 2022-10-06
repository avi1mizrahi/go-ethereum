#!/bin/bash
docker container rm eth_client_2
sleep 2
docker build -t eth_client:0.1 .
sleep 2
docker run -it --name=eth_client_2 -v /Users/shahlarobert/Documents/linked-data:/root/.ethereum \
  -v /Users/shahlarobert/Documents/masters/236340-networking-ethereum-project/go-ethereum/mempool_history:/go-ethereum/mempool_history eth_client:0.1
