import sys

def main(args):

    num_workers = 5
    delay = 60

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

    w = {}
    for i in range(0, num_workers):
        w[i] = []

    t = 0
    while True:
        print("time", t)

        for i in w:
            tmp = w[i]
            if len(tmp) > 0:
                c = tmp.pop()
                w[i] = tmp
                if len(tmp) == 0:
                    complete_dep(c, deps)

        cnd = return_candidates(deps)
        for c in cnd:
            if currently_processing(w, c):
                continue

            for i in w:
                if len(w[i]) == 0:
                    l = (ord(c) - 64) + delay
                    w[i] = [c] * l
                    break

        print_workers(w)

        done = True
        for i in w:
            if len(w[i]) > 0:
                done = False
                break

        if done:
            break

        t += 1

    print(t)

def currently_processing(w, c):
    for i in w:
        if c in w[i]:
            return True
    return False

def print_workers(w):
    for i in w:
        sys.stdout.write(str(i))
        sys.stdout.write(str(w[i]))
        sys.stdout.write("\n")
        sys.stdout.flush()

def complete_dep(d, deps):
    for x in deps:
        dp = deps[x]
        if d in dp:
            dp.remove(d)
            deps[x] = dp
    deps.pop(d)

def return_candidates(deps):
    c = []
    for x in deps:
        if len(deps[x]) == 0:
            c.append(x)
    return c

if __name__ == "__main__":
    main(sys.argv)