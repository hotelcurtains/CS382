/*  
   Name: Daniel Detore
   Pledge: I pledge my honor that I have abided by the Stevens Honor System.
 */

.global count_specs

// helper labels
cmp2:
CMP X6, 97                  // if (str[i] == "a" = 97)
B.EQ cmp3                   // goto cmp3
B continuescan              // else continue

cmp3:
ADD X1, X1, 1               // output++
B continuescan              // continue



// start of function
count_specs:
SUB SP, SP, 8               // make room for X30
STR X30, [SP]               // store X30

// assume X0 = &str
MOV X1, 0                   // X1 = output
MOV X4, 0                   // X4 = iterator for the string
scanloop:
    LDRB W5, [X0, X4]       // X5 = str[X4]
    ADD X4, X4, 1           // i++
    LDRB W6, [X0, X4]       // X6 = str[X4]
    
    // if ((X5 == "%") && (X6 == "a")) output++
    CMP X5, 37              // if (str[i-1] == "%" = 37)
    B.EQ cmp2               // goto cmp2

    continuescan:
    CBZ X5, endscan         // if (i == "\0") break
    B scanloop              // else continue

endscan:
MOV X0, X1                  // X0 = output

LDR X30, [SP]               // load X30
ADD SP, SP, 8               // move SP back
RET	                        // return 



/*
    Declare .data here if you need.
*/



