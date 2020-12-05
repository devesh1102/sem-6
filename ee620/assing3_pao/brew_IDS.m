function [vd,Id_final] = brew_IDS(vg_given)
E_sio2 = 3.9*8.85 * 10^-12;
E_si = 11.9*8.85 * 10^-12;
ni = 10^16;
na = 5*10^21;
tox = 5*10^-9;
k = 1.380*10^-23;
q = 1.6*10^-19;
t = 300;
eg = 1.1;
kt_q = 0.025;
Cmax = E_sio2/tox;
phi_f =kt_q*log(na/ni);
w = 40 *10^-3
ueff = 800 * 10^-4
l = 1* 10^-3;
x = linspace(-1*phi_f,3*phi_f);
y = zeros(1,100);
Vfb = -0.2;
samples=50;
%vg = 1.5
syms S vg
term1 = Cmax*(vg - Vfb- S);
term2 = sqrt(2*E_si*q*na*S);
term3_n = Cmax*term1 + E_si*q*na;
term3_d = term1 +term2;
eqn = (ueff*w/l)*(term1 -term2 +(2*kt_q*term3_n/term3_d));
Id= int(eqn,S);
%for VDs VS Ids
Id1= Id
vg =   vg_given;
vd = linspace(0,2.5,samples);
Id1 = subs(Id1);


syms psi_s
pre_fac = sqrt(2*E_si*k*t*na)/Cmax;
vg_eqn1 = Vfb +psi_s +pre_fac*sqrt((psi_s/kt_q + (ni/na)*(ni/na)*exp((psi_s)/kt_q)));
S = solve([vg_eqn1 == vg], psi_s);
Id_high = zeros(1,samples);
Id_low= subs(Id1);
for i = 1:samples
    vg_eqn1 = Vfb +psi_s +pre_fac*sqrt((psi_s/kt_q + (ni/na)*(ni/na)*exp((psi_s - vd(1,i))/kt_q)));
    S = solve([vg_eqn1 == vg], psi_s);
    Id_high(1,i) = subs(Id1);
end
% term4 = Cmax*Cmax*(vg - Vfb- psi_s) *(vg - Vfb- psi_s)/(2*k*t*na*E_si)
% facter = na*na/(ni*ni);
% V_exp = psi_s - kt_q*(log(abs(facter*(term4 - (psi_s/kt_q)))))
% psi_ss = solve([V_exp == 0], psi_s);
% Id1_dummy = Id1;
%   S = psi_ss;
%   Id_low = subs(Id1_dummy);
% Id_high = zeros(1,samples);
% for i = 1:samples
%      Id1_dummy = Id1;
%     S = solve([V_exp == vd(1,i)], psi_s);
%     Id_high(1,i) = subs(Id1_dummy);
%     
% end
Id_final = Id_high - Id_low;
end

