function [psi_s] = qn2(Vg,tox,na)
E_sio2 = 3.9*8.85 * 10^-12;
E_si = 11.9*8.85 * 10^-12;
ni = 10^16;
k = 1.380*10^-23;
q = 1.6*10^-19;
t = 300;
eg = 1.1;
kt_q = 0.025;
Cmax = E_sio2/tox;
 Vfb = -0.95;

prefactor = q* na * E_si/(2 * Cmax *Cmax)
a = 2 * Cmax * Cmax * (Vg - Vfb)/(q*na* E_si)
psi_s = prefactor * (sqrt(1+a) - 1) * (sqrt(1+a) - 1)

end

