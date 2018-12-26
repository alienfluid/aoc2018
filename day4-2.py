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

    new_guards = {}
    for guard in guards:
        mp = {}
        for s in guards[guard]:
            for k in s:
                if k in mp:
                    mp[k] += s[k]
                else:
                    mp[k] = int(s[k])
        new_guards[guard] = mp

    max_min_val = -1
    max_min_id = -1
    max_min_gid = -1

    for guard in new_guards:
        k = max(new_guards[guard].items(), key=operator.itemgetter(1))[0]
        v = new_guards[guard][k]

        if v > max_min_val:
            max_min_val = v
            max_min_id = k
            max_min_gid = guard

    print(max_min_gid * max_min_id)

if __name__ == "__main__":
    main(sys.argv)