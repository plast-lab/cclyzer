#include <stdio.h>

typedef struct {
    int **y;
    int *x;
} inner2;

typedef inner2 inner;

typedef struct {
    int *g;
    inner in[3];
} outer;

typedef struct {
    inner in[3];
} outer2;


int *ep1, *ep2, *ep3, *ep4;

inner gl = {&ep1, NULL};
int **ga[] = {&ep1, &ep2, &ep3};
int **arr[][3] = {
    {&ep1, &ep2, &ep3},
    {&ep3, &ep2, &ep1},
    {&ep2, &ep3, &ep1},
};

void foo(outer o, int i) {
    o.in[i].y = &ep4;
}

int main(int argc, char *argv[])
{
    int **larr[][3] = {
        {&ep1, &ep2, &ep3},
        {&ep3, &ep2, &ep1},
        {&ep2, &ep3, &ep1},
    };

    arr[2][1] = &ep3;
    larr[1][2] = NULL;
    arr[2][1] = NULL;

    int p = (int []) {1, 2, 3}[2];

    outer o;
    int z1 = 5, z2 = 6, z3 = 7;
    int zzz1, zzz2, zzz3, zzz4;

    printf("%d\n" , z1);

    ep1 = &z1;
    ep2 = &z2;
    ep3 = &z3;

    o.in[2].x = ep1;
    o.in[0].x = ep2;
    o.in[argc].x = ep3;

    *(o.in[2].x) = 3;
    printf("%d\n" , z1);

    inner i1, i2, i3, i4;
    i1.x = &zzz1;
    i2.x = &zzz2;
    i3.x = &zzz3;
    i4.x = &zzz4;

    o.in[2] = i1;
    o.in[0] = i2;
    o.in[argc] = i3;
    o.in[1] = i4;

    int **ptr1 = &(o.in[2].x);
    int *p1 = *ptr1;              /* points-to: {z1, z3, zzz1, zzz3} */

    int **ptr2 = &(o.in[0].x);    /* points-to: {z2, z3, zzz2, zzz3} */
    int *p2 = *ptr2;

    int **ptr3 = &(o.in[argc].x); /* points-to: {z1, z2, z3, zzz1, zzz2, zzz3, zzz4} */
    int *p3 = *ptr3;
    /* outer oo[4]; */

    /* oo[2].in[2].y = &ep; */

    outer2 w, *wp;

    wp = &w;
    void *ptr4 = &(w.in[2]);      /* w[0 0][0 2] */
    void *ptr5 = wp;              /* w */
    void *ptr6 = &wp[2];          /* w[2] */
    void *ptr7 = &(wp[2].in[2]);  /* w[2][0 0][0 2] */
    void *ptr8 = &wp[0];          /* w[0] */
    void *ptr9 = &(wp[0].in[2]);  /* w[0][0 0][0 2] */
    void *ptr10 = &(wp[0].in[0]); /* w[0][0 0][0 0] */
    void *ptr11 = &(wp->in[0]);   /* w[0][0 0][0 0] */


    foo(o, 2);

    return 0;
}
