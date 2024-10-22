# Basic Practice
For all the following questions, the name of a variable is also the label of it in the .data segment. You do not need to write the complete .text segment; only the assembly segment that is corresponding to the C statement.

Assume there are two integers a and b. Translate the following C statement into assembly:
a = a + b

```arm
ADR X10, a      // X10 = &a
LDR W12, [X10]  // X12 = a
ADR X11, b
LDR W11, [X11]  // X11 = b

ADD X12, X12, X11
STR W12, [X10]  // store a+b into &a
```

Assume there is an integer a. Translate the following C statement into assembly:
a ++
```arm
ADR X10, a      // X10 = &a
LDR W12, [X10]  // X12 = a

ADD X12, X12, 1
STR W12, [X10]  // store a+1 into &a
```

Assume there are two integers a and b. Translate the following C statement into assembly:
a = a * 8 - b
```arm
ADR X10, a      // X10 = &a
LDR W12, [X10]  // X12 = a
ADR X11, b
LDR W11, [X11]  // X11 = b

LSL X12, X12, 3 // a *= 2^3
SUB X12, X12, X11 // a -= b

STR W12, [X10]  // store a+b into &a
```

Assume there’s an integer array arr. Translate the following C statement into assembly:
arr[2] = arr[3] * 8 + 2
```arm
ADR X10, arr        // X10 = &arr
LDR W11, [X10, 12]  // X11 = &arr + 12 = arr[3]
LSL X11, X11, 3     // arr[3] *= 2^3
ADD X11, X11, 2     // arr[3] += 2
STR W11, [X10, 8]   // store arr[3]*8+2 into arr[2]
```

Assume there’s an integer array arr, and an integer variable f stored in register W4. Translate the following C statement into assembly:
arr[2] = arr[3] * f - 2
```arm
ADR X10, arr        // X10 = &arr
LDR W11, [X10, 12]  // X10 = arr[3]
MUL X11, X11, X4    // arr[3] *= f
SUB X11, X11, 2     // arr[3] -= 2
STR W11, [X10, 8]   // store arr[3]*f-2 into arr[2]
```

Assume there’s a long integer array arr, and a long integer f’s address stored in register X4. Translate
the following C statement into assembly:
arr[2] = arr[3] * f - 2
```arm
ADR X10, arr        // X10 = &arr
LDR W11, [X10, 12]  // X10 = arr[3]
MUL X11, X11, X4    // arr[3] *= f
SUB X11, X11, 2     // arr[3] -= 2
STR X11, [X10, 8]   // store arr[3]*f-2 into arr[2]
```

Assume there’s a long integer array arr. Translate the following C statement into assembly:
arr[2] = arr[3] * arr[4] - arr[5]
```arm
ADR X10, arr        // X10 = &arr
LDR X11, [X10, 24]  // X11 = arr[3]
LDR X12, [X10, 32]  // X12 = arr[4]
MUL X11, X11, X12   // arr[3] *= arr[4]
LDR X12, [X10, 40]  // X12 = arr[5]
SUB X11, X11, X12   // arr[3] -= arr[5]
STR X11, [X10, 16]  // arr[2] = arr[3] * arr[4] - arr[5]
```

Assume there’s a string line. Translate the following C statement into assembly:
line[12] = 0
```arm
ADR X10, line       // X10 = &line
MOV X11, 0          // X11 = 0
STR X11, [X10, 12]  // line[12] = 0
```

Assume there’s a string line . Translate the following C statement into assembly:
line[12] = line[28] + 28
```arm
ADR X10, line       // X10 = line
LDR X11, [X10, 28]  // X11 = line[28]
ADD X11, X11, 28    // line[28] += 28
STR X12, [X10, 12]  // line[12] = line[28] + 28
```

Given the following data segment, write assembly sequence to calculate the difference between two integers a and b :
```arm
.data
a: .int 10
b: .int 20
diff: .int 0
```

```arm
ADR X10, a
LDR X10, [X10]      // X10 = a
ADR X11, b
LDR X11, [X11]      // X11 = b
SUB X10, X10, X11   // X10 = a - b
LDR X12, diff       // X12 = &diff
STR X10, [X12]      // diff = a - b
```

Given the following data segment, write assembly sequence to calculate the difference between two long integer arrays a and b. You can assume the length is 3.
```arm
.data
a: .quad 10, 20, 30
b: .quad 20, 20, 10
diff: .quad 0, 0, 0
```

```arm
ADR X9, diff        // X9 = &diff
ADR X10, a          // X10 = &a
ADR X11, b          // X11 = &b
MOV X18, 0          // X18 = i

loop:
LDR X12, [X10, X18] // X12 = a[i]
LDR X13, [X11, X18] // X13 = b[i]
SUB X12, X12, X13   // X12 = a[i] - b[i]
STR X12, [X9, X18]  // diff[i] = a[i] - b[i]
ADD X18, X18, 1     // i++
CMP X18, 3
B.EQ exit           // if i = 3 break
B loop              // else continue

exit:
//...
```

Given the following data segment, write assembly sequence to copy the data in array a to array b. You
can assume the length is 3.
```arm
.data
a: .quad 10, 20, 30
b: .quad 0, 0, 0
```

```arm
ADR X10, a          // X10 = &a
ADR X11, b          // X11 = &b
MOV X18, 0          // X18 = i

loop:
LDR X12, [X10, X18] // X12 = a[i]
STR X12, [X11, X18] // b[i] = a[i]
CMP X18, 3
B.EQ exit           // if i = 3 break
B loop              // else continue

exit:
//...

```

Given the following data segment, write assembly sequence to move the data in array a to array b. Note that after the assembly sequence, array a should be all zeros. You can assume the length is 3.
```arm
.data
a: .quad 10, 20, 30
b: .quad 0, 0, 0
```
```arm
ADR X10, a          // X10 = &a
ADR X11, b          // X11 = &b
MOV X18, 0          // X18 = i
MOV X19, 0          // X19 = 0

loop:
LDR X12, [X10, X18] // X12 = a[i]
STR X12, [X11, X18] // b[i] = a[i]
STR X19, [X10, X18] // a[i] = 0
CMP X18, 3
B.EQ exit           // if i = 3 break
B loop              // else continue

exit:
//...
```


# Procedures

Translate the following C code into assembly, with correct calling conventions and procedure frame creation. You can assume both dog() and bunny() return long int and have been implemented correctly and properly. No comments needed.
Hint: be careful about register use.
```c
long int cat(long int purr) {
    return purr + dog () + bunny ();
}
```

```arm

```

Translate the following procedure in C, following correct calling convention:
```c
long int cat(long int purr) {
if (purr < 0) return dog() + 1;
else return bunny() + 1;
}
```

```arm

```


Translate the following procedure in C, following correct calling convention:
```c
void cat(long int purr) {
if (purr < 0) dog(purr + 1);
else bunny(purr + 1);
}
```

```arm

```

Translate the following procedure in C, following correct calling convention:
```c
long int cat(long int a, long int b) {
return dog(a) + bunny(b);
}
```

```arm

```

Translate the following procedure in C, following correct calling convention:
```c
long int cat(long int a, long int b) {
return dog(a) + bunny(b) + dog(b) + bunny(a);
}
```

```arm

```

Translate the following procedure in C, following correct calling convention:
```c
long int cat(long int a, long int b) {
if (dog(a) < dog(b)) return 1;
else return 0;
}
```

```arm

```

Translate the following procedure in C, following correct calling convention:
```c
long int cat(long int a, long int b) {
if (dog(a) < dog(b)) return bunny(b);
else return bunny(a);
}
```

```arm

```

Translate the following procedure in C, following correct calling convention:
```c
long int cat() {
return dog(bunny());
}
```

```arm

```
