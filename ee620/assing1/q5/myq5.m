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
Vfb = -0.95;
samples = 100;
psi_s = zeros(1,samples);
q_acc =  zeros(1,samples);
q_dep =  zeros(1,samples);
q_inv =  zeros(1,samples);
C_hfcv =  zeros(1,samples);
C_lfcv =  zeros(1,samples);
%%%%for qn 2 PSi vs vg
Vg = linspace(-2,2,samples);
signal = 0;
Vt = 0 ;
%q_max_depletion = 
for i = 1:samples
    
    prefactor = q* na * E_si/(2 * Cmax *Cmax);
    a = 2 * Cmax * Cmax * (Vg(1,i) - Vfb)/(q*na* E_si);
    b  = prefactor * (sqrt(1+a) - 1)* (sqrt(1+a) - 1);
if b<0;
    psi_s(1,i) = 0;
    C_lfcv(1,i) =Cmax;
    q_inv(1,i) = 0 ;
    q_dep(1,i) = 0 ;
    q_acc(1,i) = -1*Cmax*(Vg(1,i) - Vfb);
    C_hfcv(1,i)  =  C_lfcv(1,i);  
%    qs(1,i) = -Cmax*(Vg-Vfb);
elseif b>0 && b<  2*phi_f
    W = (E_si/Cmax)*(sqrt(1+a) - 1);
    q_inv(1,i) = 0 ;
    q_dep(1,i) = -q*na*W ;
    q_acc(1,i) = 0;
    C_lfcv(1,i) =Cmax*( E_si/W)/(( E_si/W)+ Cmax);
    C_hfcv(1,i)  =  C_lfcv(1,i); 
    psi_s(1,i) = b;
elseif b>2*phi_f
    if signal == 0
       Vt = Vg(1,i);
    end
        signal = 1;
        psi_s(1,i) =2*phi_f;
        W = sqrt(2*E_si* psi_s(1,i)/(q*na));
        C_lfcv(1,i) = Cmax;
        C_hfcv(1,i) =Cmax*( E_si/W)/(( E_si/W)+ Cmax);
       q_inv(1,i) = -1*Cmax*(Vg(1,i) - Vt) ;
       q_dep(1,i) = -q*na*W ;
       q_acc(1,i) = 0;     
 
end
end
q_total = q_inv + q_dep + q_acc;
figure(1)
plot(Vg,psi_s)
title('\psi _{s} vs VG}')
xlabel(' VG(in V)') 
ylabel('\psi _{s}') 

figure(2)
plot(Vg,C_hfcv,Vg,C_lfcv)
title(' VG vs C (hfcv) ')
xlabel(' VG(in V)') 
ylabel(' in F/m^2') 


figure(3)
plot(Vg,C_lfcv)
title(' VG vs C (lfcv) ')
xlabel(' VG(in V)') 
ylabel(' in F/m^2') 


figure(4)
plot(psi_s,q_total)
title(' VG vs Q_s ')
xlabel(' VG(in V)') 
ylabel(' Q C/m^2') 

%q vs 


