          0	E = 123
  chk:    1	E = E & 456
  E==72 & 2	E = E == 72 ? 1 : 0
   jmp a  3	I = E + I
  jmp chk 4	I = 0
a:        5	E = 0
g:        6	D = E | 65536
          7	E = 12670166
e:        8	C = D & 255
          9	E = E + C
          10	E = E & 16777215
          11	E = E * 65899
          12	E = E & 16777215
  256>D & 13	C = 256 > D ? 1 : 0
   jmp h  14	I = C + I
  jmp b-1 15	I = I + 1
h: jmp f  16	I = 27
          17	C = 0
b:        18	F = C + 1
          19	F = F * 256
  F>D &   20	F = F > D ? 1 : 0
   jmp x  21	I = F + I
  jmp c   22	I = I + 1
x: jmp d  23	I = 25
c:        24	C = C + 1
  jmp b   25	I = 17
d:        26	D = C
  jmp e   27	I = 7
f: E==A & 28	C = E == A ? 1 : 0
  exit    29	I = C + I
g: jmp g  30	I = 5

