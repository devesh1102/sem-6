syms s
p = 6.13/(1000*s + 19)
c1 = 3*(100*s +40 )*(s+0.6)/(s*(s+0.5))
c2= 13.53*s/(s+0.5)
ch_eqn  = 1+p*(c1+c2)
pretty(simplify(ch_eqn))
[n m] = numden(ch_eqn)
open =p*(c1+c2)
[discrete_N1,discrete_D1] = numden(open);

discrete_N1 = sym2poly(discrete_N1);
discrete_D1 = sym2poly(discrete_D1);
k = discrete_D1(1);                                          %normalisation factor
discrete_N1 = discrete_N1/k
discrete_D1 = discrete_D1/k
tansfer = tf(discrete_N1,discrete_D1)