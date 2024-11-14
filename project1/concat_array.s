/*  
   Name: Daniel Detore
   Pledge: I pledge my honor that I have abided by the Stevens Honor System.
 */


.global concat_array


// char* concat_array(unsigned long int* arr, unsigned long int len);
concat_array:
SUB SP, SP, 48             // make room for X30, X8, X9, X17, X18
STR X30, [SP]              // store X30

// assume XO = arr[0], X1 = len
MOV X8, 0                  // X8 = output index
MOV X9, 0                  // X9 = array index
MOV X17, X0                // X17 = &arr[0]
LSL X18, X1, 3             // X18 = len(arr) * 8 = max byte offset of arr

convertloop:
   STR X8, [SP, 8]         // save output index
   STR X9, [SP, 16]        // save array index
   STR X17, [SP, 32]       // save &arr[0]
   STR X18, [SP, 40]       // save max index of arr

   LDR X0, [X17, X9]       // X0 = &arr[0] + array index
   BL itoascii             // X0 = itoascii(arr[i])

   LDR X8, [SP, 8]         // restore output index
   LDR X9, [SP, 16]        // restore array index
   LDR X17, [SP, 32]       // restore &arr[0]
   LDR X18, [SP, 40]       // restore max index of arr
   MOV X10, 32             // X10 = ascii space
   ADR X16, concat_array_outstr // X16 =  &concat_array_outstr[0]


   // for (char j : itoascii(arr[i])) output += char
   MOV X11, 0              // X11 = interator
   concatloop:
      LDRB W12, [X0, X11]  // X12 = j
      CBZ X12, concatend   // if (j == "\0") break
      STRB W12, [X16, X8]  // concat_array_outstr[output index] = j
      ADD X8, X8, 1        // output index++
      ADD X11, X11, 1      // iterator++
      B concatloop         // else continue

   concatend:
   STRB W10, [X16, X8]     // append space
   ADD X8, X8, 1           // output index++
   ADD X9, X9, 8           // array index += 8; long ints are 8 bytes long

   CMP X9, X18             // array index =? max index
   B.EQ convertend         // if (array index == max index) break
   B convertloop           // else continue

convertend:
STRB WZR, [X16, X8]        // concat_array_outstr[-1] = "\0"
ADR X0, concat_array_outstr // return &concat_array_outstr[0]

LDR X30, [SP]              // load X30
ADD SP, SP, 48              // move SP back
RET	                     // return 



.data
    /* Put the converted string into concat_array_outstrer,
       and return the address of concat_array_outstr */
    concat_array_outstr:  .fill 1024, 1, 0


