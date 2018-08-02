#include <stdio.h>
#include <stdlib.h>

int fact(int n) {
  if(n <= 1) return n;
  else return n*fact(n-1);
}

int mymin(int x, int y) {
  if(x < y) return x;
  else return y;
}

int main(int argc, char **argv) {
  if(argc < 2) {
    printf("usage: %s <num>\n", argv[0]);
    exit(1);
  }
  int num = mymin(atoi(argv[1]), 6);
  printf("fact(%d): %d\n", num, fact(num));
  return 0;
}

