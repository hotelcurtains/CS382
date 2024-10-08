// Name: Daniel Detore
// Partner's name if any: Elliott McKelvey
// Pledge: I pledge my honor that I have abided by the Stevens Honor System

.text
.global _start
.extern scanf

succ:
// write(yes)
MOV X0, 1           // set status to 1, as we are about to print
ADR X1, yes         // load the address of yes into X1
ADR X2, len_yes     // load &len_yes into X2
LDR X2, [X2]        // load len_yes into X2
MOV X8, 64          // set up system call #64 for write()
SVC 0               // call the write() service
B exit              // function is over, return to exit

fail:
// write(no)
MOV X0, 1           // set status to 1, as we are about to print
ADR X1, no          // load the address of no into X1
ADR X2, len_no      // load &len_no into X2
LDR X2, [X2]        // load len_no into X2
MOV X8, 64          // set up system call #64 for write()
SVC 0               // call the write() service
B exit              // function is over, return to exit


_start:
    
    ADR   X0, fmt_str   // Load address of formated string
    ADR   X1, left      // Load &left
    ADR   X2, right     // Load &right
    ADR   X3, target    // Load &target
    BL    scanf         // scanf("%ld %ld %ld", &left, &right, &target);

    ADR   X1, left      // Load &left
    LDR   X1, [X1]      // Store left in X1
    ADR   X2, right     // Load &right
    LDR   X2, [X2]      // Store right in X2
    ADR   X3, target    // Load &target
    LDR   X3, [X3]      // Store target in X3

    CMP   X1, X3        // compare left and target
    B.GE  fail          // if left > target goto fail

    CMP   X3, X2        // compare target and right
    B.GE  fail          // if target > right goto fail

    B     succ          // both checks passed, so goto succ

exit:
    MOV   X0, 0        // Pass 0 to exit()
    MOV   X8, 93       // Move syscall number 93 (exit) to X8
    SVC   0            // Invoke syscall

.data
    left:    .quad     0
    right:   .quad     0
    target:  .quad     0
    fmt_str: .string   "%ld%ld%ld"
    yes:     .string   "Target is in range\n"
    len_yes: .quad     . - yes  // Calculate the length of string yes
    no:      .string   "Target is not in range\n"
    len_no:  .quad     . - no   // Calculate the length of string no
