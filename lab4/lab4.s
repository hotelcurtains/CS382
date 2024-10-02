// By Daniel Detore, Elliott McKelvey
// I pledge my honor that I have abided by the Stevens Honor System.

.data
// we assume vec1 and vec3 are always of length 3
vec1: .quad 10, 20, 30 // the first vector to find the dot product of
vec2: .quad 1, 2, 3    // the second vector to find the dot product of
dot:  .quad 0          // the result of the dot product

.text
.global _start

_start:
ADR X3, dot         // load *address* of dot into X2
LDR X2, [X3]        // load *value* of dot into X2

ADR X14, vec1       // load *address* of vec1 into X14
ADR X15, vec2       // load *address* of vec2 into X15

// doing sum += (vec1[0] * vec1[0])

LDR X10, [X14]      // load *value* of vec1[0] into X10

LDR X11, [X15]      // load *value* of vec2[0] into X11

MOV X12, 0          // set up temp destination for multiplications
MUL X12, X10, X11   // X12 ← vec1[0] * vec2[0]
ADD X2, X2, X12     // dot (X12) += vec1[0] * vec2[0]


// doing sum += (vec1[1] * vec1[1])
LDR X10, [X14, 8]   // load *value* of vec1[1] into X10

LDR X11, [X15, 8]   // load *value* of vec2[1] into X11

MOV X12, 0          // set up temp destination for multiplications
MUL X12, X10, X11   // X12 ← vec1[1] * vec2[1]
ADD X2, X2, X12     // dot (X12) += vec1[1] * vec2[1]

// doing sum += (vec1[2] * vec1[2])
LDR X10, [X14, 16]  // load *value* of vec1[2] into X10

LDR X11, [X15, 16]  // load *value* of vec2[2] into X11

MOV X12, 0          // set up temp destination for multiplications
MUL X12, X10, X11   // X12 ← vec1[2] * vec2[2]
ADD X2, X2, X12     // dot (X12) += vec1[2] * vec2[2]

STR X2, [X3]        // storing dot (X2) into its original memory address    


// exit()
MOV X0, 0           // set status to 0 since we're done
MOV X8, 93          // set up system call #93 for exit()
SVC 0               // call exit() service

