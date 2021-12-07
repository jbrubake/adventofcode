#!/usr/bin/awk -f

function abs(v) { return v < 0 ? -v : v }

function get_fuel(d,    f, total) {
    f = 1
    total = 0
    for(i = 1; i <= d; i++) {
        total += f
        f++
    }

    return total
}

BEGIN { FS = "," }

{
    split ($0, data, FS)
    n = asort (data)
    left = data[1]
    right = data[n]

    for(i = 1; i <= n; i++) {
        printf("%d ", data[i])
    }
    print "\n"

    for(d = 1; d <= abs(right - left); d++) {
        fuel_tbl[d] = get_fuel(d)
        printf("Distance %d needs %d fuel\n", d, fuel_tbl[d])
    }

    # Check all positions
    for(x = left; x <= right; x++) {
        printf("Position %d\n", x)
        # Get fuel needed by each crab
        for(i = 1; i <= n; i++) {
            d = abs(data[i] - x)
            f = fuel_tbl[d]
            printf("->Crab %d (distance %d) needs %d\n", data[i], d, f)
            fuel[x] += f
        }
        printf("Fuel for position %d = %d\n", x, fuel[x])
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

