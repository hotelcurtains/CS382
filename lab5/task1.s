// Name: Daniel Detore
// Partner's name if any: Elliott McKelvey
// Pledge: I pledge my honor that I have abided by the Stevens Honor System

.data
side_a: .quad 3
side_b: .quad 4
side_c: .quad 5
yes: .string "It is a right triangle.\n"
len_yes: .quad . - yes // Calculate the length of string yes
no: .string "It is not a right triangle.\n"
len_no: .quad . - no // Calculate the length of string no

.text
.global _start

succ:
// write(yes)
MOV X0, 1           // set status to 1, as we are about to print
ADR X1, yes         // load the address of yes into X1
ADR X2, len_yes     // load &len_yes into X2
LDR X2, [X2]        // Load len_yes into X2
MOV X8, 64          // set up system call #64 for write()
SVC 0               // call the write() service
B exit              // function is over, return to exit

fail:
// write(no)
MOV X0, 1           // set status to 1, as we are about to print
ADR X1, no          // load the address of no into X1
ADR X2, len_no      // load &len_no into X2
LDR X2, [X2]        // Load len_no into X2
MOV X8, 64          // set up system call #64 for write()
SVC 0               // call the write() service
B exit              // function is over, return to exit


_start:
ADR X9, side_a      // load &side_a into X9
LDR X9, [X9]        // load side_a into X9
ADR X10, side_b     // load &side_b into X10
LDR X10, [X10]      // load side_b into X10
ADR X11, side_c     // load &side_c into X11
LDR X11, [X11]      // load side_c into X11

MUL	X9, X9, X9      // X9 = a^2
MUL	X10, X10, X10   // X10 = b^2
ADD X10, X9, X10    // X10 = a^2 + b^2
MUL	X11, X11, X11   // X11 = c^2
SUB X12, X11, X10   // X12 = X11 - X10 = c^2 - (a^2 + b^2)

CBZ  X12, succ      // if 0  = X12, then a^2 + b^2  = c^2, so goto succ
CBNZ X12, fail      // if 0 != X12, then a^2 + b^2 != c^2, so goto fail

// exit()
exit:
MOV X0, 0           // set status to 0 since we're done
MOV X8, 93          // set up system call #93 for exit()
SVC 0               // call exit() service
