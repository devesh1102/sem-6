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
facter = (ni*ni)/(na*na);
samples=100;
%vg = 1.5
syms S vg
term1 = Cmax*(vg - Vfb- S);
term2 = sqrt(2*E_si*q*na*S);
term3_n = Cmax*term1 + E_si*q*na;
term3_d = term1 +term2;
eqn = (ueff*w/l)*(term1 -term2 +(2*kt_q*term3_n/term3_d));
Id= int(eqn,S);
%for Vgs VS Ids
Id1= Id;
vds =2.5;
vg_f = linspace(0,1.5,samples);
psi_ss = zeros(1,samples);
psi_sd = zeros(1,samples);

pre_fac = sqrt(2*E_si*k*t*na)/Cmax;
for i = 1:samples
    syms psi_s
    vg_eqn1 = Vfb +psi_s +pre_fac*sqrt((psi_s/kt_q + facter*exp((psi_s - vds)/kt_q)));
    psi_sd(1,i) = solve([vg_eqn1 == vg_f(1,i)], psi_s);
    vg_eqn2 = Vfb +psi_s +pre_fac*sqrt((psi_s/kt_q + facter*exp((psi_s)/kt_q)));
    psi_ss(1,i) = solve([vg_eqn2 == vg_f(1,i)], psi_s);
end
Id_high = zeros(1,samples);
Id_low =zeros(1,samples);
for i = 1:samples
    vg = vg_f(1,i);
    S = psi_sd(1,i);
    Id_high(1,i) = subs(Id);
    vg = vg_f(1,i);
    S = psi_ss(1,i);
    Id_low(1,i) = subs(Id);
end
Id_f = Id_high-Id_low;
figure(12)
semilogy(vg_f,Id_f)
title('I_{ds} . vs V_{gs} (Brews)')
xlabel(' Vg (in V)') 
ylabel('Id in A')
% syms psi_s
% term4 = Cmax*Cmax*(vg - Vfb- psi_s) *(vg - Vfb- psi_s)/(2*k*t*na*E_si)
% facter = na*na/(ni*ni);
% V_exp = psi_s - kt_q*(log(facter*(term4 - (psi_s/kt_q))))
% psi_ss = solve([V_exp == 0], psi_s);
% Id_high = zeros(1,50);
% for i = 2:samples
%     dummy = solve([V_exp == vd(1,i)], psi_s);
%     Id1_dummy = ID1;
%     Id_high(1,i) = dummy;
%     
% end
