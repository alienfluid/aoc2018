import sys

def main(args):
    inp = ""
    with open("input8-1") as f:
        inp = f.readline()
        inp = inp.strip()

    nodes = []
    for node in inp.split(' '):
        nodes.append(int(node))

    val, _ = get_node_value(nodes, 0)
    print(val)
    
def get_node_value(nodes, i):
    nlen = nodes[i]
    mlen = nodes[i+1]

    value = 0
    cvals = []

    nx = i+2
    for x in range(0, nlen):
        (val, nx) = get_node_value(nodes, nx)
        cvals.append(val)

    metadata = nodes[nx:(nx+mlen)]
    print(nlen, cvals, metadata)

    if nlen == 0:
        value = sum(metadata)
    else:
        for m in metadata:
            if m > len(cvals):
                continue
            else:
                value += cvals[m-1]

    print(value)
    return (value, nx + mlen)

if __name__ == "__main__":
    main(sys.argv)