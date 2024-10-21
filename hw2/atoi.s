/**
 * Name: Daniel Detore
 * Pledge: I pledge my honor that I have abided by the Stevens Honor System.
 */

.text
.global _start

_start:

/* Add your code here */

MOV X9, 10                // X9 = 10, for MUL
MOV X10, 0                // X10 = i
MOV X12, 0                // X12 = number
ADR X13, numstr           // X13 = &numstr

loadloop:
    LDRB W14, [X13, X10]  // W14 = numstr[i]
    CBZ  W14, postloop    // if (numstr[i] = "\0") break;
    SUB  X11, X14, 48     // X11 = (int)numstr[i]
    MUL  X12, X12, X9     // X12 *= 10
    ADD  X12, X12, X11    // X12 += (int)numstr[i]
    ADD  X10, X10, 1      // i++
    B    loadloop         // else goto loadloop;

postloop:
    ADR X13, number       // X13 = &number
    STR X12, [X13]        // store number into &number

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






