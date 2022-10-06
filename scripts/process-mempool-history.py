import json


def main():
    file = open("mempool_history_3", "r", encoding="utf-8", errors="ignore")
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
