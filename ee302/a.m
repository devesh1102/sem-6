 syms s;
 ps = 10/(s^2 +5*s +10)
 qs = (s+1)/(s^2 + 1 ) 
% aw= [ 1 5 11 15 20]
pretty((simplify((-1*ps*qs)/(1+(ps*qs)))));

((ilaplace(((ps/(s*(1+(ps*qs))))))))