import sys

def main(args):
    inp = ""
    with open("input8-1") as f:
        inp = f.readline()
        inp = inp.strip()

    nodes = []
    for node in inp.split(' '):
        nodes.append(int(node))

    meta = []

    nx = process_node(meta, nodes, 0)
    print(meta)
    
    flatten = lambda l: [item for sublist in l for item in sublist]

    print(sum(flatten(meta)))

def process_node(meta, nodes, i):
    nlen = nodes[i]
    mlen = nodes[i+1]

    nx = i+2
    for x in range(0, nlen):
        nx = process_node(meta, nodes, nx)

    meta.append(nodes[nx:(nx+mlen)])

    return (nx + mlen)

if __name__ == "__main__":
    main(sys.argv)