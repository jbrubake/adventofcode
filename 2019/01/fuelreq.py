#!/usr/bin/python2

import sys

def get_fuel_req (mass):
    return mass // 3 -2

part1_fuel = 0
part2_fuel = 0
for mass in sys.stdin:
    mass = int(mass)
    mass = get_fuel_req (mass)
    part1_fuel += mass
    while True:
        if mass <= 0:
            break
        part2_fuel += mass
        mass = get_fuel_req (mass)

print "Part 1: " + str(part1_fuel)
print "Part 2: " + str(part2_fuel)
