E_sio2 = 3.9*8.85 * 10^-12;
E_si = 11.9*8.85 * 10^-12;
na = 10^23;
ni = 10^16;
tox = 5*10^-9;
k = 1.380*10^-23;
q = 1.6*10^-19;
t = 300;
eg = 1.1;
kt_q = 0.025;
Cmax = E_sio2/tox;
phi_f =kt_q*log(na/ni);
psi_s = 2*phi_f;
V_fb = phi_f+eg/2;
a = psi_s/ kt_q;
prefactor = sqrt(2*E_si* k*t*na);
Q_acc = ((exp(-1*a)))
Q_dep = (((a-1)))
Q_inv = ((ni*ni)/(na*na)) * ( exp(a) -a -1)
Q_total = prefactor * (sqrt(Q_acc + Q_dep + Q_inv))
%Q_acc = sqrt(2*E_si* k*t*na)*sqrt((exp(-1*a)))
%Q_dep = sqrt(2*E_si* k*t*na)*sqrt((-1+(a)))
%Q_inv = sqrt(2*E_si* k*t*na)* sqrt((ni*ni*( exp(a)-(a)-1))/(na*na))
%q_ox =Q_inv;



