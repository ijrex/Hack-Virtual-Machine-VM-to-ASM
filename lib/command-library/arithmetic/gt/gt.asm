  @SP
  AM=M-1
  D=M
  A=A-1
  D=D-M
  @ARITHMETIC_GT 
  D;JGT
  D=0
  @ARITHMETIC_GT_RESOLVE
  0;JMP
(ARITHMETIC_GT)
  D=-1
(ARITHMETIC_GT_RESOLVE)
  @SP
  A=M-1
  M=D


