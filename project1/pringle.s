
/*  
   Name: Daniel Detore
   Pledge: I pledge my honor that I have abided by the Stevens Honor System.
 */


.global pringle

pringle:


// X0 = &str
// X1, 3, 5, 7 = &arr_n
// X2, 4, 6 = len(arr_n)
// SP


SUB SP, SP,  8             // make room for X30
STR X30, [SP]              // store X30



LDR X30, [SP]              // load X30
ADD SP, SP, 48             // move SP back
RET	                       // return 


/*
    Declare .data here if you need.
*/
