#!/usr/bin/awk -f

BEGIN { printf "%s", "Part 1: " }
{ freq += $1 } # Running total of frequency
END { print freq }

