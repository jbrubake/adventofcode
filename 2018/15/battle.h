#ifndef BATTLE_H
#define BATTLE_H

#define HEIGHT 32
#define WIDTH 32
char MAP[HEIGHT][WIDTH] = {
    {"################################"},
    {"#######.......###.#.G###########"},
    {"#######...G#.####...#.##########"},
    {"#######....#####....G.##########"},
    {"######......#..#......##########"},
    {"#########G..G..#.......#########"},
    {"###########.........G..#########"},
    {"############.#.........#########"},
    {"###########..##.......##.##.####"},
    {"########G...##...G#............#"},
    {"#####..##...#........G.........#"},
    {"#####.G##........G.GG.......E.##"},
    {"#####..#......#####....#.......#"},
    {"#####.G......#######.......E...#"},
    {"#####...G...#########E.........#"},
    {"#####.....G.#########.........##"},
    {"####....G...#########.....#...##"},
    {"#.##........#########.....#.#.##"},
    {"#...........#########.....#.#..#"},
    {"#.G.#..##E...#######..#####.#..#"},
    {"##G.......#...#####...#####.##E#"},
    {"#........#..........E.#####..#.#"},
    {"##..#....#........#######..#...#"},
    {"#.....##.#...E....########.....#"},
    {"##..E.##...G..E..##########....#"},
    {"###########.....###########..E.#"},
    {"###########.....##########.....#"},
    {"###########..#############.....#"},
    {"##########..#################..#"},
    {"##########.##################..#"},
    {"#########..##################.##"},
    {"################################"},
};

typedef enum Mob_type { ELF, GOBLIN } Mob_type;
#define MAX_MOBS 32
#define STARTING_HP 200
#define ATTACK 3
typedef struct Mob {
    Mob_type type;
    int x;
    int y;
    int hp;
    int atk;
    bool has_moved;
} Mob;

typedef enum Square_type { WALL, OPEN } Square_type;
typedef struct Square {
    Square_type type;
    Mob *mobs;
} Square;

typedef struct Dungeon {
    int h;
    int w;
    int num_mobs;
    Square *map;
    Mob mobs[MAX_MOBS];
} Dungeon;

typedef struct Game {
    Dungeon *dungeon;
} Game;

int load_map (Square *, int, int);
int print_map (Square *, int, int);
Mob * new_mob (Mob_type, int, int);
void free_mob (Mob *);
int get_mobs (Dungeon *);
int move_mob (Mob *, Dungeon *);

#endif