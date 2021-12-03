#include <stdio.h>

#define RANGE 10551314

int
main (int argc, char **argv)
{
    long a = 1;
    long c = 0;
    long e = 0;

    for (e = 1, c = 1; c <= RANGE; e++)
    {
        if ((c * e) == RANGE)
            a += c;
        if (e > RANGE)
        {
            c++;
            e = 0;
        }
    }

    printf ("%ld\n", a);
}
