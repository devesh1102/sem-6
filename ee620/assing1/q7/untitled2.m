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
oxide_charge =q*10^24*tox; 
phi_f = - kt_q*log(abs(na)/ni);

Vfb = -0.95;
Vfb =  Vfb + (oxide_charge*q/Cmax);
samples = 1000;
C_lfcv =  zeros(1,samples);
c_hfcv =  zeros(1,samples)
Vg = linspace(-5,5,samples)
for i = 1:samples
    prefactor = q* na * E_si/(2 * Cmax *Cmax)
    a = 2 * Cmax * Cmax * (Vg(1,i) - Vfb)/(q*na* E_si);
    psi_s = prefactor * (sqrt(1+a) - 1)* (sqrt(1+a) - 1);
   
if Vg(1,i)<Vfb 
    C_lfcv(1,i) = Cmax;
    C_hfcv(1,i) = C_lfcv(1,i);
elseif psi_s >= 0 && psi_s <= 2 * phi_f
 	W = sqrt(2*E_si * psi_s/(q*na));
    C_lfcv(1,i) = Cmax*(E_si/W)/( Cmax + (E_si/W));
    C_hfcv(1,i) = C_lfcv(1,i);
else
    W = sqrt(2*E_si * (2*phi_f)/(q*na));
    C_lfcv(1,i) = Cmax;
    C_hfcv(1,i) =Cmax*(E_si/W)/( Cmax + (E_si/W));
  
end
end
figure(1)
plot(Vg,C_lfcv)
title('C vs VG (lfcv)')
xlabel(' VG(in V)') 
ylabel('C in F/ m^{2}') 

figure(2)
plot(Vg,C_hfcv)
title('C vs VG (hfcv)')
xlabel(' VG(in V)') 
ylabel('C in F/ m^{2}')

%q vs 


