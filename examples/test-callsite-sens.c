#include <stdlib.h>

int* id(int *x) {
    return x;
}

int** alloc(int *x) {
    int **c = malloc(sizeof(int*));
    *c = x;
    return c;
}

int main(int argc, char *argv[])
{
    int c1;
    int c2;

    /* Under 1 Call-site Sens k1 should point to c1 and k2 to c2 */
    int *k1 = id(&c1);
    int *k2 = id(&c2);

    int **k3 = alloc(&c1);
    int **k4 = alloc(&c2);
    int *kd1 = *k3;
    int *kd2 = *k4;

    /* Under 1 Call-site Sens + Heap kd1 should point to c1 and kd2 to c2 */
    return 0;
}
