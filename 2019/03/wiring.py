#!/usr/bin/python2

import sys

def draw_wire(commands):

    path = [(0,0)]
    steps = [0]
    s = 1

    for c in commands:
        d = c[0]
        dist = int(c[1:])

        last = path[-1]
        x = last[0]
        y = last[1]
    
        if d == 'U':
            for i in range(dist):
                y += 1
                path.append((x, y))
                steps.append(s)
                s += 1
        elif d == 'D':
            for i in range(dist):
                y -= 1
                path.append((x, y))
                steps.append(s)
                s += 1
        elif d == 'L':
            for i in range(dist):
                x -= 1
                path.append((x, y))
                steps.append(s)
                s += 1
        elif d == 'R':
            for i in range(dist):
                x += 1
                path.append((x, y))
                steps.append(s)
                s += 1
        else:
            print "INVALID DIRECTION"

    return path, steps

wires = []
steps = []
for line in sys.stdin:
    line = line.rstrip()
    commands = line.split(",")
    p, s = draw_wire(commands)
    wires.append(p)
    steps.append(s)

print wires
matches = set(wires[0][1:]).intersection(wires[1][1:])
distances = [abs(c[0])+abs(c[1]) for c in matches]
part1 = min(distances)
print "Part 1: ", part1
