// Author: Daniel Detore


// algorithm:
// root = n/2 + 1
// root = (((n / root) + root) / 2)
// root = (((n / root) + root) / 2)
// root = (((n / root) + root) / 2)
// root = (((n / root) + root) / 2)
// return root

.data
    00 = 40     // input at address 00
    04: 50 60 70 aa bb cc

.text
DIV R0 R0 0     // we put the input at address 0
LDR R0 R0       // R0 = input n

DIV R1 R0 2     // R1 = input / 2

// R0 = input
// R1 = root
// R2 = temp

// one step of the algorithm: root = (((n / root) + root) / 2)
DIV R2 R0 R1    // temp = input / root
ADD R2 R2 R1    // temp += root
DIV R2 R2 2     // temp /= 2

// R1 = temp
// R2 = root
DIV R1 R0 R2    // temp = input / root
ADD R1 R1 R2    // temp += root
DIV R2 R2 2     // temp /= 2

// R1 = root
// R2 = temp
DIV R2 R0 R1    // temp = input / root
ADD R2 R2 R1    // temp += root
DIV R2 R2 2     // temp /= 2


DIV R0 R0 0     // STR only takes register so we need to reset R0 again
STR R2 R0 1     // store result into address 01



END

