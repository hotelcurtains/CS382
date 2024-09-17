/**
Name: Daniel Detore
Partner (if any): Elliott McKelvey
Pledge: I pledge my honor that I have abided by the Stevens Honor System.
 */

#include <stdio.h>
#include <stdlib.h>

void int_to_nibble(int intarr[], int nint, unsigned char nibarr[], int nnibs) {

    unsigned int mask = 0x00000000;
    int k = 0;
    kloop:
        int i = 7;
        iloop:
            mask = 0xF << i*4;
            nibarr[(k+1) * 8 - i - 1] = (mask & intarr[k]) >> i*4;
            i--;
        if (i >= 0) goto iloop;
        k++;
    if (k < nnibs/8) goto kloop;
}

int main(int argc, char const *argv[]) {
    int arr[3] = {0x12BFDA09, 0x9089CDBA, 0x56788910};
    unsigned char nibs[24] = {0}; // Initialize all elements to 0;
    int_to_nibble(arr, 3, nibs, 24);
    for (int i = 0; i < 24; i ++) printf("%1hhX ", nibs[i]); // Print each nibble in hex
    return 0;
}