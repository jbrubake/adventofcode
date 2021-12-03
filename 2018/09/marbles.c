#include <stdio.h>
#include <stdlib.h>

struct marble
{
    long val;
    struct marble *next;
    struct marble *prev;
};

struct marble *new_marble (long);
struct marble *insert_marble (long, struct marble *);
struct marble *delete_marble (struct marble *);
struct marble *get_marble (struct marble *, int);
void print (struct marble *);

int
main (int argc, char **argv)
{
    int num_players;
    long last_marble;
    struct marble *curr = new_marble(0);
    curr->next = curr->prev = curr;
    struct marble *start = curr;

    fscanf (stdin, "%d players; last marble is worth %ld points", &num_players, &last_marble);

    unsigned long long players[ num_players ];

    for (int i = 0; i < num_players; i++)
    {
        players[i] = 0;
    }

    long marble_val = 1;
    for (;;) {
        for (int i = 0; i < num_players; i++)
        {
        /* print_marbles (start); */
            if (marble_val > last_marble) 
                goto PART1_DONE;
            if (marble_val % 23 != 0)
            {
               curr = insert_marble (marble_val, curr); 
            }
            else
            {
                /* printf ("add marble_val %d\n", marble_val); */
                players[i] += marble_val;
                curr = get_marble (curr, -6);
                /* printf ("add deleted marble %d\n", curr->prev->val); */
                players[i] += curr->prev->val;
                curr = delete_marble (curr->prev);
            }
            marble_val++;
        }
    }

PART1_DONE: ;
    unsigned long long score = 0;
    for (int i = 0; i < num_players; i++)
    {
       if (players[i] > score)
           score = players[i];
    }

    printf ("Final score: %lld\n", score);
    return score;
}

struct marble *
new_marble (long val)
{
    struct marble *m = malloc (sizeof (struct marble));
    m->val = val;
    m->next = m->prev = NULL;

    return m;
}

struct marble *
insert_marble (long val, struct marble *m)
{
    struct marble *n = new_marble (val);
    m = m->next;

    (m->next)->prev = n;
    n->next = m->next;
    m->next = n;
    n->prev = m;

    return n;
}

struct marble *
get_marble (struct marble *m, int offset) {
    int go_cw = offset > 0 ? 1 : 0;

    for (int i = 1; i <= abs(offset); i++)
    {
        if (go_cw)
            m = m->next; 
        else
            m = m->prev;
    }

    return m;
}

struct marble *
delete_marble (struct marble *m)
{
    struct marble *c;
    c = m->next;
    c->prev = m->prev;
    m->prev->next = c;

    /* free (m); */

    return c;
}

void
print_marbles (struct marble *m)
{
    struct marble *c = m;
    do {
        printf ("%ld ", c->val);
        c = c->next;
    } while (c != m);
    printf ("%s", "\n");
}
