#include <stdio.h>

/*
   Daniel Detore
   I pledge my honor that I have abided by the Stevens Honor System.
   Counting sort
   I want to be considered for bonus points in part 3
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
        *(dst + i) = '\0';
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
    // amount of nibs we're working with
    int nnibs = length * 8;
    unsigned char nibarr[length * 8];
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
    if (k < length) goto kloop;

    // let's do counting sort 
    // here it's Theta(n) and it's optimal for lots of values with small range (e.g. 0-15)

    // the largest nibble possible is 0xF = (15)2 so we know the size = (16)2
    // and we can set all counts to zero sinze we haven't counted yet
    int count[16] = {0};

    // do the actual counting of counting sort
    i = 0; //iterates through nibarr
    counting:
        count[nibarr[i]]++;
        i++;
        if (i < nnibs) goto counting;

    // replace each element with its cumulative sum
    i = 1; //iterates through count
    cumsum:
        count[i] += count[i - 1];
        i++;
        if (i < 16) goto cumsum;

    // ready output array
    unsigned char output[nnibs];
    i = 0; //iterates through output
    initoutput:
        output[i] = 0;
        i++;
        if (i<nnibs) goto initoutput;

    // move elements to output
    i = length*8-1; //iterates backwards through nibarr
    moveout:
        output[count[nibarr[i]] - 1] = nibarr[i];
        count[nibarr[i]]--;
        i--;
        if (i >= 0) goto moveout;
    

    // output now contains all of the nibbles in ascending order!
    // let's turn them back into ints


    // reset arr to all 0s
    i = 0; //iterates through arr
    zeroarr:
        arr[i] = 0;
        i++;
        if (i<length) goto zeroarr;

    k = 0; // iterates through arr items
    kloop2:
        // i iterates from 0 to seven to move from the most to least significant hex digit
        i = 0; // iterates through 8 nibbles in output
        iloop2:
            arr[k] = (arr[k] << 4) + output[(k*8) + i];
            i++;
        if (i < 8) goto iloop2;
        k++;
    if (k < length) goto kloop2;
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
