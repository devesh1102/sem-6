g1=tf([1],[1 3]) % your GH(s) transfer function
g3=tf([5],[1 1])
g2 = tf([100],[1 10])
%g2=tf([1],[1 100 2600]) % your second TF (s+1)/(s+9)
%g4=tf([1],[1 5])
 g=g1*g3*g2
 RLocusGui(g) 
 figure(1)
 rlocus(g)
MARGin(sys)
   b0=0; b1=1.7321;
  x= linspace(-16,0, 100); % Adapt n for resolution of graph
  y= b0-b1*x;
  plot(x,y)
  hold on
 rlocus(g)
  
  hold off
  
 syms s
 eqn = atan(s/2) + atan(4*s/(13- s*s))
aa =  solve(eqn == pi)
syms wp wn
sys = tf([1], [1 16 361 ])
 S = stepinfo(sys)
% S = struct with fields:
%         RiseTime: 3.8456
%     SettlingTime: 27.9762
%      SettlingMin: 2.0689
%      SettlingMax: 2.6873
%        Overshoot: 7.4915
%       Undershoot: 0
%             Peak: 2.6873
%         PeakTime: 8.0530

syms k E
qq = [1 7 14 8+k 3*k]
ra = routh(qq,E);%if one row is zero then there is possibility of imaginary
pretty(simplify(ra))
%%s2+2*zeta*wn*s + wn^2
%%wd = Wn*sqrt(1-zeta*zeta);
%%ts = 4/(zeta*Wn)
%%tp = pi/(wn *sqrt(1-zeta*zeta))
%%os = exp(-1*zeta*pi/(sqrt(1-zeta*zeta)))  *100
%%tan = sqrt(1-zeta*zeta)/zeta
s = tf('s');

G1 = (s+8)/((s+3)*(s+6)*(s+10));
syms x
zeta = 0.456;
hold on
rlocus(G1);
plot (3*x)
sgrid(zeta,0);
