#!/usr/bin/awk -f

BEGIN { FS = "|" }

{
    split($2, output, " ")
    for(i = 1; i <= 4; i++) {
        length(output[i]) == 2 && count++
        length(output[i]) == 4 && count++
        length(output[i]) == 3 && count++
        length(output[i]) == 7 && count++
    }
}

END { print "Count of 1, 4, 7, 8: ", count }
