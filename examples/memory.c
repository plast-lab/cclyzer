#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
    int xarr[8];
    int yarr[argc];
    int x, y, *p, **q;

    p = &x;
    q = &p;
    *q = &y;

    int *ptr;

    ptr = malloc(sizeof(int));

    x = 5;
    *ptr = x;

    y = *ptr;

    if (y != x)
        return EXIT_FAILURE;

    ptr = &x;
    printf("%d", *ptr);
    ptr = &argc;

    int *ptr2 = yarr;

    return EXIT_SUCCESS;
}
