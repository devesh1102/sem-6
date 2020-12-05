
%Everything is in SI unit
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

x = linspace(-1*phi_f,3*phi_f);
y = zeros(1,100);
for i = 1:100
    y(1,i) = total_charge(x(1,i),tox,na);
end
figure
semilogy(x,y)
title('Q total VS \psi_{s} (without approximation)')
xlabel(' \psi_{s} (in V)') 
ylabel('|Q| . (in C / m^2')


