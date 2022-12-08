#include <stdio.h>
#include <stdlib.h>

const int MAGIC_MARBLE = 23;

struct marble
{
    long val;
    struct marble *next;
    struct marble *prev;
};

unsigned long long get_winning_score (int, long);

int
main (int argc, char **argv)
{
    int num_players;
    long last_marble;
    unsigned long long players[ num_players ];

    fscanf (stdin, "%d players; last marble is worth %ld points", &num_players, &last_marble);

    printf ("Part 1: %u\n", get_winning_score (num_players, last_marble));
    printf ("Part 2: %u\n", get_winning_score (num_players, last_marble*100));
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

    free (m);

    return c;
}

unsigned long long
get_winning_score(int n, long last_marble)
{
    struct marble start;
    struct marble *curr = &start;
    curr->next = curr->prev = curr;

    unsigned long long players[n];
    for (int i = 0; i < n; i++)
        players[i] = 0;

    long marble_val = 1;

    for (;;)
        for (int i = 0; i < n; i++)
        {
            if (marble_val > last_marble) 
                goto DONE;
            else if (marble_val % MAGIC_MARBLE != 0)
               curr = insert_marble (marble_val, curr); 
            else
            {
                players[i] += marble_val;
                curr = get_marble (curr, -6);
                players[i] += curr->prev->val;
                curr = delete_marble (curr->prev);
            }
            marble_val++;
        }

DONE:
    unsigned long long score = 0;
    for (int i = 0; i < n; i++)
       if (players[i] > score)
           score = players[i];

    return score;
}

