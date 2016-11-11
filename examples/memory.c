#include <stdio.h>
#include <stdlib.h>

int *ep;
/* global_alloc@ep --> null */

int ep2;
int **ep3;

void foo();
void bar(int);

int main(int argc, char *argv[])
{
    int xarr[8];
    int yarr[argc];
    int x, y, *p, **q;

    p = &x;
    /* stack_alloc@main[i32** %p] --> stack_alloc@main[i32* %x] */

    q = &p;
    /* stack_alloc@main[i32*** %q] --> stack_alloc@main[i32** %p] */

    *q = &y;
    /* stack_alloc@main[i32** %p] --> stack_alloc@main[i32* %y] */

    int *ptr;

    ptr = malloc(sizeof(int));
    /* stack_alloc@main[i32** %ptr] --> heap_alloc@main[...] */
    /* stack_alloc@main[i32** %ptr] --> typed_heap_alloc@main[...] */

    x = 5;
    *ptr = x;

    y = *ptr;

    if (y != x)
        return EXIT_FAILURE;

    ptr = &x;
    /* stack_alloc@main[i32** %ptr]  --> stack_alloc@main[i32* %x] */

    printf("%d", *ptr);
    ptr = &argc;
    /* stack_alloc@main[i32** %ptr] --> stack_alloc@main[i32* %argc.addr] */

    int *ptr2 = yarr;
    /* stack_alloc@main[i32** %ptr2] --> stack_alloc@main[i32* %vla] */

    foo();
    bar(argc > 2);
    return EXIT_SUCCESS;
}

void *f1() {            /* constant address */
    int *ptr = (int *) 0xabcd;
    /* stack_alloc@f1[i32** %ptr] --> unknown  */
    return ptr;
}

void *f2() {            /* global pointer */
    int *ptr = ep;
    /* stack_alloc@f2[i32** %ptr] --> heap_alloc@foo[...] */
    /* stack_alloc@f2[i32** %ptr] --> typed_heap_alloc@foo[...] */
    /* stack_alloc@f2[i32** %ptr] --> unknown */
    /* stack_alloc@f2[i32** %ptr] --> null */

    int *ptr2 = &ep2;
    /* stack_alloc@f2[i32** %ptr2] --> global_alloc@ep2 */

    int val = *ep;
    /* stack_alloc@f2[i32* %val] --> unknown */

    int val2 = ep2;
    /* stack_alloc@f2[i32* %val2] --> global_alloc@ep */
    return ptr;
}

void *f3() {            /* malloc */
    int *ptr = malloc(100 * sizeof(int));
    /* stack_alloc@f3[i32** %ptr] --> heap_alloc@f3[...] */
    return ptr;
}

void *f4(int *ptr) {    /* pointer arithmetic */
    return ptr + 5;
}

void *f5() {            /* function pointers */
    void *(*fp)(int*);
    void *(*alloc)(size_t);

    fp = &f4;
    /* stack_alloc@f5[i8* (i32*)** %fp] --> global_alloc@f4 */

    alloc = &malloc;
    /* stack_alloc@f5[i8* (i64)** %alloc] --> global_alloc@malloc */

    /* Call function through pointer */
    (*fp)(&ep2);
    /* stack_alloc@f4[i32** %ptr.addr] --> global_alloc@ep2 */

    return fp;
}

void *f6() {
    int **array = malloc(10 * sizeof(int *)); /* 1 */

    for (int i = 0; i < 10; i++)
        array[i] = malloc(100 * sizeof(int)); /* 7 */

    array[0] = malloc(200 * sizeof(int)); /* 17 */
    array[2] = malloc(400 * sizeof(int)); /* 21 */
    *array = malloc(300 * sizeof(int));   /* 25 */

    int *pos1 = array[2];       /* 21,7 */
    int *pos2 = array[0];       /* 17,25,7 */
    int *pos3 = *array;         /* 17,25,7 */

    int j = *pos3;
    int *pos4 = array[j];       /* 17,21,25,7 */

    return array;
}

void foo() {
    void *p, *q, *r, *s, *t;

    p = f1();
    /* stack_alloc@foo[i8** %p] --> unknown */

    ep = malloc(sizeof(int));
    /* global_alloc@ep --> heap_alloc@foo[..] */
    /* global_alloc@ep --> typed_heap_alloc@foo[..] */

    ep = (int *) p;
    /* global_alloc@ep --> unknown */

    ep2 = (int) &ep;
    /* global_alloc@ep2 --> global_alloc@ep */

    *ep3 = ep;

    q = f2();
    /* stack_alloc@foo[i8** %q] --> heap_alloc@foo[...] */
    /* stack_alloc@foo[i8** %q] --> typed_heap_alloc@foo[...] */
    /* stack_alloc@foo[i8** %q] --> unknown */
    /* stack_alloc@foo[i8** %q] --> null */

    r = f3();
    /* stack_alloc@foo[i8** %r] --> heap_alloc@f3[...]  */

    s = f4(q);                  /*  */
    /* stack_alloc@f4[i32** %ptr.addr] --> heap_alloc@foo[...] */
    /* stack_alloc@f4[i32** %ptr.addr] --> typed_heap_alloc@foo[...] */
    /* stack_alloc@f4[i32** %ptr.addr] --> unknown */
    /* stack_alloc@f4[i32** %ptr.addr] --> null */
    /* stack_alloc@foo[i8** %s] --> typed_heap_alloc@foo[i32 %call1][5] */

    t = f5();
    /* stack_alloc@foo[i8** %t] --> global_alloc@f4 */

    int **u = f6();
    /* stack_alloc@foo[i32*** %u] --> heap_alloc@f6[..first..] */

    int *u0 = *u;               /* 17,25,7 */
    int *u1 = u[1];             /* 7 */
}

void bar(int cond) {
    int x, y, *ptr;

    ptr = cond > 0 ? &x : &y;
    /* stack_alloc@bar[i32** %ptr] --> stack_alloc@bar[i32* %x] */
    /* stack_alloc@bar[i32** %ptr] --> stack_alloc@bar[i32* %y] */
}
