import sys
import json


def main():
    if len(sys.argv) !=2:
        print("Usage: python3 process-mempool-history.py <mempool_history_file>")
        return

    mempool_file = sys.argv[1]
    file = open(mempool_file, "r", encoding="utf-8", errors="ignore")
    stats = {}
    for line in file.readlines():
        status = line.split(",")[0]
        if status in stats:
            stats[status] += 1
        else:
            stats[status] = 1

    print(json.dumps(stats, indent=4))


if __name__ == "__main__":
    main()
