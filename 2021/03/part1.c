#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

const int BITS = 12;

void
print_int_array (int* a, int n)
{
    for (int i = 0; i < n; i++)
    {
        printf ("%d ", a[i]);
    }
}

int
main (int argc, char **argv)
{
    char *line = NULL;
    size_t len = 0;
    ssize_t read;
    unsigned int val;
    unsigned int gamma[BITS];
    int n = 0;

    for (int i = 0; i < BITS; i++)
    {
        gamma[i] = 0;
    }

    while ((read = getline (&line, &len, stdin)) != -1)
    {
        n++;
        line[strlen(line)-1] = '\0';

        val = strtol (line, NULL, 2);
        printf ("%s\n", line);

        for (int i = 0; i < BITS; i++)
        {
            gamma[i] += (val & (1 << i)) >> i;
        }

        print_int_array (gamma, BITS);
        printf (" gamma%s\n", "\n");
    }
    free (line);

    double g = 0;
    double e = 0;
    for (int i = 0; i < BITS; i++)
    {
        if (gamma[i] < (n/2))
        {
            gamma[i] = 0;
            e += pow (2, (double)i);
        }
        else
        {
            gamma[i] = 1;
            g += pow (2, (double)i);
        }

    }

    print_int_array (gamma, BITS);
    printf (" => g %u, e %u\n", (unsigned int)g, (unsigned int)e);

    printf ("Power consumption = %u\n", (unsigned int)g * (unsigned int)e);

    return 0;
}

