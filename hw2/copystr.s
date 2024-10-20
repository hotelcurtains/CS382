/**
 * Name: Daniel Detore
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System.
*/

.text
.global _start

_start:
ADR  X9, src_str      //  X9 = &src_str
ADR  X12, dst_str     // X12 = &dst_str
MOV  X13, 0           // int i = 0

loop:                 // while (X10 != "\0"):
LDRB W10, [X9, X13]   // X10 = src_str[i]
STRB W10, [X12, X13]  // store src_str[i] into addresss (&dst_str + i)
ADD  X13, X13, 1      // i++

CBZ  X10, exit        // if (src_str[i] = "\0") goto exit
B    loop             // else goto loop

exit:
MOV X0, 1           // set status to 1, as we are about to print
MOV X1, X12         // move &dst_str into X1 to print
MOV X2, X13         // Length of string we are going to print (= X11)
MOV X8, 64          // set up system call #64 for write()
SVC 0               // call the write service

MOV X0, 0           // set status to 0 since we're done
MOV X8, 93          // set up system call #93 for exit()
SVC 0               // call exit() service


/*
 * If you need additional data,
 * declare a .data segment and add the data here
 */
