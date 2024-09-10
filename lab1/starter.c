/*******************************************************************************
 * Filename   : starter.c
 * Authors    : Daniel Detore, Elliott McKelvey
 * Version    : 1.0
 * Date       : September 10, 2024
 * Description: A program that prints out the binary pattern of any 32-bit integer numbers.
 * Pledge     : I pledge my honor that I have abided by the Stevens Honor System.
 ******************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

void display(int8_t bit) {
    putchar(bit + 48);
}

void display_32(int32_t num) {
    unsigned int mask;
    for(int i = 31; i>=0; i--){
        mask = 1 << i;
        if ((num & mask) == 0) {display(0);}
        else {display(1);}
    }
    printf("\n");
}

int main(int argc, char const *argv[]) {
    display_32(382);
    display_32(-383);

    display_32(500);
    display_32(-501);

    return 0;
}