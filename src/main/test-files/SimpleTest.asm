@256
D=A
@SP
M=D
@PROGRAM_START
0;JMP
(arithmetic_add)
@SP
AM=M-1
D=M
A=A-1
M=M+D
@R14
A=M
0;JMP
(PROGRAM_START)
@7
D=A
@SP
AM=M+1
A=A-1
M=D
@8
D=A
@SP
AM=M+1
A=A-1
M=D
@32
D=A
@R14
M=D
@arithmetic_add
0;JMP
