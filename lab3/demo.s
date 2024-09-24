// By Daniel Detore, Elliott McKelvey
// I pledge my honor that I have abided by the Stevens Honor System.

.data
msg: .string "Hello World!\n" //create string to print later
len: .quad 14 // length of msg

.text
.global _start

_start:
// retrieve msg address
ADR X9, msg     // load *address* of msg into X9

// retrieve len
ADR X11, len     // load *address* of len into X11
LDR X12, [X11]   // load *value* of len into X12

// write(msg)
MOV X0, 1       // set status to 1, as we are about to print
MOV X1, X9     // MOV string from X10 to X1
MOV X2, X12     // Length of string we are going to print (= 13)
MOV X8, 64      // set up system call #64 for write()
SVC 0           // call the write() service

// exit()
MOV X0, 0       // set status to 0 since we're done
MOV X8, 93      // set up system call #93 for exit()
SVC 0           // call exit() service
