REG A B C I E F
    1 0 0 0 0 0

                          # Valid if registers B-F are set to 0
0	I = I + 16			>           jmp start
1	C = 1			    > init:     C = 1
2	E = 1			    > reset:    E = 1
3	B = C * E			> loop:     B = C * E
4	B = B == F ? 1 : 0  >           jmp add if B == F
5	I = B + I			>
6	I = I + 1			>           jmp noadd 
7	A = C + A			> add:      A += C
8	E = E + 1			> noadd:    E++
9	B = E > F ? 1 : 0   >           jmp inc if E > F
10	I = I + B			>
11	I = 2			    >           jmp loop
12	C = C + 1			> inc:      C++
13	B = C > F ? 1 : 0	>           jmp end if C > F
14	I = B + I			>
15	I = 1			    >           jmp reset 
16	I = I * I			> end:      exit
17	F = F + 2			> start:
18	F = F * F			>
19	F = I * F			>
20	F = F * 11			>
21	B = B + 3			>
22	B = B * I			>
23	B = B + 12			>           B = 78
24	F = F + B			>           F = 914
25	I = I + A			>           jmp g if A > 0 and A < 6
26	I = 0			    >           jmp init
27	B = I			    >
28	B = B * I			>
29	B = I + B			>
30	B = I * B			>
31	B = B * 14			>
32	B = B * I			> g:        B = 10550400
33	F = F + B			>           F += 10551314
34	A = 0			    >           A = 0
35	I = 0			    >           jmp init 
