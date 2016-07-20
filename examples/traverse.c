#include <stdio.h>

typedef struct {
    int **y;
    int *x;
} _inner;

typedef _inner inner;

typedef struct {
    int *g;
    inner in[3];
} outer;

void traverse(outer *o) {
    static int sss = 5;

    inner *in = &(o->in[0]);

    for (size_t i = 0; i < 3; i++) {
        in->x = &sss;
        in++;
        sss += 3;
    }
}

int main(int argc, char *argv[])
{
    outer o2;
    traverse(&o2);

    return 0;
}
