@PROGRAM_START
0;JMP
(ARITHMETIC_ADD)
@SP
AM=M-1
D=M
A=A-1
M=M+D
@ARITHMETIC_LIB_END
0;JMP
(ARITHMETIC_AND)
@SP
AM=M-1
D=M
A=A-1
M=M&D
@ARITHMETIC_LIB_END
0;JMP
(ARITHMETIC_EQ)
@SP
AM=M-1
D=M
A=A-1
D=M-D
@ARITHMETIC_IS_EQUAL
D;JEQ
D=-1
(ARITHMETIC_IS_EQUAL)
@SP
A=M-1
M=!D
@ARITHMETIC_LIB_END
0;JMP
(ARITHMETIC_GT)
@SP
AM=M-1
D=M
A=A-1
D=M-D
@ARITHMETIC_IS_GT
D;JGT
D=0
@ARITHMETIC_GT_RESOLVE
0;JMP
(ARITHMETIC_IS_GT)
D=-1
(ARITHMETIC_GT_RESOLVE)
@SP
A=M-1
M=D
@ARITHMETIC_LIB_END
0;JMP
(ARITHMETIC_LT)
@SP
AM=M-1
D=M
A=A-1
D=M-D
@ARITHMETIC_IS_LT
D;JLT
D=0
@ARITHMETIC_LT_RESOLVE
0;JMP
(ARITHMETIC_IS_LT)
D=-1
(ARITHMETIC_LT_RESOLVE)
@SP
A=M-1
M=D
@ARITHMETIC_LIB_END
0;JMP
(ARITHMETIC_NEG)
@SP
A=M-1
M=-M
@ARITHMETIC_LIB_END
0;JMP
(ARITHMETIC_NOT)
@SP
A=M-1
M=!M
@ARITHMETIC_LIB_END
0;JMP
(ARITHMETIC_OR)
@SP
AM=M-1
D=M
A=A-1
M=M|D
@ARITHMETIC_LIB_END
0;JMP
(ARITHMETIC_SUB)
@SP
AM=M-1
D=M
A=A-1
M=M-D
(ARITHMETIC_LIB_END)
@R14
A=M
0;JMP
(PROGRAM_START)
@0
D=A
@SP
AM=M+1
A=A-1
M=D
@R1
D=M
@0
D=A+D
@R14
M=D
@SP
AM=M-1
D=M
@R14
A=M
M=D
(BasicLoop$LOOP_START)
@R2
D=M
@0
A=A+D
D=M
@SP
AM=M+1
A=A-1
M=D
@R1
D=M
@0
A=A+D
D=M
@SP
AM=M+1
A=A-1
M=D
@128
D=A
@R14
M=D
@ARITHMETIC_ADD
0;JMP
@R1
D=M
@0
D=A+D
@R14
M=D
@SP
AM=M-1
D=M
@R14
A=M
M=D
@R2
D=M
@0
A=A+D
D=M
@SP
AM=M+1
A=A-1
M=D
@1
D=A
@SP
AM=M+1
A=A-1
M=D
@161
D=A
@R14
M=D
@ARITHMETIC_SUB
0;JMP
@R2
D=M
@0
D=A+D
@R14
M=D
@SP
AM=M-1
D=M
@R14
A=M
M=D
@R2
D=M
@0
A=A+D
D=M
@SP
AM=M+1
A=A-1
M=D
@SP
AM=M-1
D=M
@BasicLoop$LOOP_START
D;JNE
@R1
D=M
@0
A=A+D
D=M
@SP
AM=M+1
A=A-1
M=D