/**
 * Name: Daniel Detore
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System.
*/


.text
.global _start


lt:
MOV X10, X12        // L = m
ADD X10, X10, 1     // L = m+1
B loop              // continue

gt:
MOV X11, X12        // R = m
SUB X11, X11, 1     // R = m-1
B loop              // continue

count:                // while (X10 != "\0"):
MOV X2, 0             // X2 = 0
countloop:
    LDRB W10, [X1, X2]   // X10 = string[i]
    ADD  X2, X2, 1        // i++

    CBZ  X10, print       // if (string[i] = "\0") break;
    B    countloop        // else goto countloop;

_start:
/*
Using this algorithm from Wikipedia:
https://en.wikipedia.org/wiki/Binary_search#Procedure

L, R are search boundaries by index
n is the length of the array
T is the target value
arr is the array
m is the middle point of the search area

function binary_search(arr, n, T) is
    L := 0
    R := n − 1
    while L ≤ R do
        m := floor((L + R) / 2)
        if arr[m] < T then
            L := m + 1
        else if arr[m] > T then
            R := m − 1
        else:
            return m
    return unsuccessful
*/

ADR X18, target     // X18 = &target
LDR X18, [X18]      // X18 = target
ADR X8, arr         // X8 = &arr
ADR X9, length      // X9 = &length
LDR X9, [x9]        // X9 = length
MOV X10, 0          // X10 = 0 = L
MOV X11, X9         // X11 = length
SUB X11, X11, 1     // X11 = n-1 = R
MOV X12, 0          // X12 = m

loop:               // while (L leq R) do
CMP X10, X11
B.GT fail           // if we haven't gone to succeed and L>R we've failed

ADD X12, X10, X11   // m = L+R
ASR X12, X12, 1     // m /= 2
LSL X12, X12, 3     // m *= 8; length of a quadword
LDR X13, [X8, X12]  // X13 = arr[m]
ASR X12, X12, 3     // m /= 8; return m to index value

CMP X13, X18        // compare arr[m], target
B.LT lt             // L = m+1; goto loop;
B.GT gt             // R = m-1; goto loop;
B.EQ succeed        // if arr[m] = target then succeed


succeed:
ADR X1, msg1        // put &msg1 into X1 for printing
B count

fail:
ADR X1, msg2        // put &msg2 into X1 for printing
B count

print:              // assumes X1 and X2 are set
MOV X0, 1           // set status to 1, as we are about to print
MOV X8, 64          // set up system call #64 for write()
SVC 0               // call the write service

// exit()
MOV X0, 0           // set status to 0 since we're done
MOV X8, 93          // set up system call #93 for exit()
SVC 0               // call exit() service


/*
 * If you need additional data,
 * declare a .data segment and add the data here
 */
