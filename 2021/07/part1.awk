#!/usr/bin/awk -f

function abs (v) { return v < 0 ? -v : v }

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

    for(x = left; x <= right; x++) {
        for(i = 1; i <= n; i++) {
            fuel[x] += abs(data[i] - x)
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



