syms k s
a=[0 1 0; 0 0 1;-6.614*k -171 -101.7]
b = [0;0;0.318*k]
c = [20.8 0 0]
d = [0]
I = [1 0 0 ;0 1 0; 0 0 1] 
dimm = s*I -a
q = dimm^(-1)
X = q*b
traf = c*X+d

kk= 79500*s^3 + 8085150*s^2 + 13594500*s + 525813*k


