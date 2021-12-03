#include <stdio.h>

#define SERIAL_NO 5486
/* #define GRID_SZ 300 */
#define GRID_SZ 6

struct max_info {
    int size;
    int power;
    int x;
    int y;
};

int
get_power_lvl (int sn, int x, int y)
{
    int id = x + 10;
    int p = id * y;
    p += sn;
    p *= id;
    p = (p / 100) % 10;
    p -= 5;

    return p;
}

struct max_info
region_max (int grid_size, int size)
{
    int pwr;
    struct max_info max_pwr = {0, 0, 0, 0};
    max_pwr.size = size;

    for (int x = 1; x <= grid_size - size + 1; x++) {
        for (int y = 1; y <= grid_size - size + 1; y++) {
            printf ("%d,%d %d\n", x, y, get_power_lvl (5486, x, y));
        }
    }

    /* for (int x = 1; x <= grid_size - size + 1; x++) */
    /* { */
        /* for (int y = 1; y <= grid_size - size + 1; y++) */
        /* { */
            /* pwr = 0; */
            /* printf ("X = %d, Y = %d, P = %d\n", x, y, get_power_lvl(SERIAL_NO, x, y)); */
            /* for (int i = x; i <= x + size - 1; i++) */
            /* { */
                /* for (int j = y; j <= y + size - 1; j++) */
                /* { */
                    /* pwr += get_power_lvl (SERIAL_NO, i, j); */
                    /* printf ("%d,%d: %d\n", i, j, get_power_lvl (SERIAL_NO, i, j)); */
                /* } */
            /* } */
            /* printf ("Region power = %d\n", pwr); */
            /* if (pwr > max_pwr.power) */
            /* { */
                /* max_pwr.power = pwr; */
                /* max_pwr.x = x; */
                /* max_pwr.y = y; */
            /* } */
        /* } */
    /* } */
    /* printf ("Max: Power = %d, X = %d, Y = %d, Size = %d\n", max_pwr.power, max_pwr.x, max_pwr.y, size); */
    return max_pwr;
}

void
main (int argc, char **argv)
{
    /* printf ("%d\n", get_power_lvl (8, 3, 5)); */
    /* printf ("%d\n", get_power_lvl (57, 122, 79)); */
    /* printf ("%d\n", get_power_lvl (39, 217, 196)); */
    /* printf ("%d\n", get_power_lvl (71, 101, 153)); */

    region_max (GRID_SZ, 1);
    return;

    struct max_info tmp_pwr;
    int max_pwr = 0;
    int max_x;
    int max_y;
    int max_size;
    /* for (int s = 1; s <= GRID_SZ; s++) */
    for (int s = 3; s <= 3; s++)
    {
        tmp_pwr = region_max (GRID_SZ, s);
        if (tmp_pwr.power > max_pwr)
        {
            max_pwr = tmp_pwr.power;
            max_size = tmp_pwr.size;
            max_x = tmp_pwr.x;
            max_y = tmp_pwr.y;
        }
    }

    printf ("%s\n", "Answer:");
    printf ("size %d: (Power = %d) %d,%d\n", max_size, max_pwr, max_x, max_y);
}


