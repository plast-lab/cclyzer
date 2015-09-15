#include <stdio.h>

typedef struct {
    int *x;
    int **y;
} inner ;

typedef struct {
    int *g;
    inner in[3];
} outer;


int *ep;

int main(int argc, char *argv[])
{
    outer o;
    int z = 5;

    printf("%d\n" , z);

    ep = &z;

    o.in[2].x = ep;

    *o.in[2].x = 3;
    printf("%d\n" , z);

    outer oo[4];

    oo[2].in[2].y = &ep;
    return 0;
}
