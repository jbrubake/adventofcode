#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

const int BUFSZ = 5000;
const int EMPTY = -1;
const int DELETED = -2;

int BITS = 0;

int
get_critical_value (int *data, int n)
{
    unsigned int *p = (unsigned int *)data;

    int b = 0;
    int ones = 0;
    int zeroes = 0;
    for (; *p != EMPTY; p++)
    {
        if (*p == DELETED)
            continue;
        b = (*p & (1 << n)) >> n;
        if (b == 0)
            zeroes++;
        else
            ones++;
    }

    if (ones >= zeroes)
        return 1;
    else
        return 0;
}

int
num_records (int *data)
{
    int n = 0;
    for (int *p = data; *p != EMPTY; p++)
    {
        if (*p == DELETED)
            continue;
        n++;
    }

    return n;
}

int
main (int argc, char **argv)
{
    /* Create lists and mark each record as EMPTY */
    int *oxygen = malloc (BUFSZ * sizeof(int));
    memset (oxygen, EMPTY, BUFSZ);
    int *co2 = malloc (BUFSZ * sizeof(int));
    memset (co2, EMPTY, BUFSZ);
    unsigned int *gamma = malloc (BUFSZ * sizeof(int));
    memset (gamma, EMPTY, BUFSZ);

    /* Read input into two lists: one for CO2 and one for O2 */
    char *line = NULL;
    size_t len = 0;
    ssize_t read;
    int n = 0; /* count total records */
    for (int *p = oxygen, *j = co2; (read = getline (&line, &len, stdin)) != EMPTY; p++, j++, n++)
    {
        line[strlen(line)-1] = '\0'; /* Delete trailing newline */
        if (BITS == 0) {
            /* How many bits are in the data? */
            BITS = strlen(line);
            /* Initialize gamma to 0 */
            memset (gamma, 0, BITS * sizeof (unsigned int));
        }

        /* Convert to a number */
        *p = strtol (line, NULL, 2);
        /* Copy to the other list */
        *j = *p;

        /* Calculate gamma */
        unsigned int *gp = gamma;
        for (int i = 0; i < BITS; i++)
        {
            *gp += (*p & (1 << i)) >> i;
            gp++;
        }
    }
    free (line);

    /* Calculate Part 1 */
    double g = 0;
    double e = 0;
    for (unsigned int *gp = gamma, i = 0; *gp != EMPTY; gp++, i++)
    {
        /* printf ("%d ", *gp); */
        if (*gp < (n/2))
        {
            /* printf ("(gp = 0) "); */
            *gp = 0;
            e += pow (2, (double)i);
        }
        else
        {
            /* printf ("(gp = 1) "); */
            *gp = 1;
            g += pow (2, (double)i);
        }

    }
        /* printf ("\n"); */
    printf ("Part 1: %u\n", (unsigned int)g * (unsigned int)e);

    /* Calculate Part 2 */
    for (int i = BITS-1; i >= 0; i--)
    {
        /* Get the current critical bit */
        int c1 = get_critical_value (oxygen, i);
        int c2 = !get_critical_value (co2, i);

        /* Loop through the lists and mark unneeded records */
        if (num_records (oxygen) > 1)
        {
            for (int *p = oxygen; *p != EMPTY; p++)
            {
                if (*p == DELETED)
                    continue;
                if ((*p & (1 << i)) >> i != c1)
                    *p = DELETED;
            }
        }
        if (num_records (co2) > 1)
        {
            for (int *p = co2; *p != EMPTY; p++)
            {
                if (*p == DELETED)
                    continue;
                if ((*p & (1 << i)) >> i != c2)
                    *p = DELETED;
            }
        }
    }

    int c = 0;
    int o = 0;
    /* Find the remaining record */
    for (int *p = oxygen; *p != EMPTY; p++)
    {
        if (*p == DELETED)
            continue;
        o = *p;
        break;
    }
    for (int *p = co2; *p != EMPTY; p++)
    {
        if (*p == DELETED)
            continue;
        c = *p;
        break;
    }

    printf ("Part 2: %d\n", o*c);

    return 0;
}

