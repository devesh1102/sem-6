
%Everything is in SI unit
E_sio2 = 3.9*8.85 * 10^-12;
E_si = 11.9*8.85 * 10^-12;
ni = 10^16;
na = 10^23;
tox = 5*10^-9;
k = 1.380*10^-23;
q = 1.6*10^-19;
t = 300;
Vfb = -0.95;
eg = 1.1;
kt_q = 0.025;
Cmax = E_sio2/tox;
phi_f =kt_q*log(na/ni);

phi_s = linspace(-0.5*phi_f,2.5*phi_f,10000);
y = zeros(1,10000);
for i = 1:10000
    y(1,i) = total_charge(phi_s(1,i),tox,na);
    Vg(1,i) = Vfb+phi_s(1,i)+sign(phi_s(1,i))*(total_charge(phi_s(1,i),tox,na)/Cmax );

end
for i = 2:10000
    diff_q(1,i) = total_charge(phi_s(1,i),tox,na) - total_charge(phi_s(1,i-1),tox,na);
    diff_ps(1,i) =phi_s(1,i)-phi_s(1,i-1);
    cs (1,i) = abs(diff_q(1,i)/diff_ps(1,i));
    
end
dumm= cs.*Cmax ;
ctotal = dumm./ (cs+Cmax);
Vg = Vg(4:end);
ctotal = ctotal(4:end);



figure(1)
scatter(Vg,ctotal)
title('C vs VG ')
xlabel(' VG(in V)') 
ylabel('C in F/m^2')