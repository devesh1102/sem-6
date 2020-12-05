tox = 2.5*10^-9;
na = 10^23;

k = 1.380*10^-23;
q = 1.6*10^-19;
t = 300;
E_si = 11.9*8.85 * 10^-12;

ni = 10^16
phi_f =kt_q*log(na/ni);
wmax = sqrt(2 *E_si*2*phi_f/(q*na))
m = 1+ ((3*tox)/wmax);
s = k*t*m*2.3/q

