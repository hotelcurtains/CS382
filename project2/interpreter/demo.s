// Author: Daniel Detore
// Meaningless driver to show off the Sqrtr.

.data
    // just throwing in some data
    8: 1 2 3 4 5 6
    0f: 07 08
    0 = ff
    ff = 19
    aa = 21

.text
// logisim starts with all registers = 0,
// but it won't clear them for you when the program finishes.
// don't assume they're 0 unless the user will surely restart the simulation first.
    DIV R0 R0 0         // R0 = 0
    
    LDR R1 R0 12        // R1 = 5
    LDR R2 R1 R1        // R2 = *(10) = 3
    ADD R1 R1 R2        // R1 = 8
    LDR R3 R1           // R3 = 1
    DIV R1 R1 R3        // R1 = 8
    DIV R1 R1 R2        // R1 = 2
    ADD R1 R1 10        // R1 = 12
    STR R1 R1           // 0c = 12
    STR R3 R1 16        // 1c = 1
    END

    // showing that END works. 
    // this instruction won't be read, and the interpreter will warn you.
    ADD R3 R3 255