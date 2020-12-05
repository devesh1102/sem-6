function [Dit] = dit_cal(E)
A1=6e12;
A2 = A1;
A3=2e12; 
B1 = 0.1;
B2 = 0.97;
B3 =  0.5;
C1=0.2;
C2 =C1;
C3=0.5;
Dit1 = A1*(exp(-1*( (E - B1)/C1)*( (E - B1)/C1)));
Dit2 =A2*(exp(-1*( (E - B2)/C2)*( (E - B2)/C2))) ;
Dit3 =A3*(exp(-1*( (E - B3)/C1)*( (E - B3)/C3)));
Dit =(Dit3+Dit2 +Dit1)*10^4;
end

