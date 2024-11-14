
/*  
   Name: Daniel Detore
   Pledge: I pledge my honor that I have abided by the Stevens Honor System.
 */


.global pringle
//.text
//.global _start

// helper labels
pcmp2:
CMP X11, 97                 // if (str[i] == "a" = 97)
B.EQ pcmp3                  // goto cmp3
STRB W10, [X13, X9]         // this is a % with no specifier; pstr[i] = %
//ADD X9, X9, 1               // i++
B pcontinuescan             // continue

pcmp3:
SUB X9, X9, 1               // i--; we are now overwriting the position of the %
arrtoascii:
  STR X0, [SP, 8]           // protect X0-X13. we're not using X14-X18.
  STR X1, [SP, 16]
  STR X2, [SP, 24]
  STR X3, [SP, 32]
  STR X4, [SP, 40]
  STR X5, [SP, 48]
  STR X6, [SP, 56]
  STR X7, [SP, 64]
  STR X8, [SP, 72]
  STR X9, [SP, 80]
  STR X10, [SP, 88]
  STR X11, [SP, 96]
  STR X12, [SP, 104]
  STR X13, [SP, 112]

  MOV X0, X1                // &arr goes in X0
  MOV X1, X2                // len(arr) goes in X1
  BL concat_array           // X0 = &string(arr)

  LDR X9, [SP, 80]          // X9 = iterator for pstr
  LDR X13, [SP, 112]        // X13 = &pstr
  MOV X8, 0                 // X8 = string(arr) iterator
  insertarr:
    LDRB W10, [X0, X8]      // X10 = string(arr)[j]
    CBZ X10, continuearrtoascii // if (string(arr)[i] == "\0") break
    ADD X8, X8, 1           // j++
    STRB W10, [X13, X9]     // pstr[i] = string(arr)[j]
    ADD X9, X9, 1           // i++
    
    B insertarr             // else continue
    
  continuearrtoascii: 
  LDR X0, [SP, 8]             // load X0-X13. we're not using X14-X18.
  LDR X1, [SP, 16]
  LDR X2, [SP, 24]
  LDR X3, [SP, 32]
  LDR X4, [SP, 40]
  LDR X5, [SP, 48]
  LDR X6, [SP, 56]
  LDR X7, [SP, 64]
  LDR X10, [SP, 88]
  LDR X11, [SP, 96]
  LDR X12, [SP, 104]


  MOV X1, X3                  // increment all arguments so we can format iteratively
  MOV X2, X4
  MOV X3, X5
  MOV X4, X6

  ADD X12, X12, 1

B pcontinuescan             // continue

//_start:
pringle:

// X0 = &fstr
// X1, 3, 5 = &arr_n
// X2, 4, 6 = len(arr_n)


//ADR X0, str
//ADR X1, arr1
//MOV X2, 3
//ADR X3, arr2
//MOV X4, 1
//ADR X5, arr3
//MOV X6, 5


SUB SP, SP, 120
STR X30, [SP]

MOV X9, 0                   // X9 = iterator for output string
MOV X12, 0                  // X12 = iterator for format string
ADR X13, pstr               // X13 = &pstr
pscanloop:
  LDRB W10, [X0, X12]       // X10 = str[i]
  STRB W10, [X13, X9]       // pstr[i] = str[i]
  ADD X9, X9, 1             // i++
  ADD X12, X12, 1           // i++
  LDRB W11, [X0, X12]        // X11 = str[i]
  
  // if ((X10 == "%") && (X11 == "a")) output++
  CMP X10, 37               // if (str[i-1] == "%" = 37)
  B.EQ pcmp2                // goto cmp2

  pcontinuescan:
  CBZ X10, pendscan         // if (i == "\0") break
  B pscanloop               // else continue

pendscan:

MOV X0, 1       // set status to 1, as we are about to print
ADR X1, pstr    // X1 = &pstr
MOV X2, X9      // X2 = len(pstr)
MOV X8, 64      // set up system call #64 for write()
SVC 0           // call the write() service

MOV X0, X9      // return len(pstr)
SUB X0, X0, 1   // exclude null terminator

LDR X30, [SP]
ADD SP, SP, 120
RET



/*
    Declare .data here if you need.
*/

.data
  pstr: .fill 1024, 1, 0
  //str: .string "Hello this is a test string for %a and %%%a and %% and %a.\n"
  //arr1: .quad 123,456,7890
  //arr2: .quad 12
  //arr3: .quad 0,0,0,0,5

