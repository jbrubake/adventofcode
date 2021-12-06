#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

const int BUFSZ = 5000;
int BITS = 0;
const int EMPTY = -1;
const int DELETED = -2;

#define BYTE_TO_BINARY_PATTERN "%c%c%c%c%c%c%c%c"
#define BYTE_TO_BINARY(byte)  \
      (byte & 0x80 ? '1' : '0'), \
  (byte & 0x40 ? '1' : '0'), \
  (byte & 0x20 ? '1' : '0'), \
  (byte & 0x10 ? '1' : '0'), \
  (byte & 0x08 ? '1' : '0'), \
  (byte & 0x04 ? '1' : '0'), \
  (byte & 0x02 ? '1' : '0'), \
  (byte & 0x01 ? '1' : '0') 

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

void
print_array (int *data)
{
    for (int *p = data; *p != EMPTY; p++)
    {
        if (*p == DELETED)
            continue;
        printf (BYTE_TO_BINARY_PATTERN"\n", BYTE_TO_BINARY(*p));
    }
}

int
main (int argc, char **argv)
{
    /* Create lists and mark each record as EMPTY */
    int *oxygen = malloc (BUFSZ * sizeof(int));
    memset (oxygen, EMPTY, BUFSZ);
    int *co2 = malloc (BUFSZ * sizeof(int));
    memset (co2, EMPTY, BUFSZ);

    /* Read input into two lists: one for CO2 and one for O2 */
    char *line = NULL;
    size_t len = 0;
    ssize_t read;
    for (int *p = oxygen, *j = co2; (read = getline (&line, &len, stdin)) != EMPTY; p++, j++)
    {
        line[strlen(line)-1] = '\0'; /* Delete trailing newline */
        if (BITS == 0) /* How many bits are in the data? */
            BITS = strlen(line);

        /* Convert to a number */
        *p = strtol (line, NULL, 2);
        /* Copy to the other list */
        *j = *p;
    }
    free (line);

    /* print_array (oxygen); */

    for (int i = BITS-1; i >= 0; i--)
    {
        /* Get the current critical bit */
        int c1 = get_critical_value (oxygen, i);
        printf ("oxygen bit %d critical value is %d\n", i, c1);
        printf (" starting records: %d\n", num_records (oxygen));
        int c2 = !get_critical_value (co2, i);
        printf ("co2 bit %d critical value is %d\n", i, c2);
        printf (" starting records: %d\n", num_records (co2));

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
        /* printf (" ending records: %d\n", num_records (co2)); */
        /* print_array (co2); */
    }

    int c = 0;
    int o = 0;
    /* Find the remaining record */
    for (int *p = oxygen; *p != EMPTY; p++)
    {
        if (*p == DELETED)
            continue;
        /* printf ("Last record = %d\n", *p); */
        o = *p;
        break;
    }
    for (int *p = co2; *p != EMPTY; p++)
    {
        if (*p == DELETED)
            continue;
        /* printf ("Last record = %d\n", *p); */
        c = *p;
        break;
    }

    printf ("Answer = %d\n", o*c);

    return 0;
}

