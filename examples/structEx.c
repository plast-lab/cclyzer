#include <stdio.h>
#include <stdlib.h>

struct RT {
  char A;
  int B[10][20];
  char C;
};
struct ST {
  int X;
  double Y;
  struct RT Z;
};

char foo(struct ST *s) {
    int i = 1;
    i = i+2;
  return s[1].Z.C;
}
