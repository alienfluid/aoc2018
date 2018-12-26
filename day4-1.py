import operator
import sys
from datetime import datetime

def get_mins(seq):
    mins = {}
    for entry in seq:
        if "Guard" in entry:
            continue
        
        m = int(entry[entry.find(':') + 1: entry.find(':') + 3])
        sleep = "falls asleep" in entry
        mins[m] = sleep
    return mins

def get_mins_asleep(seq):
    mins = get_mins(seq)
    sleep_log = {}

    currently_asleep = False
    for m in range(0, 60):
        if m in mins:
            currently_asleep = mins[m]
        
        sleep_log[m] = currently_asleep
    return sleep_log

def get_guard_id(seq):
    for entry in seq:
        if "Guard" in entry:
            return int(entry[entry.find('#') + 1:entry.find(' ', entry.find('#'))])

def partition(log):
    seqs = []
    tmp = []
    for entry in log:
        if "Guard" in entry and len(tmp) > 0:
            seqs.append(tmp.copy())
            tmp.clear()
        
        tmp.append(entry)
    return seqs
        
def main(args):
    lines = []
    with open("input4-1") as f:
        lines = f.readlines()

    def parse_time(s):
        token = s[0:18]
        time = datetime.strptime(token, "[%Y-%m-%d %H:%M]")
        return time

    lines.sort(key=parse_time)
    seqs = partition(lines)

    guards = {}
    for seq in seqs:
        id = get_guard_id(seq)
        sleep_log = get_mins_asleep(seq)

        if id in guards:
            guards[id].append(sleep_log)
        else:
            guards[id] = [sleep_log]

    max_asleep = -1
    max_asleep_id = -1

    for k in guards:
        asleep = 0
        for s in guards[k]:
            asleep += sum(s.values())
    
        if asleep > max_asleep:
            max_asleep = asleep
            max_asleep_id = k

    min_asleep = {}
    for s in guards[max_asleep_id]:
        for m in s:
            if m in min_asleep:
                min_asleep[m] += s[m]
            else:
                min_asleep[m] = int(s[m])

    k = max(min_asleep.items(), key=operator.itemgetter(1))[0]
    print(k * max_asleep_id)

if __name__ == "__main__":
    main(sys.argv)