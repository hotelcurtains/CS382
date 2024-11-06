
/*  
   Name: Daniel Detore
   Pledge: I pledge my honor that I have abided by the Stevens Honor System.
 */

.global itoascii

// char* itoascii(unsigned long int number);
itoascii:
   SUB SP, SP, 8           // make room for X30
   STR X30, [SP]           // store X30

   // X0 = number
   MOV X1, X0              // X1 = number
   MOV X5, 0               // X5 = length of number
   count:                  // iteratively count the amount of digits in number
      UDIV X1, X1, 10      // num /= 10
      ADD X5, X5, 1        // length++
      CBZ X1, stopcount    // if (num = 0) break
      B count              // else continue

   stopcount:
   MOV X10, 0               // X10 = i = 0, i < amount of digits in number
   ADR X11, buffer          // X11 = &buffer

   separate:
      // X1 = number without least decimal digit
      MOV X1, X0            // X1 = number
      UDIV X1, X1, 10       // X1 = floor(number/10)
      MUL X1, X1, 10        // X1 = floor(number/10)*10

      // X1 = only least decimal digit of number
      SUB X1, X0, X1        // remove all digits except 1s from X1

      // X1 = char(X1)
      ADD X1, X1, 48        // 0 + 48 = "0"

      MOV X4, 0             // X4 = storage offset
      SUB X4, X5, X10       // X4 = len(number) - i
      STR X1, [X11, X4]     // store char[i] into buffer[i]

      DIV X0, X0, 10        // number /= 10
      ADD X10, X10, 1       // i++
      CBZ X0, stopsep       // if (number = 0) break
      B    separate         // else continue

   stopsep:
      

   exit:
      MOV  X0, 0
      MOV  X8, 93
      SVC  0



   LDR X30, [SP]           // load X30
   ADD SP, SP, 8           // move SP back
   RET	                  // return 


.data
    /* Put the converted string into buffer,
       and return the address of buffer */
    buffer: .fill 128, 1, 0


