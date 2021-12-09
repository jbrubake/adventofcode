#!/usr/bin/awk -f

function height(x, y) {
    return int(substr(map[y], x, 1))
}

function mark(x, y,    a, b) {
    map[y] = substr(map[y], 1, x-1) "9" substr(map[y], x+1)
}

function is_bottom(x, y,    h, n, e, s, w) {
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

function find_basin_size(x, y,    h, sum) {
    h = height(x, y)
    sum = 1

    h2 = height(x+0, y-1)
    if(h2 > h && h2 != 9)
        sum += find_basin_size(x+0, y-1, h)

    h2 = height(x+1, y+0)
    if(h2 > h && h2 != 9)
        sum += find_basin_size(x+1, y+0, h)

    h2 = height(x+0, y+1)
    if(h2 > h && h2 != 9)
        sum += find_basin_size(x+0, y+1, h)

    h2 = height(x-1, y+0)
    if(h2 > h && h2 != 9)
        sum += find_basin_size(x-1, y+0, h)

    mark(x, y)

    return sum
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
    n = 1
    for(y = 2; y < row; y++) {
        for(x = 2; x < LENGTH+2; x++) {
            if(!is_bottom(x, y)) continue
            sizes[n] = find_basin_size(x, y)
            n++
        }
    }

    last = asort(sizes)
    print sizes[last] * sizes[last-1] * sizes[last-2]
}
