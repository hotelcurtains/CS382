#include <stdio.h>

/*
   Daniel Detore
   I pledge my honor that I have abided by the Stevens Honor System.
   State the sorting algorithm you chose in task 3
   State if you want to be considered for bonus points in task 3
*/

void copy_str(char* src, char* dst) {
    // i is out offset inside the strings
    int i = 0;
    loop:
        // copy this character from src to dst
        *(dst + i) = *(src + i);
        // move offset
        i++;
        // continue iterating through the strings until we reach the null terminator
        if (*(src + i) != '\0') goto loop;
}

int dot_prod(char* vec_a, char* vec_b, int length, int size_elem) {
    /* Your code here
       Do not cast the vectors directly, such as
       int* va = (int*)vec_a;
    */

    // offet into both vectors or which dimension we are multiplying
    int i = 0;
    // cumulative sum of corresponsing products
    int total = 0;
    sum:
        if (i == length) return total;
        // multiply corresponding dimensions of each vector
        total += *((int*) (vec_a) + i) * *((int*) (vec_b) + i);
        i++;
        goto sum;
}

void sort_nib(int* arr, int length) {
    char nibarr[length*8+1];
    unsigned int mask = 0x00000000;

    // iterates through arr items
    int k = 0;
    kloop:
        // i starts at 7 to move the mask to the last hex digit (nibble) first, then decreases
        int i = 7;
        // iterates through each int
        iloop:
            // shift the mask = (1111)2 into the appropriate hex digit (nibble)
            mask = 0xF << i*4;
            // do the masking, shift the hex digit (nibble) down into the least significant places, and place it in the appropriate spot
            nibarr[(k+1) * 8 - i - 1] = (mask & arr[k]) >> i*4;
            i--;
        if (i >= 0) goto iloop;
        k++;
    if (k < length*8) goto kloop;

    // let's do counting sort (Theta(n), optimal for lots of values with small range)

    // TODO
    

    
}


int main(int argc, char** argv) {

    /**
     * Task 1
     */

    char str1[] = "382 is the best!";
    char str2[100] = {0};

    copy_str(str1,str2);
    puts(str1);
    puts(str2);

    char str3[] = "";
    char str4[100] = {0};

    copy_str(str3,str4);
    puts(str3);
    puts(str4);

    /**
     * Task 2
     */

    int vec_a[3] = {12, 34, 10};
    int vec_b[3] = {10, 20, 30};
    int dot = dot_prod((char*)vec_a, (char*)vec_b, 3, sizeof(int));
    printf("%d\n",dot); //expecting 1100

    int vec_c[1] = {0};
    int vec_d[1] = {0};
    dot = dot_prod((char*)vec_c, (char*)vec_d, 1, sizeof(int));
    printf("%d\n",dot); //expecting 0

    int vec_e[0] = {};
    int vec_f[10] = {};
    dot = dot_prod((char*)vec_e, (char*)vec_f, 0, sizeof(int));
    printf("%d\n",dot); //expecting 0


    /**
     * Task 3
     */

    int arr[3] = {0x12BFDA09, 0x9089CDBA, 0x56788910};
    sort_nib(arr, 3);
    for(int i = 0; i<3; i++) {
        printf("0x%x ", arr[i]);
    }
    puts(" ");

    return 0;
}
