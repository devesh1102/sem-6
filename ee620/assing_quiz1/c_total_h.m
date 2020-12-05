function [c] = c_total_h(psi_s,Cmax,na)
E_sio2 = 3.9*8.85 * 10^-12;
E_si = 11.9*8.85 * 10^-12;
ni = 10^16;
k = 1.380*10^-23;
q = 1.6*10^-19;
t = 300;
eg = 1.1;
kt_q = 0.025;

%phi_f =kt_q*log(na/ni);
%psi_s = 2*phi_f;
%V_fb = phi_f+eg/2;

a = psi_s/ kt_q;
prefactor = sqrt(2*E_si* k*t*na);
b = ni*ni/(na*na);

%num = prefactor*(1-exp(-a)+b*(exp(a)-1));
%dem = 2*sqrt(exp(-a) + (a-1) + b*(-a-1+exp(a)));

num = prefactor*(1-exp(-a)+b*(-1));
dem = 2*sqrt(exp(-a) + (a-1) + b*(-a-1));

C_s = num/(kt_q*dem);
%c = abs(C_s)
%c = C_s*Cmax/(C_s+Cmax);
c = abs(C_s)*Cmax/(abs(C_s)+Cmax);

end

