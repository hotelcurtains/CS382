str(bin(i))[2:]

RegWrite = 1

ADD/SUB
- ReadToReg = 0
  - MemRead = 0
  - MemToReg = 0
- MemWrite = 0
- ALUop: ADD = 0, SUB = 1
- OnlyRegs = syntax-defined
  - Reg2Loc = syntax-defined
  - ALUsrc = syntax-defined

LDR/STR
- ReadToReg: LDR = 1, STR = 0
- MemWrite: LDR = 0, STR = 1
- ALUop = 0 = ADD
- OnlyRegs = syntax-defined
  - Reg2Loc = syntax-defined
  - ALUsrc = syntax-defined


# machine code: ABCDEEFF GGHHHHHH
- Operations
  - A = ReadToReg 
    - define ReadToReg = MemRead = MemToReg
    - A = 0 for ADD, SUB, STR
    - A = 1 for LDR
  - B = MemWrite
    - B = 0 for ADD, SUB, LDR 
    - B = 1 for STR
  - C = ALUop
    - C = 0 for ADD, LDR, STR
    - C = 1 for SUB
  - D = UseImm
    - replaces Reg2Loc and ALUsrc.
    - depends on syntax, therefore it is detected for each occurrence by the compiler.
- Operands
  - DD = Reg1 ∈ [0, 3]
  - EE = Reg2 ∈ [0, 3]
  - if OnlyRegs = 1, then FF = Reg3 ∈ [0, 3] and GGGGGG = 0.
  - if OnlyRegs = 0, then FFGGGGGG = unsigned immediate ∈ [0, 255]


e.g.
- `ADD X1, X0, X3` = `0000 01 00 11 000000`
  - ReadToReg = 0 for ADD
  - MemWrite = 0 for ADD
  - ALUop = 0 for ADD
  - UseImm = 0 since we use no immediate
  - Reg1 = X1 = 01
  - Reg2 = X0 = 00
  - Reg3 = X3 = 11 because UseImm = 0
  - HHHHHH = 000000 because UseImm = 0
- `SUB X2, X3, 200` = `0111 10 11 11001000`
  - ReadToReg = 0 for SUB
  - MemWrite = 1 for ADD
  - ALUop = 1 for SUB
  - UseImm = 1 since we use an immediate
  - Reg1 = X2 = 10
  - Reg2 = X3 = 11
  - GGHHHHHH = 0d200 = 0b11001000 because UseImm = 1