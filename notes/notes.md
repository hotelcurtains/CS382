1-time 3-day extension, no questions asked. submit the form on canvas at least a few horus before the deadline.

[class notes](https://stevens0-my.sharepoint.com/:o:/g/personal/shao14_stevens_edu/EusjhIxWjCBNg3XbnfM_uoUBdCeVBiEvmpQzYifPEVDy6A?e=X4YIWA)

data sizes for 64-bit systems:

![common data sizes for 64-bit systems](image.png)

- MSB = most significant bit
- LSB = least significant bit
- to turn part of an unsigned byte into a full byte, you do zero extension which is just adding zeros in the most significant place until it's 8 bits long
- unsigned bits have a range of [0, 255]
- for signed numbers
  - have a range of [127, -128]
  - the most significant bit is actually negative, then you add the rest together like normal
  - the signed bit is NOT just a negative sign; it is a place with a negative value
  - we know if a number is signed or not from context, there is nothing in the number that nets us know
    - for a number with a leading 0 it doesn't matter; 0100 = 4 whether it's signed or unsigned
    - we only need to worry if it leads with a 1; 1011 = 11 or -5
- for a signed number with d bits, its range is [-2ᵈ⁻¹ , 2ᵈ⁻¹-1]
- when doing zero extension for signed numbers
  - the most significant bit is changing along with its value so we need to make sure the og value is preserved
    - e.g. 1011 = -5 ≠ 10001011 = -117
  - instead we'll append ones
    - e.g. 1011 = -5 = 11111011 = -5
- so when we do sign extension, we duplicate the MSB to the front
  - therefore zero and sign extension are the same thing, as long as you're dealing with signed numbers
  - for unsigned numbers it needs to always be zeros

# 9/9
- how do we go from +5 to -5?
  - we know for them to be sign opposites, the binary representations of +5 and -5 must add to 0
  - remember two's compliment:
  - +5 = 0101
  - flip all bits: 1010
    - 0101 + 1010 = 1111 = -1
  - add 1: -5 = 1011
    - 0101 + 1011 = 0000 = 0 ✓
  - ∴ 1011 is the two's compliment of 0101
  - from negative back to positive you are still *adding* 1

## shifting
- logical shift left (LSL):
  - take `1011` and shift it left one bit, or `LSL(1)`:
    - we can't shift the MSB left since we only have 4 bits, so we discard it
    - we get `0110`
  - 1011 → LSL(3) → 1000
  - each LSL(n) multiplies the value by 2ⁿ
    - until you shift it out of the byte you have and it becomes 0
  - shifting is much quicker & easier for the computer than multiplication, so sometimes it will rewrite multiplication by powers of 2 as shifting
    - e.g. `a * 8` → `a << 3`
- logical shift right (LSR):
  - same idea; move right, discard anything shifted out of the byte, pad 0s
  - 1011 → LSR(2) → 0010
  - each LSR(n) divides the value by 2ⁿ
- arithmetic shift right (ASR):
  - preserves the MSB (signed or not)
    - still moves it though, then pads with copies of MSB
  - 1011 → ASR(2) → 1110

## logic operators
- &&, ||, ! = and, or, not
  - these are logical operators that produce true/false
- &, |, ~ = and, or, not
  - these are bitwise operators that produce binary numbers from binary numbers
  - performs the operation on each corresponding bit of its operand/s and makes a new number as a result
  - a = 1011
  - b = 0101
  - a & b = 0001
  - a | b = 1111
  - ~a = 0100
- now say we have char a = -5 and char b = 3
  - a = 1111011, b = 00000011
  - a|b = 11111011 = -5
- masking - preserving some bits and setting the rest to 0
  - we only care about, per se, the 3rd 4th and 6th bits of a
  - make a new variable mask = 00110100, with 1s is the places you care about and 0s everywhere else
  - now do `a & mask`
    - it will preserve the bits of mask that are 1 and destroy the 0s
  - can be used to check if a specific bit is 0 or 1 by masking it to only that one bit and checking if it's = 0 or not
    - useful if you are storing a bunch of information in one byte to single out one bit of it

## hexidecimal
- starts with `0x` so we know it's hex
- number contains 0-9 then A-F
- 9 = 1001 = 0x9
- 16 = 1111 = 0xF
- each hex digit represents a nibble (4 bits) of binary
- 1010 1111 1100 = 0xAFC
- 1011111100 → 10 1111 1100 ...
  - we need to extend the first group
  - for that, we need to know if this is signed or not
    - if we don't know then it's over
  - assuming it's unsigned, 0010 1111 1100 = 0x2FC
  - if it's signed, 1110 1111 1100 = 0xEFC
  - there are no negative numbers in hex

# 9/10 lab
- c will translate decimal into binary for you when you assign a value to a variable
- a string in a `char*`
- output by `printf("Hello, %d\n", 382)` = `Hello, 382`
- compile your code with `gcc <some_file>.c -o <name_of_output>`
- run it with `./<name_of_output>`

# 9/11
- carry - the truncated place(s) when unsigned binary addition make a number too big to fit into its size
- positive/negative overflow - truncated place(s) when signed binary addition is too big/small for its size
- byte-addressed memory - every byte in memory has a unique address
  - each byte is between 0 and 2⁶⁴ - 1
- an array's first element is at it's lowest address and then it grows upward
  - the name of the array is a pointer to that first array, in 8 bytes (64-bti addressing)

## C Data Types
- char - one byte; the smallest one
- short int - two bytes / half-word
- int - 4 bytes / word
- float 4 bytes / word
- double - 8 bytes
- long int - 8 bytes
- by default they are all signed
- no strings. use a char array
  - `char str[] = "hello";`
  - by default also contains the null terminator character -- completely invisible

## data type signs
- you can specify `unsigned int` etc.
  - not for double or float
- `unsigned char a = -5` will work, technically
  - it will be interpreted as `a = 1111 1011` 
  - which, when read back, will be interpreted as unsigned so `a = 251`
- `for (unsigned int a = 10; a >= 0; a--){};` will never stop running because sn *unsigned* variable can never be < 0
  - the binary will still wrap around from `00000000` to `11111111`, it just depends on how the computer interprets it

## goto
- `goto` lets us do *un*conditional branching
  - can let us skip around blocks of code
  - give some block of code a label, and whenever you want to use it, call `goto <label>`
- given this:
```c
if (a<0){
  S1;
  S2;
} else{
  S3;
  S4;
}
```
- we can do:
```c
if (a>0) goto La;
// we can get rid of the else condition; 
// it won't reach this line unless "else" happens anyway
goto Lb
La: S1;
S2;
goto Lc
Lb: S3:
S4;
Lc: ...
```
- and this second snippet can be easily translated into assembly later
- now if we have:
```c
for(int a=0; a<10; a++){
  S1;
  S2;
}
```
- this can become:
```c
int a = 0;
Loop: 
  if (a>=10){
    goto Out;
  }
  S1;
  S2;
  a++;
goto Loop; 

Out: ...
```

# 9/13 Data Storage

- byte-addressed = 1 byte per address ⇛ amount of unique addresses = amount of bytes that can be stored
- 64-bit implies 2⁶⁴ unique addresses, = amounts of bytes we can store
- range of addresses = [0, 2⁶⁴ - 1]
- every char array used as a string has the amount of characters you give it plus the null terminator
- `char str[]` --> type of `str` = char pointer, `char*`
  - its value is the base address of the first element
- arrays do not have a terminal character
  - they take up only as much data as they contain
- `int arr[]` --> type of `arr` = `int*` to the array's base address
  - the array's next element is ALWAYS the next highest address
- `&` gives you the address of a variable
  - assuming `int arr[] = {10,20,30}` and starts at 0x0
  - `&arr[0]` = 0x0 = `arr` = `arr+0`
    - we get the lowest address, even though 10 takes up the first 4 bytes/addresses by being an int
  - `&arr[1]` = 0x4 = `arr+1`
  - `&arr[2]` = 0x8 = `arr+2`
  - the interpreter knows to move `arr+1` 1 *element* up instead of one *address* up
  - `arr + <n>` is an `int*` just like `arr` by itself
- `*` dereferences a pointer
  - i.e. gives you the value it points to instead of its address
  - `*(arr+0)` = `arr[0]` = 10
  - `*(arr+1)` = `arr[1]` = 20
  - `*(arr+3)` = `arr[2]` = 30
  - `*(arr + <n>)` gives us an int
- we are now never using the good notation again because assembly doesn't have it
- address of the nth element = base address ± n * sizeof(data type)
  - this is how `*(arr + <n>)` works
  - if we really only want to move one byte at a time through `int a`, we can do `(char*)&a + <n bytes>`
    - e.g. the third byte of `int a` stored at 0x1000 would be `(char*)&a + 2`
    - can't add a fraction of a byte to only get part of the way into a variable
  - since we casted it to a char pointer it returns *one* byte from the int
  - if we tried `*((char*)&a + 2)` the machine wouldn't know where the boundary of the variable is
  - `*((int*)((char*)&a + 2))` just grabs the 4 bytes after the third byte of `a`
  - n * sizeof(data type) = *byte offset*

## endianness
- endianness has to do with how multi-byte variables are stored
- little endian: first (lowest) byte is at the lowest memory address
  - when splitting up one value into multiple addresses, it is stored from least significant byte to most significant byte
- big endian: first (lowest) byte is at the highest memory address
- this DOES NOT EFFECT ARRAYS
- we are going to assume little endianness if not specified
![endianness examples](image-1.png)

## 9/16 Data Storage Cont.
- when you declare a variable with hexadecimal, it's exactly what is stored. 
  - no sign extension happens. 
  - empty bits are filled with 0s
- more pointer arithmetic examples:
  ![](image-2.png)
- this happens because the hardware has no concept of variables and boundaries. it just reads what it sees
- assembly is the closest you can get to just manipulating hardware
- languages like python don't even allow this, others will complain, C doesn't care

# 9/17 lab
- you can downcast with truncation
- you can upcast but it will include garbage

# 9/18 von Neumann
- we can attach as many I/O devices as we want
  - hard drive is an I/O device
  - keyboard, mouse, trackpad, etc are all peripheral devices
    - peripheral b.c. the computer can run without them
  - the RAM and CPU are the essential parts that the computer needs to have
    - otherwise it's not really a computer
- each wire can carry high/low voltage ⇛ 0/1
  - a bus = a big group of wires put together
- the RAM or I/O devices send signals with instructions tot eh CPU over the control bus
- to do 3+2:
  - I/O device reads "3+2"
  - RAM gets "3" "2" and the instruction to add them
  - RAM send "3" and "2" to the register file in the CPU
  - RAM sends addition instruction over control bus to control unit in the CPU
  - ALU (algorithmic logic unit) in the CPU takes 3, 2 and control unit tells it to add them
  - ALU does the addition and produces 5
  - ALU sends 5 to the register file
  - calculation is done
- but now we want to save it...
  - register file sends 5 to RAM over data bus
  - RAM picks a memory address and stores 5 there
- ALU needs to send 5 to the register file before it gets to RAM because it has no direct connection to the RAM
- data bus is bidirectional -- it can send data both ways
- each operation/movement takes one tick of the CPU clock
  - and each operation is one assembly instruction
- data in the CPU is not addressed
  - Data are stored in registers in CPU, and registers use names to refer to, not address.
- data in the RAM is byte-addressed
  - RAM does not store data types or anything of the like -- it is only values or machine code

## intro to assembly
- assembly programs tend to be much longer than higher-level ones
- when we run a C language program:
  - C → compiler → assembly → link → executable binary
  - the compiler automatically turns C into assembly but we'll do it manually
- can compile with `gcc hello.c -S` to get an assembly file
- e.g. 
  ```c++
  int main(void){
      int a = 3+2;
  }
  ```
  becomes:<br><img src="image-3.png" width="400px"/>

- it's easy to see if the compiler or human wrote the assembly because the compiler writes very differently

# 9/20
- register file store immediate results of calculations
- ARM64 machines have 32 registers (X0-X31)
  - though X/W31 are special zero registers
- looks like this
![register file diagram](image-4.png)
- X9 + X10 means we're adding the data from X9 and X10 together
- the lower half of each registry entry is a word (W register)
  - old 32x cpus only has W for words; newer 64x cpus eXtend these to 64 bits
- the *entire thing* is an X register, the lower half included
- register names should be operands
- mnemonic for addition = ADD
- assembly format:
  - (Label:) mnemonic op1, op2, op3, ... //comment
  - we will need to comment every single line
- there are registers WZR and XZR that juts contain zeros.
  - used to clear out a register with MOV
  - you can do `MOV XZR, 382` but it doesn't do anything because XZR will return to 0 anyway
  - these are shortcuts to W31 and X31
  
## MOV
- not case-sensitive
- Syntax: `MOV Xn, simm64` or `MOV Wn simm32`
  - s = signed
  - imm = immediate number
  - 64/32 = amount of bits
  - MOVing a 32-bit number to `Wk` will zero out the higher digits of `Xk`
- keep a diagram of registers and values
- e.g. ![the result of two MOV operations](image-5.png)
- `MOV Xdst, Xsrc` or `MOV Wdst, Wsrc` will copy data from one register to another
  - both need be be the same of X/W
- `MOV 382, X20` is invalid because you cannot move a register into a number
  - you might have meant `MOV X20, 382` to put 382 into X20
- `MOV 382, 389` is invalid because you can't put a number in a number
- can only MOV things within the register file
  - most data is stored in RAM
  - we need to move it to/from RAM and CPU
  
## LDR
- LDR = load register
- CPU needs to send the needed address to the RAM and to retrieve the data
- Syntax: `LDR Wt/Xt [base,simm9]` loads a word/double word from memory addressed by base+simm9 to Wt/Xt;
  - Wt/Xt is the destination
  - brackets mean you want accessible memory
  - base = base address
    - must be an X register bc addresses are 64 bits long
  - simm9 = *byte* offset in 9 bits
    - offsets you into the data at the address
  - can load a W into an X / X into a W
    - zeros out top half
- Syntax: `LDR Wt/Xt, [Xn,Xm]` 
  - loads a word/double word to Wt/Xt (respectively) from memory address Xn+Xm
- Extended syntax: `LDR[S]{H|B} Wt, [base, simm9]`
  - S: use sign extention (optional)
    - i.e. duplicates most significant *bit* (not leading hex digit)
    - uses zero extension otherwise
    - necessary to think about because a half word/byte will not fill the W register (4 bytes)
  - H: load a half word/nibble, B: load a byte (optional)
  - has to load to a W register
  - examples: ![examples of the extended syntax of LDR](image-6.png)
  
# Assembly Programs
![basic assembly program](GetImage.png)
- this program doesn't actually print anything, it just ends itself
  - these 3 lines are used to end the program
- assembly programs have text and data segments
  - `.text` segment contains code, instructions to be carried out
  - `.data` segment declares data
  - can be in any order as long as they are separate
- `_start:` is a **label** like for goto and is equivalent to a `main` function
- variable names are also labels; `hello_str: .ascii "Hello World!\n\0"`
- under `.text` we need `.global _start` to tell to OS where to start running the program
- all of these `.name` lines are **directives**
  - they are not code
  - like a `#include <xyz>` in C++, it is for the compiler, not the final executable

## .text
- `MOV X0, 0` tells the system that status is normal
  - OS checks X0 for the status of the program upon exit
- `MOV X8, 93` is saving the number to call a system service, here it's 93 which is terminating the program normally
- `SVC 0` actually calls for the system service, using the number in register X8
  - it's always X8

## .data
- `hello_str: .ascii "Hello World!"`
- Declaring a variable syntax: `label: .type_directive data1, data2, ...`
  - label is any valid label
    - will point to the base address of the data assigned
  - .type_directive: ![options for type directives](image-7.png)
    - tells us how much space each piece of data takes
  - data1, data2, ...: data
    - ascii must be declared `"Content\0"`, including the null terminator
    - strings can be declared as `"usual"`
      - the label of the string points to the location of `"u"`
    - arrays are declared with type and no delimiters, e.g. `arr: .quad 80302, 01230, 07030` 
      - `arr` points to the location of element 0, `80302`
- all data declared in the `.data` segment are stored sequentially
  ```arm
  str: .string "Hello"
  arr: .quad 80302, 01230, 07030
  vec: .int -100
  ```
  - for example, `str + 5` = `arr` = `80302`

# ADR
- gets the data from an address into a register
- Syntax: `ADR dst, label`
  - `ADR X9, arr` loads the address of arr into X9
- `LDR X10, [X9]` then loads the *content* of `arr[0]` into X10
- `LDR X10, [X9, 8]` loads `arr[1]` into X10
  - 8 = byte offset between quads, which arr is made of

# STR
![STR syntaxes](image-8.png)
- lets you store something from the CPU into RAM

# Calculating
- Addition: ADD
  - Syntax: `ADD Xd, Xn, Xm`
  - stores the result of Xn + Xm into Xd
  - *one* of Xn and Xm can be an immediate
- Subtraction: SUB, and Multiply, MUL have the same syntax
- SDIV, UDIV for signed and unsigned division operations
- LSL (logical shift left)
- LSR (logical shift right)
- ASR (arithmetic shift right)
- AND (logical AND)
- ORR (logical OR)
- EOR (logical XOR)

# Branching (Flow Control)
- unconditional branching with B = goto
  ```arm
  MOV ...
  ADD ...
  B L1
  SUB ... //this line never runs
  L1: LDR ...
  ```
- let's say we start with:
  ```c
  long int a;
  if (a==4) a++;
  else a--;
  ```
- we can rewrite it with `goto`:
  ```c
  long int a;
  if (a==4) goto L1;
  else goto L2;

  L1: a++;
      goto end;
  L2: a--

  end: ...
  ```
- we can rewrite `if (a==4)` as `if (a-4==0)` arithmetically
- Syntax: `CBZ Xt, Label`
  - if the content of Xt **==** 0, goto Label; else move to the next instruction.
- Syntax: `CBNZ Xt, Label`
  - if the content of Xt **!=** 0, goto Label; else move to the next instruction.
- these let us translate that original C++ code into:
```arm
// we have loaded long int a into X9
    SUB X10, X9, 4 // X10 = a-4
    CBZ X10, L1    // if X10 == 0 goto L1
    B   L2         // else goto L2

L1: ADD X9, X9, 1  // a++
    B   End
L2: SUB X9, X9, 1  // a--
End:
```

## Translating For loops
```c++
for (int i = 0; i < 5; i++){}
```
is the same as
``` c++
int i = 0;
loop: 
if (i<5){
  i++;
  goto loop;
}
```
is the same as
```c++
int i = 0;
loop: 
  if (i==5) goto End;
  i++
  goto loop
End:
```
which can be turned into assembly line-by-line:
```arm
MOV X0, 0       // X0: int i = 0
SUB X1, X0, X5  // X1 = i-5
Loop:
CBZ X1, End     // if (i-5 == 0) goto End;
ADD X0, X0, 1   // i++
B   Loop        // goto Loop
End:
...
```

## 
- null terminator's ascii value is 0
- lowercase letters are stored immediately uppercase
  - add 32 to an uppercase letter to get its lowercase equivalent
  - and subtract for vice versa

```arm
.data
  msg: .string "hello" // we want this to become "HELLO"
.text
.global _start
_start:
  MOV  X0, 0          // X0 index/byte offset
  ADR  X1, msg        // X1: base

Loop:
  LDRB W2, [X1, X0]   // W2 ← msg[i]
  CBZ  X2, End        // if (X2 == 0) goto End;
  SUB  W2, W2, 32     // W2 ← W2 - 32
  STRB W2, [X1, X0]   // msg[i] ← W2
  ADD  X0, X0, 1       // i++
  B Loop              // goto loop
End:
...
```

# Machine Code
- each instruction is a 4-byte binary
- the instructions are loaded into RAM
  - which means each instruction has an address
  - loaded in sequentially
- we know the code starts at label `_start`
- PC = program counter
  - has as 64-bit register
  - stores the address of the next instruction
1. cpu retrieves the address of the first instruction from the PC
2. pc retrieves the 4 bytes of instruction
3. pc loads the next instruction into the CPU
4. pc increments its counter by 4 bytes
   1. unless it reaches a CBZ where it might go directly to a labeled instruction's byte

# 9/30 Branching
## CPSR, Current Program Status Register
- has 32 bits but we only care about the 4 MSBs right now
  - 31 = N = Negative
    - 1 iff result from last operation is negative, else 0
    - AKA copy of the result's MSB
  - 30 = Z = Zero
    - 1 iff result from last operation is 0, else 0
  - 29 = C = Carry
    - 1 iff result from last operation is greater than the limit of the data type, else 0
    - AKA the extra bit we need to carry out of the result
  - 28 = V = Overflow
    - 1 iff result from last operation is too large to fit in a signed bit, else 0
    - will never get an overflow when adding a positive and negative together
- `ADDS` will set condition codes for its results, `ADD` doesn't
  - same deal for `SUBS` vs `SUB` and `ANDS` vs `AND`.

## CMP
- Syntax: `CMP Xn, Xm` or `CMP Wn, Wm`
- or with immediates, `CMP Wn/Xn imm12`
- subtracts the second argument from the first, then set all condition codes in the CPSR about the result
- effectively does the same thing as `SUBS`, but `CMP` doesn't store the result of the multiplication into a register, while `SUBS` does

## B.cond
- Syntax: `B<.cond> Label`
  - `B` always jumps to Label
  - `B.cond` jumps iff its condition is fulfilled, otherwise nothing.
    - i.e. calls with conditions that are unfulfilled are skipped over
- comparisons and their equivalent B operations:
![chart of comparisons and their equivalent in B operations](image-9.png)
  - **notice that most commands are different for different signedness**

# 10/2 Process Image
- shows the addresses in memory a program takes
  ![process image](image-10.png)
  - unused is unused
  - `.text`, `.data`, and `.bss` parts are the assembly code
  - heap stores anything that gets created during runtime
    - like anything declared with `new`
    - ie.. stores dynamic data
      - assembly parts store static global data
  - stack stores procedure calls and local variables
    - anything added to the stack grows down into the empty space
    - outermost function call is at the bottom, innermost is at the top (gets finished first)
    - SP register X29 points to the top of the stack 
      - can add and subtract X29's value to move up/down the stack
      - it's not actually at X29, but X29 will redirect you to it
- assembler (compiler) turns asm code into object file (made of machine code/binary)
  - object has `.text` and `.data` but it's in binary
- we can link object files with a linker
  - merges all of the `.text` and `.data` into one big executable
- text editors will try to translate the binary into ASCII characters, and sometimes those characters don't exist
  - if we want to see the actual binary
  - generate listing file by `aarch64-linux-gnu-as demo.s -a=demo.lst`
  - then `cat demo.lst` will show assembly and machine code side-by-side
  - ![listing example](image-11.png)
    - notice the hex values next to the declaration of `"Hello World!\n"` are all of the ASCII codes for each character (plus `\0` = `0x00` at the end)

## 10/4 Procedures
- leaf procedure does not call any other procedures
- we can think of calling a procedure (a function) as branching to its code and then branching back
  ![alt text](image-12.png)
  - this is limited in that it will always return back to A1, even if you call it later and you want it to return somewhere else
  - we need a dynamic return point
- recall every instruction has an address, and the program counter stores what instruction to go to next
  - the address of the calling point will be in PC when you go to the procedure
  - the expected address of the return point is that value +4
- New instruction BL = branch and link
  - stores the return address (PC+4) into a special register X30 (aka LR, linked register)
  - THEN branches like normal (sets PC to target address)
  - Syntax: `BL label`
- at the end of your procedure you just do `RET`
  - copies X30 into PC
- between a `BL` and its `RET` instruction, **you should not touch X30.**
- if we call another function from inside this procedure, X30 will be overwritten...
  - so we store the old return address in the stack and come back to it later
  - this is how it works anyway, btu now we have to do it manually

# 10/7 Non-leaf Procedures
- leaf procedures: returns and calls not other procedures
- non-leaf procedures: calls other procedures
```c++
void fun2() { 
  return; 
} 
void fun1() { 
  fun2(); 
  return; 
} 
int main() { 
  fun1();
}
```

```arm
fun2:
RET       // 0x1000, returns to 0x1008

fun1: 
BL fun2   // 0x1004, overwrites PC to 0x1008
RET       // 0x1008, returns to 0x1008

_start: 
BL fun1   // 0x100C, sets PC to 0x1010
MOV X0, 0 // 0x1010
// etc
```
  - the PC gets stuck at 0x1008 -- the return address 0x100C is overwritten and unrecoverable.
- approach 1: save old return addresses to registers
  - ok for really small programs, but we run out of registers pretty quickly
- moving something out of the stack does not destroy it
- though it will be overwritten when the stack moves back up
- approach 2:
```arm
// only showing non-leaf procedure
fun1:
SUB SP, SP, 8     // allocate stack space
STR X30, [SP, 0]  // save X30
BL sun2
LDR X30, [SP, 0] // restore X30
ADD SP, SP, 8    // de-allocate stack space
RET
```

## printf()
- we know `printf("hello %d%x", num, num2)`
  - first parameter: **address** of the string → X0
  - **values** of other parameters → X1, X2, ...
- we call it by `BL printf`
- we never write the printf code, but the assembler won't complain because that's not its job
  - it's not a compiler/linter
- the linker will complain `undefined reference to printf`
  - it will try to make executable code for printf but it can't find any
- resolve by linking with `-lc` flag, which includes printf
- when executing you need to add `-L /usr/aarch64-linux-gnu ...`

# 10/9 Procedure Practice
- we need to translate this into assembly:
  ```c
  long int cat(long int purr){
    return purr + dog() + bunny();
  }
  ```
  - purr is local, not a global variable, so it will be stored in X0 by convention
    - if there were more, they'd be stored on X0-X7 sequentially
  - to call `dog()` we might want to simply `BL dog`
    - BUT, because of convention, it will put its output in X0 and overwrite our value of `purr`
    - so we'll store `purr` in X1 and *then* `BL dog`
  - then we have to move dog before we can `BL bunny`
  ```arm
  cat:
  // we can call these two lines the prologue
  SUB SP, SP, 8 
  STR X30, [SP]

  MOV X1, X0      // X1 = purr
  BL dog          // X0 = dog()
  MOV X2, X0      // X2 = dog()
  BL bunny        // X0 = bunny()

  ADD X0, X0, X1  // X0 = bunny() + purr
  ADD X0, X0, X2  // X0 = bunny() + purr + dog()

  // we can call this all the epilogue
  LDR X30, [SP]    
  ADD SP, SP, 8
  RET
  ```
- now this
  ```c
  long int cat(long int x, long int y){
    if (x < y) return dog();
    else return bunny();
  }
  ```
  - we need to use signed comparisons since x, y are automatically signed
    - if they were unsigned they would be called `unsigned long int`
  - we need comparison B.LE but we need to use BL to actually come back afterward
    - we will B.cond jump to another bit of code that calls the other procedure
    - we don't have to worry about it with the else case
  ```arm
  cat:
  // the prologue is always the same
  SUB SP, SP, 8 
  STR X30, [SP]

  CMP X0, X1
  B.LT woof       // if x < y goto woof
  BL bunny        // else call bunny()
  B out

  woof:
  BL dog          // call dog()

  out:
  // as is the epilogue
  LDR X30, [SP]    
  ADD SP, SP, 8
  RET
  ```
- another one:
  ```c
  add(long int a, long int b){
    return a + b; 
  } 
  void proc(int n){
    long int arr[n]; 
    for (int i = 0; i < n; i++ ) { 
      arr[i] = add(i, i); 
    }
    return;
  }
  int main() {
    proc(10);
  }
  ```
  ```arm
  add:
  ADD X0, X0, X1 
  RET

  proc:
  SUB SP, SP, 0
  STR X30, [SP]
  MUL X20, X0, 8
  SUB SP, SP, X20

  MOV X0, X18       // X18 = n
  MOV X19, 0        // X19 = i
  CMP X19, X18      // i, n
  B.EQ out

  MOV X0, X19       // X0 = i
  MOV X1, X19       // X1 = i
  BL add            // add(i,i)

  // etc
  
  ```


# 10/11 Convention II
- what if we want more than 8 parameters or more parameters than we have registers?
  - store the extra parameters in the memory in the stack
- in printf `%d` prints out the W register, `%ld` prints the entire X register
- printf will overwrite a lot of registers, so what do we do with the data we need?
- caller-saved registers: X0-X18
  - move your data out of these when you call something
  - won't all be overwritten every time but they all *can* be
- callee-saved registers: X19-X30
  - a procedure we call will not overwrite these registers
  - they might have used them, but it will write the original data back in before it returns
- we need this to write and use libraries with predictable behavior
- when moving the stack pointer, we need to know our frame size, i.e. the size of what we're returning:
  1. X30, return address, 8 bytes
  2. local variables
  3. original value of any registers X19 - X29 that you use
```arm
proc:
// we can call this the prologue:
SUB SP, SP, frame_size  // move stack appropriately
<<<<<<< HEAD

STR X30, [SP, __]       // store return address

STR X19, [SP, __]       // store callee-saved registers
⋮
STR X29, [SP, __]
...

// say we have a BL somewhere in here, all of this still happens correctly and we have no problems

// this is the epilogue:
LDR X19, [SP, __]       // reload callee-saved registers
⋮
LDR X29, [SP, __]

ADD SP, SP, frame_size
RET
```

## test review
- what changes program flow?
  - RET, CBZ, CBNZ, all `B`ranching instructions
- what changes condition flags?
  - CMP, ADDS, SUBS, MULS, ANDS
- practice problems
  - in priority order
- quick check questions from the textbook
  - include solutions
- reading quizzes
- labs
- HW

# 10/16 recursive functions
- look at his notes for this i didn't take any
- recursive function time can vary a lot and it generally much slower than loop functions

# 10/18
- recall changes in bit values have a rising and falling delay. it's so small that we don't need to care in practice.
- NOT has a higher priority than binary operators
- comparing a and b means 
  - 0 CMP 0 = 1
  - 0 CMP 1 = 0
  - 1 CMP 0 = 0
  - 1 CMP 1 = 1
  - basically just == check
- multiplexor takes s, a, b
  - 2-way multiplexor:
    ```
    s a b output
    0 0 0 0
    0 0 1 0
    0 1 0 1
    0 1 1 1
    1 0 0 0
    1 0 1 1
    1 1 0 0
    1 1 1 1
    ```
  - when s = 0, output = s
  - when s = 1, output = b
  - s = control signal
  - in a larger implementation, s is still one bit which controls whether the entirety of A or B is selected
  - what if we wanted a 3-way multiplexor?
    - one multiplexor between a and b with control signal s0 then another between that one's output and c with control signal s1
  - ![alt text](image-13.png)
  - amount of control signals needed for N inputs = Tlog_2 N^T

# 10/21 Latches
- binary adding gives you a result bit s and a carry-out bit cout
- in a larger circuit, the carry-out is connected to the carry-in for the next adder
  - at the last one the cout is the FINAL cout
- combinational logic: ALU
- sequential logic: registers
- a latch saves the previous state of the circuit
- D-latch has a clock C and data D
  - if the clock is off then Q+ is off and Q- = !Q+
  - if clock is on, Q+ = D and Q- = !D
- the more gates you have, the slower the rising/falling edges are
- in a flip-flop, the clock's rising edge is extended by putting it through a large odd number of NOT gates
  - during its rising edge, D makes it through to T
  - when we extend it, we only need one clock
    - every pulse we want all of the data to go through at once

# 10/25 Encoding
![circuit diagram of the resisters](image-14.png)
- registers can be written to or read from
- the write port of a register file uses sequential logic
- each have EDC
  - C takes in the clock
  - D takes in data (from RegDataW)
    - the data gets brought to all registers, but only one will be opened to receive it
  - E(nable) = 0 means the register will not update, 1 means it will
    - takes the output of an AND gate between RegWrite (control signal for if we're writing) and WriteReg (the register to write to)
      - blue line ⇛ CTRL signal
- decoder generates 32 bits and only the register to write to will take 1
  - all others get 
- e.g. `MOV X7, 40`
  - WriteReg = 7
  - RegWrite = 1
  - RegDataW = 40
  - decoder sends 0 to all registers' E port except for X7
  - all registers receive 40 to D but only X7 gets RegWrite & E = 1
  - so only X7 gets 40 written into it
- the read port of a register file uses combinational logic
- ReadReg1 = control signal of 5 bits (log_2 32 for 32 registers)
- RegData1 takes the data
- e.g. `ADD X7, X8, X9`
  - ReadRed1 = 8 ⇛ RegData1 = 100 (per se)
  - ReadReg2 = 9 ⇛ RegData2 = 200 (per se)
  - ALU calculates 100 + 200 = 300
  - we now need to write that into X7
  - WriteReg = 7
  - RegWrite = 1
  - RegData = whatever's in the ALU (it's 300)

## memory
![the busses of memory](image-15.png)
- when we work with the memory, the memory address gets sent through the address bus
- address bus is unidirectional (from elsewhere INTO the memory)
- data bus is bidirectional
- control bus lets the memory to know what to do with the data bus
- assembly gets translated into an opcode with its operands
![machine code translations for many assembly instructions](image-16.png)
  - recall that instructions take up 4 bytes of memory, so they are all exactly 32 bits long
  - we're not considering W registers
  - since all register names are between 0-32, we only need 5 bits to name them
    - when all operands are registers, we use set sequences to fill out the remaining 32 bits of the instruction
  - immediates have weird size limits because of the 32-bit-per-instruction limit
- when we call labels, we don't have enough room in the instruction (32 bits total) to include the entire address (64 bits)
  - so we calculate the distance between the PC and the label and store that instead
  - this is PC-relative offset
- RET takes no label so its imm is 0

# 10/28
- we're gonna start using python-like syntax to describe circuits
- a = 6 ⇛ wire a has a value of 6
- `R[6]` = data stored in X6
- `M[a]` = data in memory at address a
  - size of a is assumed by context
- `M[R[6]]` = data in memory at address stored in X6
- R[4] = M[R[6]] = `LDR X4, [X6]`
- R[6][0:31] = lowest 32 bits of X6
- one clock cycle = 1 period 
  - 1 high, one low
  - one square wave cycle
- the clock starts sequential circuits
  - stores data at the rising edge of the clock
  - the write port of a register file is sequential
- they start the combinational circuits
  - responds to input changes anytime
  - the read port of a register file is combinational
- single-clock cycle model - each instruction takes a full clock cycle to execute
  - very inefficient but easy to understand
- datapath
  - ![datapath diagram](image-17.png)
  - we only have one memory but it's split here for visual ease
  - instruction memory = `.text`
1. IF Instruction Fetching
   1. fetch instruction
   2. split wires
2. ID Instruction Decoding
   1. read registers
   2. control unit generates control signals
3. EXecute - most important
   1. compute
   2. determine branching
4. MEmory access - slowest stage
5. WB write back
   1. end of the cycle

![annotated datapath](image-18.png)
let's look at `ADD X7, X8, X9`
- in stage 2:
  - ReadReg1, ReadReg2 = 8, 9
  - WriteReg = 7
- in stage 3:
  - ALU calculates R[8] + R[9]
- in stage 4:
  - bypasses the memory
  - this instruction still technically happens, it just doesn't do anything
- in stage 5:
  - R[8] + R[9] gets sent to RegDataW
  - since WriteReg = 7, R[7] = R[8] + R[9]
- this has been one clock cycle
- possible question: given an instruction, find values of all the control signals


# 10/30 Decoding
brief overview of the 5 stages:
![alt text](image-19.png)

- control unit takes in the opcode to tell the CPU what to do
  - rest of the instruction bytes go to register file
- all control signals are 1 but except ALUop which is 2 bits
- recall this chart; we are only concerned with these instructions
![machine code translations for many assembly instructions](image-16.png)
- decoding stage diagram:
![decoding](image-20.png)
- RegWrite
  - arithmetic and LDR do it
  - B writes to a non-general register so it doesn't count
  - BL writes to X30 so it counts
  - if an instruction writes to a register, the destination register is stored in the last 5 bits
  - I[4:0] always goes to WriteReg
- ReadReg2
  - 5 bits I[9:5] are always a register to be read
  - B never reads anything so it takes 0s 
- Reg2Loc tells us where the second register is stored in the instruction
  - if we're reading a third register (first group), Reg2Loc sends 1 to read from I[20:16] instead.
  - if there are only 2 registers in the instruction then the second is I[4:0]

# 11/1 Execution
![the execution step in diagram](image-21.png)
- ALUsrc tells the ALU what input it's getting
  - ALUsrc = 0 for the 2-register arithmetic instructions and LDR, STR
  - ALUsrc = 1 for the 1-register/1-immediate arithmetic instructions
  - for branching instructions it doesn't matter what ALUsrc is
- ALU is combinational
- all ALU operations for relevant instructions:
![all ALU operations for relevant instructions](image-22.png)
  - since action has 4 bits, we can support 16 operations
  - our model is small tho so we don't use all of them
  - don't memorize this table
  - know that branch instructions pass an input as an output
- we calculates nextPC (= PC + 4) in the last stage
- BrPC = branched PC
  - used if we're going to somewhere other than PC+4
- for RET, ALUout = X30
- PBr = 1 ⇛ PC = ALUout = X30
  - RET
- PBr = Br = 0 ⇛ PC  = nextPC = PC + 4
  - regular program flow
- PBr = 0, Br = 1 ⇛ BrPC = PC + imm
  - B instructions
- cannot read and write to the memory at the same time (one data bus)

# 11/4 Example
- writing to a register is sequential circuits

# 11/6 Pipeline
- we want to speed up the CPU by starting instructions quicker, rather than waiting for one to finish before starting the next
- throughput: how fast our model is. measured in billions of instructions per second, GIPS (giga-instructions per second)
- latency: amount of time to execute one instruction, measured in picoseconds (ps) = 10^-12 seconds
- writing to a register takes 20ps
- we have this multiplexer circuit:
  - ![alt text](image-23.png)
  - we want to speed it up
- we'll split it up into 3 parts, the NOT, OR and AND stages
- now say the instruction in stage 2 is taking too long and stage 1 is trying to move on
  - the slow process in stage 2 will be overwritten if we don't stop the fast one in stage 1.
  - to protect both processes we can put a barrier register between them, aka pipeline registers
    - they are not general purpose registers
- ![example usage of pipeline registers in MUX circuit](image-24.png)
  - note one stage takes 120ps as (1/3 of 300 ps) + now we need 20 ps *every stage* to write to the new registers
- now in 3 cycles we can be working on 3 different instructions, rather than all 3 taking 3 full clock cycles
- at the rising edge the barriers are lifted (registers write into the next stage/read from the last)
- this becomes redundant if your stages are really short. for example 3x 5ps stages + 2x 20ps register writing adds way too much time to be helpful
- stages will usually have wildly different times between them
  - since they're all controlled by the clock, you need to accommodate the slowest stage
  - therefore latency = time for longest stage * amount of stages
- the memory access stage is 1000x slower than stages that only happen in the CPU
  - due to having to send signals out to the memory


# 11/8 CPU Piped
- to make the CPU piped we need to put registers between each stage of the CPU
- from now on we will be separating each instruction into its 5 stages: IF, ID, EX, ME, WB
- each instruction might not do anything in all 5 cycles, but it needs to go through all of them and cost 5 clock cycles
- we need to start a new instruction on every new clock cycle
![sequential vs pipeline CPU diagram](image-25.png)
- data gets written to registers at the rising edge
- reading can happen anytime

## data hazards
- simultaneous instructions are overwriting each other's data
- there are manual and automatic solutions
- sometimes we can make sure that we never have to go back to the general purpose registers during one instruction so its value can't be overwritten
- however this isn't always possible if the next instructions needs the last instruction's result
- so we can put dummy instructions between them so make sure they don't overwrite each other's data AND they can access what they need to
  - this dummy instruction is called `NOP` for **n**o **op**eration
  - it does nothing but skip a clock cycle
- this slows down out throughput BUT it is still faster than sequential
- at most we will ever need 2 `NOP`s

# 11/11 Hazard
## data hazard solutions
1. manual: rearrange instructions
2. manual: waste clock cycles with NOP
   - e.g. between two ADD instructions we need 2 NOPs so the first has time to calculate
   - these rely on the user, which you should never do
3. we are trying to find an automatic solution
## automatic solution: stalling
- we have:
```arm
example1:
MOV X10, 10
ADD X11, X10, X10

example2:
MOV X10, 10
MOX x14, 14
ADD X11, X10, X10

example3:
MOV X10, 10
MOV X14, 14
MOV X15, X15
ADD X11, X10, X10
```
- only the first of these 2 have data hazards
- in example 1, ADD depends on the MOV instruction which will not have written into x10 by the time ADD needs that value; this is a dependency
- same for example 2
- we want a bit of software to detect these data hazards and fix them
- our hazard detection unit will take ReadReg1, ReadReg2, and WriteReg from all instructions. it will stall the pipeline by repeating some instruction's stages until its dependencies are done
  - it also controls the nextPC register
  - it will insert a "bubble" that stalls a certain part of the pipeline
- the bubble can only start (i.e. we can only stall before) the EX stage. once it's done we need to finish the instruction.
- if an instructions gets stalled at the ID stage, then the next one gets stalled at the IF stage. then the next next instruction cannot be fetched until the middle one moves to ID.

# 11/13 Forwarding
- for ADD, the solution exists as soon as the EX stage
- detect if we have current WriteReg == incoming ReadRegister1/2
  - if we do then we can start the incoming instruction's EX stage one clock cycle early, after stalling on its ID for only one extra cycle instead of 2
  - ![forwarding chart](image-26.png)
- can only forward from WB or ME to EX
- example forwarding pipeline diagram:
  - ![](image-27.png)
- cannot forward backward or ahead; must be in the same cycle
- however: this can never work with only forwarding. the ADD must be stalled at ID for one extra cycle.
  - ![bad forwarding](image-28.png)
- data hazards:
  - manual: rearrange instructions, or add NOP
  - automatic: forwarding, or stalling + bubbles
- control hazard: using the wrong instruction, usually due to branching error
  - CBZ doesn't know if we are branching until EX
  - so if we put the next 2 instructions in the pipeline and we need to branch, we're cooked
  - 2 solutions involve changing the hardware, but it sucks and is hard to read
  - flushing: turn the next 2 instructions into bubbles, so they don't do anything and the correct instruction can start on time
  - prediction: look at the code and try to predict if we will take the branch
    - BT: backward taken
      - jump backward to continue a loop perhaps
    - FN: forward not taken
      - jumping forward is usually not done; perhaps at the *end* of a loop
    - if this is wrong just flush out the other 2 instructions
    - worst case you're wrong 1% of the time and waste 2 clock cycles here and there, verses 2 for EVERY branch
  - misprediction rate: # wrong / # predictions

# 11/15 Performance
- we don't need to predict when we use B. only conditional branching.
- quick check 3.5: evil misprediction rate question with explanation. will be on the final
- we can do static prediction and always assume a branch will/will not be taken, but it nearly always has a misprediction rate >0
- static predictions change based on the type of branch
  - 1-bit predictor: predict taken/not taken
    - set the bit to the first outcome, then we keep predicting that outcome until it is wrong. then we toggle and repeat
    - especially bad if the actual outcomes are T/N/T/N...
      - it will never predict correctly
  - 2-bit predictor: takes 2 fails to switch prediction
    - ![2-bit prediction chart](image-29.png)
    - still not good
  - ![outcome vs. predictions](image-30.png)
- clock period = time per clock cycle
- clock rate = 1/clock period
- CPI = (clock) cycles per instruction
- CPU time = time a program takes using the CPU resources
  - excluding waiting for user input
  - I * CPI * clock period = I * CPI / clock rate = CPU time
- CPI and clock period are immutable. all we can change is amount of instructions
  - i.e. start code golfing
  - or rely on compiler
- there's also weighted average CPI: Σ(k=1 to K)(CPIₖ*Iₖ/I)
  - CPIₖ = CPI for instruction Iₖ
  - I still = the amount of instructions

# 11/18 Locality
- recall the clock cycle needs to be slow enough to compensate for the slowest operation
- locality: the data we are accessing is likely to be stored close to other data we use
- when we have a 2d array, it might store in row-major order (the way it looks in c, java, python; each row next to each other) or column-major order (the first element of each row, then the second, etc)
  - only matters if the matrix gets very large
  - row-major is traversed by stride-1: a₀, a₁, a₂, etc
  - column-major is traversed by stride-n, where n = the length of one row: a₀, ... aₙ₋₁, aₙ, ..., aₙ₊₁
- we can save a lot of memory access time by bringing a chunk of data into the CPU at once
  - it's fastest to have everything in the registers, but this is not always possible
  - and it's slow to have everything in our regular ram (DRAM)
  - so we move anything near anything important into the CPU's cache, the SRAM
  - we envision out storage heirarchy as such:
  - ![storage heirarchy](image-31.png)
    - cheap/expensive = actual money
- cache hit = data in the cache
- cache miss = data is not in the cache

# 11/20 Hit or Miss
- check if the data is in the cache or not
- if not, you have a cache miss
- in that case we need to go to the RAM and bring a block of data back
- we copy that into the cache
- then we request the data from the cache
- since we just put it there, we have a cache hit
- what if the cache is full and we need data that's not there?
- the cache has S sets (numbered 0 thru S-1)
- each set has E lines (numbered 0 thru E-1)
- each line has 
  - its number in the set
  - v: stores whether this line is usable or not
  - tag: leftover address bits; this covers the LINE, as all the data has the same tag
  - data block: B bytes where we store the actual data
- cache capacity C = amount of sets S * lines per set E * bytes in each line's data block B
- direct-mapped cache: 1 line in each set, i.e. E = 1
  - for more, it's an E-way associative cache
- possible offset b with B bytes per line = (log₂ B) bits
- each set needs to contain its own index. amount of bits s needed to store the index = (log₂ S) bits for index S
- addresses are m bits long, so we use the least-significant b bits as the offset in the cache, then the next s bits to count set index. since we're left with m - b - s = t bits, which gets used as the tag
- v is 0 by default, we set it to 1 when we store something in it
- if there is something in the right spot, but it's the wrong data, the tag will be different. this means you still have to go to memory.
- the memory will be loaded in in blocks of B bytes. no matter where the byte you need falls in that block, we need to load in the whole block
- with a small cache, it becomes redundant
- direct-mapped cache diagram:
  - ![alt text](image-32.png)

# 11/22 Miss Rate
- two-way set associative cache
- we add another line to each cache
- we are using a 4-bit-address RAM
  - adding a second line means we only need two sets, adn we'll store the same amount of data
- of the address,
  - 1 bit represents index (two data segments in each line * 4 lines = 8 data segments)
  - now only one bit to choose set (two sets * 2 lines * 2 data bytes = 8 bytes)
  - two bits for tags
- miss rate = cache misses/cache accesses
- hit rate = 1 - miss rate

# 12/4
- amount of bits in address = log₂(size of memory)

cache:
- C = capacity; in bytes = s \* e \* b
- S = sets
- E = lines per set = size of a block
- B = bytes per line
- you can fit B/sizeof(integer) integers in one line of the cache

# 12/6
- forwarding can go from EX or WB to a later instruction's EX
- 
=======

STR X30, [SP, __]       // store return address

STR X19, [SP, __]       // store callee-saved registers
⋮
STR X29, [SP, __]
...

// say we have a BL somewhere in here, all of this still happens correctly and we have no problems

// this is the epilogue:
LDR X19, [SP, __]       // reload callee-saved registers
⋮
LDR X29, [SP, __]

ADD SP, SP, frame_size
RET
```

## test review
- what changes program flow?
  - RET, CBZ, CBNZ, all `B`ranching instructions
- what changes condition flags?
  - CMP, ADDS, SUBS, MULS, ANDS
- practice problems
  - in priority order
- quick check questions from the textbook
  - include solutions
- reading quizzes
- labs
- HW

# 10/16 recursive functions
- look at his notes for this i didn't take any
- recursive function time can vary a lot and it generally much slower than loop functions

# 10/18
- recall changes in bit values have a rising and falling delay. it's so small that we don't need to care in practice.
- NOT has a higher priority than binary operators
- comparing a and b means 
  - 0 CMP 0 = 1
  - 0 CMP 1 = 0
  - 1 CMP 0 = 0
  - 1 CMP 1 = 1
  - basically just == check
- multiplexor takes s, a, b
  - 2-way multiplexor:
    ```
    s a b output
    0 0 0 0
    0 0 1 0
    0 1 0 1
    0 1 1 1
    1 0 0 0
    1 0 1 1
    1 1 0 0
    1 1 1 1
    ```
  - when s = 0, output = s
  - when s = 1, output = b
  - s = control signal
  - in a larger implementation, s is still one bit which controls whether the entirety of A or B is selected
  - what if we wanted a 3-way multiplexor?
    - one multiplexor between a and b with control signal s0 then another between that one's output and c with control signal s1
  - ![alt text](image-13.png)
  - amount of control signals needed for N inputs = Tlog_2 N^T

# 10/21 Latches
- binary adding gives you a result bit s and a carry-out bit cout
- in a larger circuit, the carry-out is connected to the carry-in for the next adder
  - at the last one the cout is the FINAL cout
- combinational logic: ALU
- sequential logic: registers
- a latch saves the previous state of the circuit
- D-latch has a clock C and data D
  - if the clock is off then Q+ is off and Q- = !Q+
  - if clock is on, Q+ = D and Q- = !D
- the more gates you have, the slower the rising/falling edges are
- in a flip-flop, the clock's rising edge is extended by putting it through a large odd number of NOT gates
  - during its rising edge, D makes it through to T
  - when we extend it, we only need one clock
    - every pulse we want all of the data to go through at once

# 10/25 Encoding
![circuit diagram of the resisters](image-14.png)
- registers can be written to or read from
- the write port of a register file uses sequential logic
- each have EDC
  - C takes in the clock
  - D takes in data (from RegDataW)
    - the data gets brought to all registers, but only one will be opened to receive it
  - E(nable) = 0 means the register will not update, 1 means it will
    - takes the output of an AND gate between RegWrite (control signal for if we're writing) and WriteReg (the register to write to)
      - blue line ⇛ CTRL signal
- decoder generates 32 bits and only the register to write to will take 1
  - all others get 
- e.g. `MOV X7, 40`
  - WriteReg = 7
  - RegWrite = 1
  - RegDataW = 40
  - decoder sends 0 to all registers' E port except for X7
  - all registers receive 40 to D but only X7 gets RegWrite & E = 1
  - so only X7 gets 40 written into it
- the read port of a register file uses combinational logic
- ReadReg1 = control signal of 5 bits (log_2 32 for 32 registers)
- RegData1 takes the data
- e.g. `ADD X7, X8, X9`
  - ReadRed1 = 8 ⇛ RegData1 = 100 (per se)
  - ReadReg2 = 9 ⇛ RegData2 = 200 (per se)
  - ALU calculates 100 + 200 = 300
  - we now need to write that into X7
  - WriteReg = 7
  - RegWrite = 1
  - RegData = whatever's in the ALU (it's 300)

## memory
![the busses of memory](image-15.png)
- when we work with the memory, the memory address gets sent through the address bus
- address bus is unidirectional (from elsewhere INTO the memory)
- data bus is bidirectional
- control bus lets the memory to know what to do with the data bus
- assembly gets translated into an opcode with its operands
![machine code translations for many assembly instructions](image-16.png)
  - recall that instructions take up 4 bytes of memory, so they are all exactly 32 bits long
  - we're not considering W registers
  - since all register names are between 0-32, we only need 5 bits to name them
    - when all operands are registers, we use set sequences to fill out the remaining 32 bits of the instruction
  - immediates have weird size limits because of the 32-bit-per-instruction limit
- when we call labels, we don't have enough room in the instruction (32 bits total) to include the entire address (64 bits)
  - so we calculate the distance between the PC and the label and store that instead
  - this is PC-relative offset
- RET takes no label so its imm is 0

# 10/28
- we're gonna start using python-like syntax to describe circuits
- a = 6 ⇛ wire a has a value of 6
- `R[6]` = data stored in X6
- `M[a]` = data in memory at address a
  - size of a is assumed by context
- `M[R[6]]` = data in memory at address stored in X6
- R[4] = M[R[6]] = `LDR X4, [X6]`
- R[6][0:31] = lowest 32 bits of X6
- one clock cycle = 1 period 
  - 1 high, one low
  - one square wave cycle
- the clock starts sequential circuits
  - stores data at the rising edge of the clock
  - the write port of a register file is sequential
- they start the combinational circuits
  - responds to input changes anytime
  - the read port of a register file is combinational
- single-clock cycle model - each instruction takes a full clock cycle to execute
  - very inefficient but easy to understand
- datapath
  - ![datapath diagram](image-17.png)
  - we only have one memory but it's split here for visual ease
  - instruction memory = `.text`
1. IF Instruction Fetching
   1. fetch instruction
   2. split wires
2. ID Instruction Decoding
   1. read registers
   2. control unit generates control signals
3. EXecute - most important
   1. compute
   2. determine branching
4. MEmory access - slowest stage
5. WB write back
   1. end of the cycle

![annotated datapath](image-18.png)
let's look at `ADD X7, X8, X9`
- in stage 2:
  - ReadReg1, ReadReg2 = 8, 9
  - WriteReg = 7
- in stage 3:
  - ALU calculates R[8] + R[9]
- in stage 4:
  - bypasses the memory
  - this instruction still technically happens, it just doesn't do anything
- in stage 5:
  - R[8] + R[9] gets sent to RegDataW
  - since WriteReg = 7, R[7] = R[8] + R[9]
- this has been one clock cycle
- possible question: given an instruction, find values of all the control signals


# 10/30 Decoding
brief overview of the 5 stages:
![alt text](image-19.png)

- control unit takes in the opcode to tell the CPU what to do
  - rest of the instruction bytes go to register file
- all control signals are 1 but except ALUop which is 2 bits
- recall this chart; we are only concerned with these instructions
![machine code translations for many assembly instructions](image-16.png)
- decoding stage diagram:
![decoding](image-20.png)
- RegWrite
  - arithmetic and LDR do it
  - B writes to a non-general register so it doesn't count
  - BL writes to X30 so it counts
  - if an instruction writes to a register, the destination register is stored in the last 5 bits
  - I[4:0] always goes to WriteReg
- ReadReg2
  - 5 bits I[9:5] are always a register to be read
  - B never reads anything so it takes 0s 
- Reg2Loc tells us where the second register is stored in the instruction
  - if we're reading a third register (first group), Reg2Loc sends 1 to read from I[20:16] instead.
  - if there are only 2 registers in the instruction then the second is I[4:0]

# 11/1 Execution
![the execution step in diagram](image-21.png)
- ALUsrc tells the ALU what input it's getting
  - ALUsrc = 0 for the 2-register arithmetic instructions and LDR, STR
  - ALUsrc = 1 for the 1-register/1-immediate arithmetic instructions
  - for branching instructions it doesn't matter what ALUsrc is
- ALU is combinational
- all ALU operations for relevant instructions:
![all ALU operations for relevant instructions](image-22.png)
  - since action has 4 bits, we can support 16 operations
  - our model is small tho so we don't use all of them
  - don't memorize this table
  - know that branch instructions pass an input as an output
- we calculates nextPC (= PC + 4) in the last stage
- BrPC = branched PC
  - used if we're going to somewhere other than PC+4
- for RET, ALUout = X30
- PBr = 1 ⇛ PC = ALUout = X30
  - RET
- PBr = Br = 0 ⇛ PC  = nextPC = PC + 4
  - regular program flow
- PBr = 0, Br = 1 ⇛ BrPC = PC + imm
  - B instructions
- cannot read and write to the memory at the same time (one data bus)

# 11/4 Example
- writing to a register is sequential circuits

# 11/6 Pipeline
- we want to speed up the CPU by starting instructions quicker, rather than waiting for one to finish before starting the next
- throughput: how fast our model is. measured in billions of instructions per second, GIPS (giga-instructions per second)
- latency: amount of time to execute one instruction, measured in picoseconds (ps) = 10^-12 seconds
- writing to a register takes 20ps
- we have this multiplexer circuit:
  - ![alt text](image-23.png)
  - we want to speed it up
- we'll split it up into 3 parts, the NOT, OR and AND stages
- now say the instruction in stage 2 is taking too long and stage 1 is trying to move on
  - the slow process in stage 2 will be overwritten if we don't stop the fast one in stage 1.
  - to protect both processes we can put a barrier register between them, aka pipeline registers
    - they are not general purpose registers
- ![example usage of pipeline registers in MUX circuit](image-24.png)
  - note one stage takes 120ps as (1/3 of 300 ps) + now we need 20 ps *every stage* to write to the new registers
- now in 3 cycles we can be working on 3 different instructions, rather than all 3 taking 3 full clock cycles
- at the rising edge the barriers are lifted (registers write into the next stage/read from the last)
- this becomes redundant if your stages are really short. for example 3x 5ps stages + 2x 20ps register writing adds way too much time to be helpful
- stages will usually have wildly different times between them
  - since they're all controlled by the clock, you need to accommodate the slowest stage
  - therefore latency = time for longest stage * amount of stages
- the memory access stage is 1000x slower than stages that only happen in the CPU
  - due to having to send signals out to the memory


# 11/8 CPU Piped
- to make the CPU piped we need to put registers between each stage of the CPU
- from now on we will be separating each instruction into its 5 stages: IF, ID, EX, ME, WB
- each instruction might not do anything in all 5 cycles, but it needs to go through all of them and cost 5 clock cycles
- we need to start a new instruction on every new clock cycle
![sequential vs pipeline CPU diagram](image-25.png)
- data gets written to registers at the rising edge
- reading can happen anytime

## data hazards
- simultaneous instructions are overwriting each other's data
- there are manual and automatic solutions
- sometimes we can make sure that we never have to go back to the general purpose registers during one instruction so its value can't be overwritten
- however this isn't always possible if the next instructions needs the last instruction's result
- so we can put dummy instructions between them so make sure they don't overwrite each other's data AND they can access what they need to
  - this dummy instruction is called `NOP` for **n**o **op**eration
  - it does nothing but skip a clock cycle
- this slows down out throughput BUT it is still faster than sequential
- at most we will ever need 2 `NOP`s

# 11/11 Hazard
## data hazard solutions
1. manual: rearrange instructions
2. manual: waste clock cycles with NOP
   - e.g. between two ADD instructions we need 2 NOPs so the first has time to calculate
   - these rely on the user, which you should never do
3. we are trying to find an automatic solution
## automatic solution: stalling
- we have:
```arm
example1:
MOV X10, 10
ADD X11, X10, X10

example2:
MOV X10, 10
MOX x14, 14
ADD X11, X10, X10

example3:
MOV X10, 10
MOV X14, 14
MOV X15, X15
ADD X11, X10, X10
```
- only the first of these 2 have data hazards
- in example 1, ADD depends on the MOV instruction which will not have written into x10 by the time ADD needs that value; this is a dependency
- same for example 2
- we want a bit of software to detect these data hazards and fix them
- our hazard detection unit will take ReadReg1, ReadReg2, and WriteReg from all instructions. it will stall the pipeline by repeating some instruction's stages until its dependencies are done
  - it also controls the nextPC register
  - it will insert a "bubble" that stalls a certain part of the pipeline
- the bubble can only start (i.e. we can only stall before) the EX stage. once it's done we need to finish the instruction.
- if an instructions gets stalled at the ID stage, then the next one gets stalled at the IF stage. then the next next instruction cannot be fetched until the middle one moves to ID.

# 11/13 Forwarding
- for ADD, the solution exists as soon as the EX stage
- detect if we have current WriteReg == incoming ReadRegister1/2
  - if we do then we can start the incoming instruction's EX stage one clock cycle early, after stalling on its ID for only one extra cycle instead of 2
  - ![forwarding chart](image-26.png)
- can only forward from WB or ME to EX
- example forwarding pipeline diagram:
  - ![](image-27.png)
- cannot forward backward or ahead; must be in the same cycle
- however: this can never work with only forwarding. the ADD must be stalled at ID for one extra cycle.
  - ![bad forwarding](image-28.png)
- data hazards:
  - manual: rearrange instructions, or add NOP
  - automatic: forwarding, or stalling + bubbles
- control hazard: using the wrong instruction, usually due to branching error
  - CBZ doesn't know if we are branching until EX
  - so if we put the next 2 instructions in the pipeline and we need to branch, we're cooked
  - 2 solutions involve changing the hardware, but it sucks and is hard to read
  - flushing: turn the next 2 instructions into bubbles, so they don't do anything and the correct instruction can start on time
  - prediction: look at the code and try to predict if we will take the branch
    - BT: backward taken
      - jump backward to continue a loop perhaps
    - FN: forward not taken
      - jumping forward is usually not done; perhaps at the *end* of a loop
    - if this is wrong just flush out the other 2 instructions
    - worst case you're wrong 1% of the time and waste 2 clock cycles here and there, verses 2 for EVERY branch
  - misprediction rate: # wrong / # predictions

# 11/15 Performance
- we don't need to predict when we use B. only conditional branching.
- quick check 3.5: evil misprediction rate question with explanation. will be on the final
- we can do static prediction and always assume a branch will/will not be taken, but it nearly always has a misprediction rate >0
- static predictions change based on the type of branch
  - 1-bit predictor: predict taken/not taken
    - set the bit to the first outcome, then we keep predicting that outcome until it is wrong. then we toggle and repeat
    - especially bad if the actual outcomes are T/N/T/N...
      - it will never predict correctly
  - 2-bit predictor: takes 2 fails to switch prediction
    - ![2-bit prediction chart](image-29.png)
    - still not good
  - ![outcome vs. predictions](image-30.png)
- clock period = time per clock cycle
- clock rate = 1/clock period
- CPI = (clock) cycles per instruction
- CPU time = time a program takes using the CPU resources
  - excluding waiting for user input
  - I * CPI * clock period = I * CPI / clock rate = CPU time
- CPI and clock period are immutable. all we can change is amount of instructions
  - i.e. start code golfing
  - or rely on compiler
- there's also weighted average CPI: Σ(k=1 to K)(CPIₖ*Iₖ/I)
  - CPIₖ = CPI for instruction Iₖ
  - I still = the amount of instructions

# 11/18 Locality
- recall the clock cycle needs to be slow enough to compensate for the slowest operation
- locality: the data we are accessing is likely to be stored close to other data we use
- when we have a 2d array, it might store in row-major order (the way it looks in c, java, python; each row next to each other) or column-major order (the first element of each row, then the second, etc)
  - only matters if the matrix gets very large
  - row-major is traversed by stride-1: a₀, a₁, a₂, etc
  - column-major is traversed by stride-n, where n = the length of one row: a₀, ... aₙ₋₁, aₙ, ..., aₙ₊₁
- we can save a lot of memory access time by bringing a chunk of data into the CPU at once
  - it's fastest to have everything in the registers, but this is not always possible
  - and it's slow to have everything in our regular ram (DRAM)
  - so we move anything near anything important into the CPU's cache, the SRAM
  - we envision out storage heirarchy as such:
  - ![storage heirarchy](image-31.png)
    - cheap/expensive = actual money
- cache hit = data in the cache
- cache miss = data is not in the cache

# 11/20 Hit or Miss
- check if the data is in the cache or not
- if not, you have a cache miss
- in that case we need to go to the RAM and bring a block of data back
- we copy that into the cache
- then we request the data from the cache
- since we just put it there, we have a cache hit
- what if the cache is full and we need data that's not there?
- the cache has S sets (numbered 0 thru S-1)
- each set has E lines (numbered 0 thru E-1)
- each line has 
  - its number in the set
  - v: stores whether this line is usable or not
  - tag: leftover address bits; this covers the LINE, as all the data has the same tag
  - data block: B bytes where we store the actual data
- cache capacity C = amount of sets S * lines per set E * bytes in each line's data block B
- direct-mapped cache: 1 line in each set, i.e. E = 1
  - for more, it's an E-way associative cache
- possible offset b with B bytes per line = (log₂ B) bits
- each set needs to contain its own index. amount of bits s needed to store the index = (log₂ S) bits for index S
- addresses are m bits long, so we use the least-significant b bits as the offset in the cache, then the next s bits to count set index. since we're left with m - b - s = t bits, which gets used as the tag
- v is 0 by default, we set it to 1 when we store something in it
- if there is something in the right spot, but it's the wrong data, the tag will be different. this means you still have to go to memory.
- the memory will be loaded in in blocks of B bytes. no matter where the byte you need falls in that block, we need to load in the whole block
- with a small cache, it becomes redundant
- direct-mapped cache diagram:
  - ![alt text](image-32.png)

# 11/22 Miss Rate
- two-way set associative cache
- we add another line to each cache
- we are using a 4-bit-address RAM
  - adding a second line means we only need two sets, adn we'll store the same amount of data
- of the address,
  - 1 bit represents index (two data segments in each line * 4 lines = 8 data segments)
  - now only one bit to choose set (two sets * 2 lines * 2 data bytes = 8 bytes)
  - two bits for tags
- miss rate = cache misses/cache accesses
- hit rate = 1 - miss rate

# 12/4
- amount of bits in address = log₂(size of memory)

cache:
- C = capacity; in bytes = s \* e \* b
- S = sets
- E = lines per set = size of a block
- B = bytes per line
- you can fit B/sizeof(integer) integers in one line of the cache

# 12/6 Review
- forwarding can go from EX or WB to a later instruction's EX
- you cannot use forwarding if you are loading in data and then immediately accessing it
  - the only time we need tto bubble/stall is to LDR, LDR, then (per se) ADD that data. we stall the ID stage of ADD for an extra cycle.
- forwarding always goes directly down, never forward or backward

>>>>>>> d1eb25b89b3f0855239660c239c950354d0c35ca
