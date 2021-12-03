#include <stdio.h>

int
main (int argc, char ** argv)
{
    /* Set a = 15690445 to terminate */
    int a  = 0;
    int ip = 0;
    int c  = 0;
    int d  = 0;
    int e  = 0;
    int f  = 0;

    int poss[115000];
    int n = 0;

G:  d = e | 65536;
    e = 12670166;

E:  while (1)
    {
        c = d & 255;
        e += c;
        e = e & 16777215;
        e = e * 65899;
        e = e & 16777215;

        if (256 > d)
            break;

        c = 0;
B:      while (1)
        {
            f = (c + 1) * 256;

            if (f > d)
                break;

            c++;
        }

        d = c;
    }


    printf ("n = %d\n", n);
    poss[n++] = e;
    for (int i = 0; i < n-1; i++)
    {
        if (poss[i] == e)
        {
            printf ("Part 2: %d\n", poss[n-2]);
            return poss[n-2];
        }
    }

    /* printf ("E = %d\n", e); */
    if (e == a)
    {
        return a;
    } else {
        goto G;
    }
}

