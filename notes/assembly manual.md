# ARM Assembly Instructions & Directives
instructions taken from the book, definitions and syntax from practice. calling a register Rn instead of Xn or Wn means it works on either. imm is an unsigned immediate number, simm is a *signed* immediate. label is any label.

- `SVC imm`: makes a service call with argument imm. if you don't need an argument then make it 0.

## Memory management
for this section, the offset is optional and will be 0 if excluded.
### Loading
- `ADR Rdst, label`: loads into Rdst the address that `label` points to.
- `LDRB Wdst, [Rsrc(, Roff || imm )]`: loads into Wdst one *byte* of data addressed by Rsrc + (Roff or imm).
- `LDRH Wdst, [Rsrc(, Roff || imm )]`: loads into Wdst one *halfword* = *2 bytes* of data addressed by Rsrc + (Roff or imm).
- `LDRSB Wdst, [Rsrc(, Roff || imm )]`: loads into Wdst one **signed** *byte* of data addressed by Rsrc + (Roff or imm).
- `LDRSH Wdst, [Rsrc(, Roff || imm )]`: loads into Wdst one **signed** *halfword* = *2 bytes* of data addressed by Rsrc + (Roff or imm).
- `LDR Rdst, [Rsrc(, Roff || imm )]`: loads as much data as can fit into Rdst, starting at address Rsrc + (Roff or imm).

### Storing
- `STRB Wsrc, [Rdst(, Roff || imm)]`: stores one *byte* of Wsrc into the memory addressed by Rdst + (Roff or imm).
- `STRH Wsrc, [Rdst(, Roff || imm)]`: stores one *halfword* = *2 bytes* into the memory addressed by Rdst + (Roff or imm).
- `STR Rsrc, [Rdst(, Roff || imm)]`: stores all of Rsrc (all 64 bytes of Xsrc or 32 bytes of Wsrc) into the memory addressed by Rdst + (Roff or imm). 


## Register management
- `MOV Rdst, (Rsrc || simm)`: move to Rdst the data in Rsrc or the value of simm. the size of simm must fit within Rdst.
### Math
for this section, the types of registers (Xn || Wn) of Ra and Rb must match.
- `ADDS Rdst, Ra, (Rb || imm)`: Rdst = Ra + Rb or imm, setting condition flags in CPSR.
- `ADD Rdst, Ra, (Rb || imm)`:  Rdst = Ra + Rb or imm
- `SUBS Rdst, Ra, (Rb || imm)`: Rdst = Ra - Rb or imm
- `SUB Rdst, Ra, (Rb || imm)`: Rdst = Ra - Rb or imm
- `MUL Rdst, Ra, (Rb || imm)`: Rdst = Ra * Rb or imm
- `SDIV Rdst, Ra, (Rb || imm)`: **signed** *integer* (floor) division; Rdst = Ra / (Rb or imm)
- `UDIV Rdst, Ra, (Rb || imm)`: **unsigned** *integer* (floor) division; Rdst = Ra / (Rb or imm)

### Logic
for this section, the types of registers (Xn || Wn) of Ra and Rb must match.
- `ANDS Rdst, Ra, (Rb || imm)`: Rdst = Ra & (Rb or imm), setting condition flags in CPSR. note & means *bitwise* AND.
- `AND Rdst, Ra, (Rb || imm)`: Rdst = Ra & (Rb or imm). note & means *bitwise* AND.
- `ORR Rdst, Ra, (Rb || imm)`: Rdst = Ra | (Rb or imm), setting condition flags in CPSR. note | means *bitwise* OR.
- `EOR Rdst, Ra, (Rb || imm)`: Rdst = Ra ^ (Rb or imm). note ^ means *bitwise* XOR (exclusive OR).
- `ASR Rdst, Ra, (Rb || imm)`: Rdst = Ra >> (Rb or imm). shifts Ra right by (Rb or imm) places, padding the most significant bit of Ra as it does so. `ASR` preserves the use case x >> n = x / 2ⁿ for negative signed numbers, and works the same (correctly) as `LSR` for unsigned or positive signed numbers.
- `LSR Rdst, Ra, (Rb || imm)`: Rdst = Ra >> (Rb or imm). shifts Ra right by (Rb or imm) places, padding 0s as it does so. `LSR` does not preserve the use case x >> n = x / 2ⁿ for negative signed numbers, but does for unsigned or positive signed ones. For negative signed numbers use `ASR`.
- `LSL Rdst, Ra, (Rb || imm)`: Rdst = Ra << (Rb or imm). shifts Ra left (Rb or imm) places. this preserves the use case x << n = x * 2ⁿ for all signed and unsigned numbers.

## Program flow control: branching
every instruction is in memory at runtime, and as such has an address. the program counter (PC) stores the address of the next instruction to execute. branching is done by setting the PC to the address of an instruction other than the next one. however, we can't change it manually -- and wouldn't want to, since we don't know where our instructions will get put in the computer's memory. instead, we can put labels in our code and use these instructions; then the computer will conveniently find their place in memory and move the PC there for us.
- `CBZ Rt, label`: "**c**ompare and **b**ranch if **z**ero." if Rt == 0, branch to label. otherwise continue.
- `CBNZ Rt, label`: "**c**ompare and **b**ranch if **n**ot **z**ero." if Rt != 0, branch to label. otherwise continue.
- `BL label`: "**b**ranch and **l**ink." save the next instruction (i.e. return point) to X30, then branch to label. meant to be used with `RET`.
- `RET`: "**ret**urn." sets PC to the instruction address in X30. meant to be used after `BL`.
- `BR Rn`: "**b**ranch to **r**egister." unconditionally sets PC to the instruction address in Rn.
- `B label`: **b**ranches to label unconditionally.
- `CMP Ra, Rb`: **c**o**mp**ares the values in Ra, Rb and sets appropriate condition flags in the CPSR for `B.cond`. the type of register of Ra and Rb must be the same. functionally similar to `SUBS`, but doesn't save the result. 
- `B.cond label`: branches to label if the CPSR matches some criteria. `CMP` and `B.cond` combine into an equivalent to the C statement `if (Ra </=/>/≥/≤/≠ Rb) goto label;`. if the condition is not met, the program continues normally.
  - ![all conditions for B.cond and their functions](image-9.png)


## Directives
all valid assembly programs need a `.text` directive to contain the exit procedure. when a program contains multiple header directives (most will have `.text` and `.data` and more), they can be present in any order.
- `.bss`: section header. a place for allocating empty space for global uninitialized variables. short for block starting symbol; i.e. the start of a block of empty space that we're guaranteed.
- `.data`: section header. a place for storing global variables.
- `.text`: section header. where all of your instructions can go.
- `.extern label`: assert to the assembler that a label is defined in another file. usually declared at the start of `.text` file after `.global`. this is **not** an `include` or `import` statement; you must include the file that contains that label during linking. 
- `.global label`: tells the assembler that the program starts at `label`.
- `.skip size, fill`: `size` and `fill` are immediates. for use in `.bss`. creates a space of `size` filled with `fill`. functionally similar to `.space`.
- `.space size, fill`: `size` and `fill` are immediates. for use in `.bss`. creates a space of `size` filled with `fill`. functionally similar to `.skip`.