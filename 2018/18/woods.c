#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define HEIGHT 50
#define WIDTH 50

#define PART1_MIN 10
#define PART2_MIN 1000000000
#define MINUTES 1000
int hashes[MINUTES];
int scores[MINUTES];

char INPUT[HEIGHT+2][WIDTH+2] = {
    {"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"},
    {"X........#.##..#|#|.#.....|......#..#.|..##..||.#..X"},
    {"X#|##.|||.|..|||......|.##.#|#|....||#.#...#...#..#X"},
    {"X..##...#|#..|#.|..#||#...|#....|#...#|#.|.||...|..X"},
    {"X.....#|||.|.#...###|....|#..#.#.#.|..#||#|....|#.|X"},
    {"X....|.....#.||.#..#...#|....|||..#....##...|..|.#|X"},
    {"X||...|###..|..|||..|#.##|.####.#...|.||.|....|.##.X"},
    {"X..#.#.###..||......#|#|.|....#|.#|.|...#....#...#|X"},
    {"X.|..||||||...#.##..|.#||.#|##|..#.#..##..#...|#...X"},
    {"X.|.....||...#.#|.##|..|.##||..#.#..|..#.#.#..|.#|.X"},
    {"X||...|#........#.|..##|.|..#...#...#|#|..||.|....#X"},
    {"X#||.|.|..|.......##....|..#||#.#|.|||......|..||..X"},
    {"X.....#.|||.....|.#.#.......#.|..#.|.....|.|.#...#.X"},
    {"X...#.##.#.||#.#|.#.##..#.||#.#.#|#.||.||.|......#.X"},
    {"X|.|...#|.|####|.|..#.#|....|......|....|...||#||..X"},
    {"X.#...#.#......|...#.....|.....|.#|...##|||...#.|#.X"},
    {"X||##.#...#.|...##..##.||#...#|...|##.##...#||..#|.X"},
    {"X|.|#.||..|##.|.#.|..#..|.##.#.......#...|....||...X"},
    {"X.|.......#..##...|.|..|#.#....|#|..##|#|.##|.|.|#.X"},
    {"X.|....|.#|||#.#..#..|||.....||...#|.#..|..#.#...#.X"},
    {"X...#..###.#|.##||.#.|.||###..|..|#.|#..||......||.X"},
    {"X..##.......##|.....#...|#|..##|.#.|||.|#....|##...X"},
    {"X#...#|##|......##|...|#..#.|..##..#..#.|##.##|#..#X"},
    {"X|.#|.....|..#...|....|...#....#|..#.....||...|#|.|X"},
    {"X##...#.....#.....|#|.......|....####.#..##.|.##...X"},
    {"X.....|...|#|#..|#|.|..##.|..|....##..||.#...|..|.|X"},
    {"X.|..|....##.||||.##|.#...|..|#|.#.|####.|..|##.#..X"},
    {"X#.........|##.#|..##|...|........|..|....|..#...##X"},
    {"X.#.|...#...#...|.|...|..|.#.|....#..|.|..|..#|....X"},
    {"X.....#.....#|.#....|....##...##....###....#.|...|.X"},
    {"X||.....|.|.##|.##||.#|#.##|.#..|#####|...|...||#.#X"},
    {"X...#||....#.....##.|##|.##|#.##.#|.|.....#........X"},
    {"X..##.....||..#..#.|..##...#.|.|.|.|...|.#.|..|....X"},
    {"X|##..|..........##..#|...|......||.#....#....|..#.X"},
    {"X...#..|.#.|...|.##|.##..##..|.|....#||#|##..||||..X"},
    {"X#...##......|..|#...#.#.|#||..#...|.#...|..###.||.X"},
    {"X|#.......|#.|##|....|.....#..||.|#|#...#|....|..#|X"},
    {"X.|.....#|##.|.#...#..#||#.....|....#||.#|.##.##.#|X"},
    {"X|#..###..#..|#.....##...||.|.|.#.#|.||..||.||#|#..X"},
    {"X||||#....|#..|.|...|...||....|...#....#.##...#|...X"},
    {"X...||##||#......|#.#..#..|.....|...#..#|...#...|||X"},
    {"X.|#.|.|....|...#.....|#....|..#.#...#...||..##|..|X"},
    {"X||#.|##.|...|.##......##|#..#..#.#.#.....|#|##.##.X"},
    {"X|.#.....||.....#.#...|...|..|#|..|..#...|....|...|X"},
    {"X###..#.#......#|..#....#......|##.##....|||.|..#|.X"},
    {"X..#.|.#...#..|#####|.....##.|.|#......|..||.#|....X"},
    {"X.#||.|.##..#.|..##......|..|.|#..|.....#.....|#|..X"},
    {"X|##.#......#.#.#.#|||#|....#...#.|.........|||.#..X"},
    {"X|......||.|..#.|#||...||.#.#.##..#..#.#....#.#..#|X"},
    {"X#.|..##.....#..|...|#...#...|.......|.|..|#|......X"},
    {"X##...#....#..#..#....|...#|#.||.|...|.#..###|##|.|X"},
    {"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"}
};

char tmp [HEIGHT+2][WIDTH+2];

int
main (int argc, char **argv)
{
    int part_1 = 0;
    int cycle = 0;
    int cycle_start = 0;

    printf ("%s\n", "Starting map");
    for (int y = 0; y < HEIGHT+2; y++)
    {
        for (int x = 0; x < WIDTH+2; x++)
        {
            printf ("%c", INPUT[y][x]);
        }
        printf ("%s", "\n");
    }

    for (int i = 1; i <= MINUTES; i++)
    {
        /* Copy map */
        for (int y = 0; y < HEIGHT+2; y++)
        {
            for (int x = 0; x < WIDTH+2; x++)
            {
                tmp[y][x] = INPUT[y][x];
            }
        }

        /* Calculate changes */
        for (int y = 1; y <= WIDTH; y++)
        {
            for (int x = 1; x <= HEIGHT; x++)
            {
                int n = 0;
                int ln = 0;
                int wn = 0;
                n = ln = wn = 0;
                switch (INPUT[y][x])
                {
                    case 'X': break;
                    case '.':
                              if (INPUT[y-1][x-1] == '|') n++;
                              if (INPUT[y-1][x+0] == '|') n++;
                              if (INPUT[y-1][x+1] == '|') n++;
                              if (INPUT[y+0][x-1] == '|') n++;
                              if (INPUT[y+0][x+1] == '|') n++;
                              if (INPUT[y+1][x-1] == '|') n++;
                              if (INPUT[y+1][x+0] == '|') n++;
                              if (INPUT[y+1][x+1] == '|') n++;

                              if (n >= 3) tmp[y][x] = '|';
                              break;
                    case '|':
                              if (INPUT[y-1][x-1] == '#') n++;
                              if (INPUT[y-1][x+0] == '#') n++;
                              if (INPUT[y-1][x+1] == '#') n++;
                              if (INPUT[y+0][x-1] == '#') n++;
                              if (INPUT[y+0][x+1] == '#') n++;
                              if (INPUT[y+1][x-1] == '#') n++;
                              if (INPUT[y+1][x+0] == '#') n++;
                              if (INPUT[y+1][x+1] == '#') n++;

                              if (n >= 3) tmp[y][x] = '#';
                              break;
                    case '#':
                              if (INPUT[y-1][x-1] == '#') ln++;
                              if (INPUT[y-1][x+0] == '#') ln++;
                              if (INPUT[y-1][x+1] == '#') ln++;
                              if (INPUT[y+0][x-1] == '#') ln++;
                              if (INPUT[y+0][x+1] == '#') ln++;
                              if (INPUT[y+1][x-1] == '#') ln++;
                              if (INPUT[y+1][x+0] == '#') ln++;
                              if (INPUT[y+1][x+1] == '#') ln++;

                              if (INPUT[y-1][x-1] == '|') wn++;
                              if (INPUT[y-1][x+0] == '|') wn++;
                              if (INPUT[y-1][x+1] == '|') wn++;
                              if (INPUT[y+0][x-1] == '|') wn++;
                              if (INPUT[y+0][x+1] == '|') wn++;
                              if (INPUT[y+1][x-1] == '|') wn++;
                              if (INPUT[y+1][x+0] == '|') wn++;
                              if (INPUT[y+1][x+1] == '|') wn++;

                              if (wn < 1 || ln < 1) tmp[y][x] = '.';

                              break;
                    default:
                              printf ("INVALID SQUARE %c at %d,%d\n", INPUT[y][x], y, x);
                              return -1 ;
                              break;
                }
            }
        }

        /* Save new map */
        for (int y = 0; y < HEIGHT+2; y++)
        {
            for (int x = 0; x < WIDTH+2; x++)
            {
                INPUT[y][x] = tmp[y][x];
            }
        }

        /* Print map */
        printf ("Minute %d\n", i);
        for (int y = 0; y < HEIGHT+2; y++)
        {
            for (int x = 0; x < WIDTH+2; x++)
            {
                printf ("%c", INPUT[y][x]);
            }
            printf ("%s", "\n");
        }

        /* Calculate score and hash*/
        int woods = 0;
        int lumberyard = 0;
        int hash = 0;
        for (int y = 1; y <= HEIGHT; y++)
        {
            for (int x = 1; x <= WIDTH; x++)
            {
                switch (INPUT[y][x])
                {
                    case '|': 
                        woods++; 
                        hash += 13 * y * x;
                        break;
                    case '#': 
                        lumberyard++; 
                        hash += 51 * y * x;
                        break;
                    case '.': 
                        hash += 79 * y * x;
                        break;
                    default:
                              printf ("INVALID CHAR %c at %d,%x\n", INPUT[y][x], y, x);
                }
            }
        }

        printf ("Score: %d\n", woods * lumberyard);
        scores[i] = woods * lumberyard;
        if (i == PART1_MIN)
        {
            part_1 = woods * lumberyard;
        }

        /* Check for repeat */
        hashes[i] = hash;
        for (int j = 0; j < i; j++)
        {
            if (hashes[j] == hashes[i])
            {
                cycle = i - j;
                cycle_start = j;
                goto end;
            }
        }
    }

end:
    printf ("Part 1: %d\n", part_1);
    printf ("Cycle is %d and starts at %d\n", cycle, cycle_start);
    int part2_index = cycle_start + (PART2_MIN - cycle_start) % cycle;
    printf ("Part 2 answer will occur at %d\n", part2_index);
    printf ("Part 2: %d\n", scores[part2_index]);
    return 0;
}

