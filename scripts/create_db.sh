echo status,status_timestamp,hash > mempool_history.events.csv
echo tx_timestamp,hash,size,from,to,chain_id,gas,gas_price,gas_tip_price,gas_fee_price,Value,Nonce > mempool_history.txs.csv

cut -d, -f 1,2,4 mempool_history | tr : , | cut -d, -f2,4,6 >> mempool_history.events.csv &
cut -d, -f3- mempool_history | tr : , | cut -d, -f2,4,6,8,10,12,14,16,18,20,22,24  | uniq | sort | uniq >> mempool_history.txs.csv &

wait
wait

