// Name: Daniel Detore
// Partner's name if any: Elliott McKelvey
// Pledge: I pledge my honor that I have abided by the Stevens Honor System

.text
.global _start
.extern printf


/* char _uppercase(char lower) */
_uppercase:
    /* Your code here 
    
        You must follow calling convention,
        and make this a procedure.
    
    */
    SUB SP, SP, 8       // make room for X30
    STR X30, [SP]       // store X30

    SUB X0, X0, 32      // "a" - 32 = "A"

    LDR X30, [SP]       // load X30
    ADD SP, SP, 8       // move SP back
    RET	                // return (lower - 32)


/* int _toupper(char* string) */
_toupper:
    /* Your code here 

        You must call _uppercase() for every character in string.
        Both loop and recursion are good.

        You must follow calling convention,
        and make this a procedure.

    */
    SUB SP, SP, 16          // make room for X30
    STR X30, [SP]           // store X30

    MOV X13, X0             // X13 = &str
    MOV X1, 0               // X1 = i

    // R0 = str[i]

    loop:
    LDRB W0, [X13, X1]      // W0 = str[i]
    CBZ  X0, postloop       // if (numstr[i] == "\0") break;
    
    BL _uppercase           // W0 = upper(str[i])

    STRB W0, [X13, X1]      // store upper(str[i]) into str[i]

    ADD  X1, X1, 1          // i++
    B    loop               //  goto loop;

    postloop:
    MOV X0, X1              // return len(str)
    LDR X30, [SP]           // load X30
    ADD SP, SP, 16          // move SP back
    RET	                    // return upper(str)

_start:

    /* You code here:

        1. Call _toupper() to convert str;
        2. Call printf() to print outstr to show the result.
    
    */

    ADR  X0, str            // X0 = &str
    BL _toupper             // upper(str)

    MOV X1, X0              // X1 = len(str)
    ADR X0, outstr          // X0 = &outstr
    ADR X2, str             // X2 = str


    //X0 = &outstr, X1 = i, X2 = &str
    BL printf               // printf()


    // exit
    MOV  X0, 0
    MOV  X8, 93
    SVC  0


.data
str:    .string   "helloworld"
outstr: .string   "Converted %ld characters: %s\n"

