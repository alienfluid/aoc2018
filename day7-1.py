import sys

def main(args):
    lines = []
    with open("input7-1") as f:
        lines = f.readlines()

    deps = {}
    for line in lines:
        line = line.strip()
        
        f = line[36]
        t = line[5]

        if f in deps:
            deps[f].append(t)
        else:
            deps[f] = [t]

        if t not in deps:
            deps[t] = []
    
    print(deps)

    s = ""
    while len(deps.keys()) > 0:
        c = return_candidate(deps)
        s += c
        complete_dep(c, deps)

    print(s)

def complete_dep(d, deps):
    for x in deps:
        dp = deps[x]
        if d in dp:
            dp.remove(d)
            deps[x] = dp
    deps.pop(d)

def return_candidate(deps):
    c = []
    for x in deps:
        if len(deps[x]) == 0:
            c.append(x)
    return sorted(c)[0]

if __name__ == "__main__":
    main(sys.argv)