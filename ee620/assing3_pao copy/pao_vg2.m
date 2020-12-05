E_sio2 = 3.9*8.85 * 10^-12;
E_si = 11.9*8.85 * 10^-12;
ni = 10^16;
na = 10^23;
tox = 5*10^-9;
k = 1.380*10^-23;
q = 1.6*10^-19;
t = 300;
eg = 1.1;
kt_q = 0.025;
Cmax = E_sio2/tox;
phi_f =kt_q*log(na/ni);
w = 10 *10^-3
ueff = 300 * 10^-4
l = 1* 10^-3;
x = linspace(-1*phi_f,3*phi_f);
y = zeros(1,100);
Vfb = -0.95;
samples_vg = 50;
samples_vds = 50;
%%%%%vgs vs Ids%%%%%%%%%%%%%
vg =linspace(0,5.2,samples_vg);
vds = linspace(0,2.56,samples_vds);
pre_fac = sqrt(2*E_si*k*t*na)/Cmax;
psi_s = zeros(1,samples_vds,samples_vg);
for j = 1:samples_vg%changing various values of Vg
 for i = 1:samples_vds% getting various values of psi for different V
     syms psi_s1
     vg_eqn1 = Vfb +psi_s1 +pre_fac*sqrt((psi_s1/kt_q + (ni/na)*(ni/na)*exp((psi_s1 - vds(1,i))/kt_q)));
     psi_s(1,i,j)= solve([vg_eqn1 == vg(1,j)], psi_s1);
 end
end
 %%%i got psi_s for various values of V
pre_fac2 = sqrt(2*k*t*na/E_si);
pre_int=(q*ueff*w*ni*ni/(na*l));
ratio = ni*ni/(na*na);
Ids = zeros(1,samples_vg);
prefac_1 = ni*ni*q*ueff*w/(l*na*sqrt(2*k*t*na/E_si));
for i = 1:samples_vg-1%%getting different values of Ids
    dummy = 0;
    for j = 1:samples_vds-1 %%changing V loop from 0 to Vds
        dummy2 = 0;
        for k = 1:j%%changing Psi_s for  v_ds(1,j) loop
            diff=(psi_s(1,k,i) - vds(1,j));
            derivative = sqrt((psi_s(1,k,i)/kt_q)+ ratio*exp(diff/kt_q));
            increment = exp((diff)/kt_q)/derivative;
            dummy2= dummy2 + (increment* abs((psi_s(1,k,i) - psi_s(1,k+1,i))));  
            
        end
        dummy =dummy + (dummy2 * abs((vds(1,j) - vds(1,j+1))));
        
    end
    Ids(1,i) =prefac_1 * dummy;
end

Ids(1,samples_vg ) =  Ids(1,samples_vg -1);
figure(1)
plot(vg,Ids)
title('I_{ds} . vs V_{g} (Pao shah)')
xlabel(' Vg(in V)') 
ylabel('Id in A')















 