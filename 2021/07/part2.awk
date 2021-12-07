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
            f = fuel_tbl[d]
            fuel[x] += f
        }
    }

    min = 0
    for (i = 1; i <= n; i++) {
        if (min == 0) {
            min = fuel[i]
        } else if (fuel[i] < min) {
            min = fuel[i]
        }
    }
}

END { printf ("Min fuel: %d\n", min) }

