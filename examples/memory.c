#include <stdio.h>
#include <stdlib.h>

int *ep;
int ep2;
int **ep3;

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

void *f1() {            /* constant address */
    int *ptr = (int *) 0xabcd;
    return ptr;
}

void *f2() {            /* global pointer */
    int *ptr = ep;
    int *ptr2 = &ep2;
    int val = *ep;
    int val2 = ep2;
    return ptr;
}

void *f3() {            /* malloc */
    int *ptr = malloc(100 * sizeof(int));
    return ptr;
}

void *f4(int *ptr) {
    return ptr + 5;
}

void *f5() {
    void *(*fp)(int*);
    void *(*alloc)(size_t);

    fp = &f4;
    alloc = &malloc;

    /* Call function through pointer */
    (*fp)(&ep2);

    return fp;
}

void *f6() {
    int **array = malloc(10 * sizeof(int *));

    for (int i = 0; i < 10; i++)
        array[i] = malloc(100 * sizeof(int));

    return array;
}

void foo() {
    void *p, *q, *r, *s, *t;

    p = f1();

    ep = malloc(sizeof(int));
    ep = (int *) p;

    ep2 = (int) &ep;
    *ep3 = ep;

    q = f2();
    r = f3();
    s = f4(q);                  /*  */
    t = f5();

    int **u = f6();

    int *u0 = *u;               /*  */
    int *u1 = u[1];             /*  */
}

void bar(int cond) {
    int x, y, *ptr;

    ptr = cond > 0 ? &x : &y;
}
