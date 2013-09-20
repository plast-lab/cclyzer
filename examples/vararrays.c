#include<stdlib.h>
#include<stdio.h>

void foo(int);

int main(void) {
  foo(17);
}

void foo(int n) {
  char s[n];

  for (int i = 0; i < n; i++)
    s[i] = i*i;
 

  printf("%d\n", s[n/2]);
}
