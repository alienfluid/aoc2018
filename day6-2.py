import sys

def main(args):
    lines = []
    with open("input6-1") as f:
        lines = f.readlines()

    coords = []
    for line in lines:
        line = line.strip()
        toks = line.split(',')
        coords.append((int(toks[0]), int(toks[1])))
    print(coords)

    max_x = -1
    max_y = -1

    for c in coords:
        if c[0] > max_x:
            max_x = c[0]
        if c[1] > max_y:
            max_y = c[1]
    print("max x and y", max_x, max_y)

    new_max_x = new_max_y = max(max_x, max_y) + 1

    region = []
    for x in range(0, new_max_x):
        for y in range(0, new_max_y):
            check = (x,y)
            dist = 0
            for c in coords:
                dist += get_mdist(check, c)
            
            if dist < 10000:
                region.append(check)

    print(len(region))

def on_edge(mx, my, pts):
    for p in pts:
        if p[0] <= 0 or p[0] >= (mx-1) or p[1] <= 0 or p[1] >= (my-1):
            return True
    return False
        
def print_matrix(mx, my, mt):
    for i in range(0, my):
        for j in range(0, mx):
            c = mt[(j,i)]
            sys.stdout.write(str(c[0]))
            sys.stdout.write('\t')
            sys.stdout.flush()
        sys.stdout.write("\n")

def get_mdist(a, b):
    return abs(a[0] - b[0]) + abs(a[1] - b[1])

if __name__ == "__main__":
    main(sys.argv)