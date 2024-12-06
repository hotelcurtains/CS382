- ADD Rdest Ra Rb
  - `ADD R1 R0 R3` = `0000010011000000`
- ADD Rdest Ra imm8
  - `ADD R2 R1 15` = `0001100100001111`

- DIV Rdest Ra Rb
  - `DIV R3 R2 R1` = `0010111001000000`
- DIV Rdest Ra imm8
  - `DIV R0 R3 5` = `0011001100000101`

- LDR Rdest Radr
  - `LDR R0 R1` = `1001000100000000`
- LDR Rdest Radr imm8
  - `LDR R1 R2 4` = `1001011000000100`
- LDR Rdest Radr Roffset
  - `LDR R2 R3 R0` = `1000101100000000`

- STR Rsrc Radr
  - `STR R0 R1` = `0101000100000000`
- STR Rsrc Radr imm8
  - `STR R3 R2 8` = `0101111000001000`

- MOV Rdest imm8
  - DIV Rdest Rdest 0
  - if imm8 != 0, then: ADD Rdest Rdest imm8
- MOV Rdest Rsrc
  - DIV Rdest Rdest 0
  - ADD Rdest Rdest Rsrc

- don't forget comments


# machine code: ABCDEEFF GGHHHHHH
- Operations
  - A = ReadToReg 
    - define ReadToReg = MemRead = MemToReg
    - A = 0 for ADD, DIV, STR
    - A = 1 for LDR
  - B = MemWrite
    - B = 0 for ADD, DIV, LDR 
    - B = 1 for STR
  - C = ALUop
    - C = 0 for ADD, LDR, STR
    - C = 1 for DIV
  - D = UseImm
    - replaces Reg2Loc and ALUsrc.
    - depends on syntax, therefore it is detected for each occurrence by the compiler.
- Operands
  - DD = WriteReg ∈ {0, 3}
  - EE = Reg1 ∈ {0, 3}
  - if OnlyRegs = 1, then FF = Reg2 ∈ {0, 3} and GGGGGG = 0.
  - if OnlyRegs = 0, then FFGGGGGG = 8-bit immediate ∈ {0, 255}