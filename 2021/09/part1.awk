#!/usr/bin/awk -f

function height(x, y) {
    return int(substr(map[y], x, 1))
}

function is_lower(x, y,    h, n, e, s, w) {
    h = height(x+0, y+0)
    n = height(x+0, y-1)
    e = height(x+0, y+1)
    s = height(x+1, y+0)
    w = height(x-1, y+0)

    if(h >= n) return 0
    if(h >= e) return 0
    if(h >= s) return 0
    if(h >= w) return 0

    return 1
}

BEGIN {
    row = 1

    if(TEST == 1) {
        LENGTH = 10
        map[row] = "999999999999"
    } else {
        LENGTH = 100
        map[row] = "999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999"
    }
}

{
    row++
    $0 = "9" $0 "9"
    map[row] = $0
}

END {
    row++
    if(TEST == 1) {
        map[row] = "999999999999"
    } else {
        map[row] = "999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999"
    }

    # indices are funky because we skip the bounding box
    for(y = 2; y < row; y++) {
        for(x = 2; x < LENGTH+2; x++) {
            if(is_lower(x, y)) {
                risk += height(x, y) + 1
            }
        }
    }

    printf("Risk level = %s\n", risk)
}
