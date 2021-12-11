#!/usr/bin/awk -f

function abs(v) { return v < 0 ? -v : v }

BEGIN { FS = "," }

{
    split ($0, data, FS)
    n = asort (data)
    left = data[1]
    right = data[n]

    for(d = 1; d <= abs(right - left); d++) {
        fuel_tbl[d] = fuel_tbl[d-1] + d
    }

    # Check all positions
    for(x = left; x <= right; x++) {
        for(i = 1; i <= n; i++) {
            d = abs(data[i] - x)
            fuel1[x] += d
            fuel2[x] += fuel_tbl[d]
        }
    }

    min1 = 0
    for (i = 1; i <= n; i++) {
        if (min1 == 0) {
            min1 = fuel1[i]
        } else if (fuel1[i] < min1) {
            min1 = fuel1[i]
        }
    }

    min2 = 0
    for (i = 1; i <= n; i++) {
        if (min2 == 0) {
            min2 = fuel2[i]
        } else if (fuel2[i] < min2) {
            min2 = fuel2[i]
        }
    }
}

END {
    printf ("Part 1: %d\n", min1)
    printf ("Part 2: %d\n", min2)
}

