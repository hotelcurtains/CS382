// Author: Daniel Detore


// algorithm:
// root = n/2 + 1
// root = (((n / root) + root) / 2)
// root = (((n / root) + root) / 2)
// root = (((n / root) + root) / 2)
// root = (((n / root) + root) / 2)
// return root

.data
    00 = %%     // command line argument at address 00

.text
SUB R0 R0 R0    // we put the input at address 0
LDR R0 R0       // R0 = input n

DIV R1 R0 2     // R1 = input / 2
ADD R1 R1 1     // R1 = (input/2) + 1; R1 is now our seed guess (root)

// R0 = input
// R1 = root
// R2 = temp


// one step of the algorithm: root = (((n / root) + root) / 2)
DIV R2 R0 R1    // temp = input / root
ADD R2 R2 R1    // temp += root
DIV R2 R2 2     // temp /= root
MOV R2 R1       // root = temp

// repeat 3 more times for perfect integer approximation for all n in [0,255]
DIV R2 R0 R1    // temp = input / root
ADD R2 R2 R1    // temp += root
DIV R2 R2 2     // temp /= root
MOV R2 R1       // root = temp

DIV R2 R0 R1    // temp = input / root
ADD R2 R2 R1    // temp += root
DIV R2 R2 2     // temp /= root
MOV R2 R1       // root = temp

DIV R2 R0 R1    // temp = input / root
ADD R2 R2 R1    // temp += root
DIV R2 R2 2     // temp /= root

SUB R0 R0 R0    // STR only takes register so we need ro 0 R0 again
STR R2 R0 1     // store result into address 01

END