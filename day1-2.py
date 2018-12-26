import sys

def main(args):
    lines = []
    with open("input1-1") as f:
        lines = f.readlines()

    hsh = {}
    cur = 0
    itr = 0

    hsh[cur] = True

    found = False
    while not found:
        itr += 1
        for l in lines:
            if l[0] == "+":
                cur += int(l[1:len(l)-1])
            else:
                cur -= int(l[1:len(l)-1])

            if cur in hsh:
                print(cur)
                found = True
                break

            hsh[cur] = True

    print("took iterations:", itr)

if __name__ == "__main__":
    main(sys.argv)
