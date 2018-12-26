import sys
import re

from PIL import Image

def main(args):
    lines = []
    with open("input10-1") as f:
        lines = f.readlines()

    pos = {}
    index = 0
    for line in lines:
        line = line.strip()
        nums = re.findall(r'[+-]?\d+(?:\.\d+)?', line)
        pos[index] = ((int(nums[0]), int(nums[1])), (int(nums[2]), int(nums[3])))
        index += 1

    for secs in range(0, 10519):
        increment(pos)

    print_pos(pos)

def increment(pos):
    for k in pos:
        tmp = pos[k][0]
        vel = pos[k][1]
        new = (vel[0] + tmp[0], vel[1] + tmp[1])
        pos[k] = (new, vel)

def print_pos(pos):
    for p in pos:
        print(pos[p][0][0], ",", pos[p][0][1])

if __name__ == "__main__":
    main(sys.argv)