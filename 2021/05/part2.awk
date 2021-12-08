#!/usr/bin/awk -f

function get_dangerous_points(    x, y) {
    for(y = 0; y <= maxy; y++) {
        for(x = 0; x <= maxx; x++) {
            if(grid[x+1][y+1] >= 2) count++
        }
    }
    return count
}

{
    x1 = gensub(/,.*/, "", "g", $0)
    x2 = gensub(/.*> /, "", "g", $0)
    x2 = gensub(/,.*/, "", "g", x2)

    y1 = gensub(/ .*/, "", "g", $0)
    y1 = gensub(/.*,/, "", "g", y1)
    y2 = gensub(/.*,/, "", "g", $0)

    x1 = int(x1)
    x2 = int(x2)
    y1 = int(y1)
    y2 = int(y2)

    if(x2 > maxx) maxx = x2
    if(y2 > maxy) maxy = y2

    # Vertical
    if(x1 == x2) {
        x = x1
        if(y1 > y2 ) { t = y1; y1 = y2; y2 = t }
        for(y = y1; y <= y2; y++) {
            grid[x+1][y+1]++
        }
    # Horizontal
    } else if(y1 == y2) {
        y = y1
        if(x1 > x2) { t = x1; x1 = x2; x2 = t }
        for(x = x1; x <= x2; x++) {
            grid[x+1][y+1]++
        }
    # NE
    } else if(x1 <= x2 && y1 <= y2) {
        y = y1
        x = x1
        while(y <= y2) {
            grid[x+1][y+1]++
            y++
            x++
        }
    # SW
    } else if (x1 > x2 && y1 > y2) {
        y = y2
        x = x2
        while(y <= y1) {
            grid[x+1][y+1]++
            y++
            x++
        }
    # NW
    } else if (x1 > x2 && y1 <= y2) {
        y = y1
        x = x1
        while(y <= y2) {
            grid[x+1][y+1]++
            x--
            y++
        }
    # SE
    } else if (x1 <= x2 && y1 > y2) {
        y = y1
        x = x1
        while(x <= x2) {
            grid[x+1][y+1]++
            x++
            y--
        }
    } else { print "WTF?" }
}

END {
    printf("Dangerous points = %s\n", get_dangerous_points())
}

