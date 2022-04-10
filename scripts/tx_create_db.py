import sys
import json

def main():
    if len(sys.argv) !=2:
        print("Usage: python3 tx_create_db.py <mempool_file>")
        return

    mempool_file = sys.argv[1]
    tx_db = {}
    file = open(mempool_file, "r", encoding="utf-8", errors="ignore")
    count = 0
    for line in file.readlines():
        count+=1
        # print(count)
        if count == 541328:
            print(json.dumps(tx_db, indent=4))
            return
        line = line[:-2]
        tx = dict((key.strip(), value.strip()) for key, value in (element.split(':') for element in line.split(',')))
        tx['status'] = {tx['status_timestamp']: tx['status']}
        tx.pop('status_timestamp')
        if tx['hash'] not in tx_db:
            tx_db[tx['hash']] = tx
        else:
            tx_db[tx['hash']]['status'][list(tx['status'].keys())[0]] = list(tx['status'].values())[0]

    print(json.dumps(tx_db, indent=4))


if __name__ == "__main__":
    main()
