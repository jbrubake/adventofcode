#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#include "battle.h"

int
main (int argc, char **argv)
{
    Game game_str;
    Dungeon dungeon_str;
    Square map_str[HEIGHT*WIDTH];

    Game *game = &game_str;
    game->dungeon = &dungeon_str;
    game->dungeon->map = map_str;
    game->dungeon->h = HEIGHT;
    game->dungeon->w = WIDTH;
    game->dungeon->num_mobs = 0;

    if (load_map (game->dungeon->map, game->dungeon->w, game->dungeon->h) == -1)
        exit;

    while (get_mobs (game->dungeon) > 0)
    {
        print_map (game->dungeon->map, game->dungeon->w, game->dungeon->h);
        Mob *mp = game->dungeon->mobs;
        for (int i = 0; i < game->dungeon->num_mobs; i++)
        {
            move_mob (mp, game->dungeon);
            mp++;
        }
        return 0;
    }
}

int
move_mob (Mob * m, Dungeon *d)
{
    /* printf ("Type: %d at %d,%d\n", m->type, m->x, m->y); */


    return 0;
}

int
get_mobs (Dungeon *d)
{
    d->num_mobs = 0;
    int i = 0;
    for (int y = 0; y < d->h; y++)
    {
        for (int x = 0; x < d->w; x++)
        {
           if (d->map[d->w*y+x].mobs == NULL)
               continue;
           d->mobs[i++] = *(d->map[d->w*y+x].mobs);
           if (++d->num_mobs > MAX_MOBS)
               return -1;
        }
    }

    return d->num_mobs;
}

int
load_map (Square *m, int h, int w)
{
    for (int y = 0; y < h; y++)
    {
        for (int x = 0; x < w; x++)
        {
            Mob *mob;
            m[w*y+x].mobs = NULL;
            switch (MAP[y][x])
            {
                case '#': m[w*y+x].type = WALL; break;
                case '.': m[w*y+x].type = OPEN; break;
                case 'E':
                    m[w*y+x].type = OPEN;
                    if ((mob = new_mob (ELF, x, y)) == 0)
                        return -1;
                    m[w*y+x].mobs = mob;
                    break;
                case 'G':
                    m[w*y+x].type = OPEN;
                    if ((mob = new_mob (GOBLIN, x, y)) == 0)
                        return -1;
                    m[w*y+x].mobs = mob;
                    break;
                default:
                    printf ("INVALID MAP CHARACTER: %c\n", MAP[y][x]);
                    return -1;
                    break;
            }
        }
    }
}

int
print_map (Square *m, int h, int w)
{
    for (int y = 0; y < h; y++)
    {
        for (int x = 0; x < w; x++)
        {
            char c = 'X';
            if (m[w*y+x].mobs != NULL)
            {
                switch (m[w*y+x].mobs->type)
                {
                    case ELF:
                        c = 'E';
                        break;
                    case GOBLIN:
                        c = 'G';
                        break;
                    default:
                        printf ("%s\n", "INVALID MOB TYPE");
                        return -1;
                        break;
                }
            } else {
                switch (m[w*y+x].type)
                {
                    case WALL:
                        c = '#';
                        break;
                    case OPEN:
                        c = '.';
                        break;
                    default:
                        c = 'X';
                        break;
                }
            }
            printf ("%c", c);
        }
        printf ("%s", "\n");
    }
}

Mob *
new_mob (Mob_type t, int x, int y)
{
    Mob *mob = malloc (sizeof (Mob));
    if (mob == NULL)
    {
        printf ("%s\n", "FAILED TO ALLOCATE MOB");
        return NULL;
    }

    mob->type = t;
    mob->x = x;
    mob->y = y;
    mob->hp = STARTING_HP;
    mob->atk = ATTACK;
    mob->has_moved = false;
    return mob;
}

void
free_mob (Mob *mob)
{
    free (mob);
}
