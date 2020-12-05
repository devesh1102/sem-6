%step r = 1/s
%ramp r = 1/s*s
%parabolic r = 1/s*s*s
%type0  = l(s)
%type1 = l(s)/s
%type2 =l(s)/s*s
%E =r/(1+l)
%ess = lim (sE)...s tends to 0
%for inverse to exist 
% x. = Ax+bu
% y = cx +du
% u = -d^-1 cx + d^-1y
% X. = Ax + b*(-d^-1 cx + d^-1y)
% X. = Ax - b*d^-1 cx  + ( b*d^-1)y
% sensitivity = delta t/t(telda)/(delta p/p(telda))
delta t =  
%z=n-p.......n number of counter clock wise rotation of countour B
% 
% MATLAB Commands -
%  
% 1. Making a transfer function -
%                 - Define a variable using command : s = tf('s')
%                 - G = 1/(s*(s+2)*(s^2+s*4+1)) as an example is our transfer function
%  
% 2. Alternate method for transfer function -
%                 - num = 1;
%                 - den = [1 8 10 0 15];
%                 - g = tf(num, den)
%                 - This gives the transfer function 1/(s^4 + 8s^3 + 10s^2 + 15)
%  
% 3. Another method (using ZPK) -
%                 - g = zpk([], [0, -4, 2+4i, 2-4i], 5)
%                 - Here, g = 5/(s*(s+4)*(s-2-4i)*(s-2+4i))
%  
% 4. Finding poles and zeros
%                 - pole(g) gives poles of g in a matrix form
%                 - zero(g) gives zeros of g in matrix form
%  
% 5. Root Locus Plots -
%                 - pzmap(g) gives a pole zero maps
%                 - Better way is to use rlocus(g)
%  
% 6. Step Response -
%                 - step(g) gives the step response
%                 - impulse(g) gives the impulse response
%  
% 7. Transfer function and State Space Models 0
%                 - tf2ss
%                 - ss2tf
%                 - Or we can use ss(g) to get state space model of g
%  
% 8. Bode Plot can be made by using bode(g)
%  
% 9. Feedback -
%                 - feedback(a,b) = a/1+ab  (while working with polynomials)
%                 - feedback(a_ss, b) (where a_ss is the state space model of the open loop system and b is same as earlier)
%  
% 10. eig(a) : Returns eigen values of a
% 11. exp(a) : Returns e^a
% 12. [a,b,b; d,e,f] and so on will make a 2x3 matrix of specified elements
% 13. [a,b,c,d] = ssdata(a_ss) will give the ABCD matrices of the state space representation a_ss
% 14. Using Laplace and Inverse Laplace -
%                 - syms s t (Define the needed symbols. Maybe define constant symbols too if needed)
%                 - ilaplace(f(s),s,t) (For any expression f(s) in s)
%                 - laplace(g(t),t,s) (For any expression g(t) in t)
% 14. diff(f(t)) performs differentiation
% 15. int(f(t), a, b) performs integration from a to b. If no limits specified, then indefinite integration
% 16. inv(a) does the inverse of a matrix



