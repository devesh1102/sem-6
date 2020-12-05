
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
%Vfb = -0.95;
%f =  @(Vg,phi_s) -1*Vg+Vfb+phi_s+sign(Vg-Vfb)*(total_charge(phi_s,tox,na)/Cmax);
%figure
%fimplicit(f,[-2 2 -1*phi_f 3*phi_f])
%title('\psi_{s} vs Vg ')
%xlabel('Vg (in V)') 
%ylabel('  \psi_{s}') 



phi_s = linspace(-0.5*phi_f,2.5*phi_f);
y = zeros(1,100);
Vg = zeros(1,100);
for i = 1:100
    y(1,i) = total_charge(phi_s(1,i),tox,na);
    Vg(1,i) = Vfb+phi_s(1,i)+sign(phi_s(1,i))*(y(1,i)/Cmax);
end
figure
plot(Vg,phi_s)
title('VG VS \psi_{s}')
xlabel('Vg (in V)') 
ylabel('\psi_{s} (in V)') 
