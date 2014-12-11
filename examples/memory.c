#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{
    int x, y, *p, **q;

    p = &x;
    q = &p;
    *q = &y;

    /* int *ptr; */

    /* ptr = malloc(sizeof(int)); */

    /* x = 5; */
    /* *ptr = x; */

    /* int y = *ptr; */

    /* if (y != x) */
    /*     return EXIT_FAILURE; */

    /* ptr = &x; */
    /* printf("%d", *ptr); */
    /* ptr = &argc; */

    return EXIT_SUCCESS;
}
