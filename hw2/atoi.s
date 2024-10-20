/**
 * Name: Daniel Detore
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System.
 */

.text
.global _start

_start:

/* Add your code here */

/* Do not change any part of the following code */
exit:
    MOV  X0, 1
    ADR  X1, number
    MOV  X2, 8
    MOV  X8, 64
    SVC  0
    MOV  X0, 0
    MOV  X8, 93
    SVC  0
    /* End of the code. */


/*
 * If you need additional data,
 * declare a .data segment and add the data here
 */






