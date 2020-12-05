syms s
pretty(simplify(ilaplace(1/(s-1919))))
transfer = s*2/(s*2 +1)

b = [0 2 3];
a = [1 0.4 1];
% tf is . = 2*s +3 /(s^2 +0.4s+ 1
[A,B,C,D] = tf2ss(b,a)
[num,den] = ss2tf(A,B,C,D)

%transfer 
 %freqz(b,a)
%%%%%%%%step response
 M = 1;  % units of kg
 K = 10; % units of N/m
 B = 2;  % units of N-s/m
 num = 1;
 den = [M B K];
 sys = tf(num,den)
 [q d] = step(sys)
 
 roots([1 5 11 15 20])