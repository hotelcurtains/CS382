
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

void display(int8_t bit) {
    putchar(bit + 48);
}

void display_32(int32_t num) {
    /* Your code here */
}

int main(int argc, char const *argv[]) {
    display_32(382);
    display_32(-383);
    return 0;
}