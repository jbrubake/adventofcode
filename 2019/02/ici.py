#!/usr/bin/python2

import sys

noun = 12
verb = 2
target_result = 19690720

def run (prog, noun, verb):
    mem = list(prog)

    mem[1] = noun
    mem[2] = verb

    opcode = 0
    arg1 = 0
    arg2 = 0
    arg3 = 0
    ip = 0

    while ip < len(mem):
        opcode = mem[ip]

        if ip+1 < len(mem):
            arg1 = mem[ip+1]
        if ip+2 < len(mem):
            arg2 = mem[ip+2]
        if ip+3 < len(mem):
            arg3 = mem[ip+3]

        if opcode == 99:
            break
        elif opcode == 1:
            mem[arg3] = mem[arg1] + mem[arg2]
        elif opcode == 2:
            mem[arg3] = mem[arg1] * mem[arg2]
        else:
            print "INVALID OPCODE!!"
            break

        ip += 4

    return mem[0]

for line in sys.stdin:
    line = line.rstrip()

program = line.split(",")
program = [ int(n) for n in program ]

part1 = run(program, noun, verb)

print "Part 1:", part1

part2 = 0
for noun in range(99):
    for verb in range(99):
        if run(program, noun, verb) == target_result:
            part2 = 100 * noun + verb
            break

print "Part 2:", part2
