E_sio2 = 3.9*8.85 * 10^-12;
E_si = 11.9*8.85 * 10^-12;
na = [10^23 10^20 10^22 10^24];
ni = 10^16;
tox = [3*10^-9 5*10^-9 7*10^-9];
%tox = 3*10^-9
%na = 10^23;
k = 1.380*10^-23;
q = 1.6*10^-19;
t = 300;
eg = 1.1;
kt_q = 0.025;

Vfb = -0.95;
%Vfb = -0.95;
%f =  @(Vg,phi_s) -1*Vg+Vfb+phi_s+sign(Vg-Vfb)*(total_charge(phi_s,tox,na)/Cmax);
%figure
%fimplicit(f,[-2 2 -1*phi_f 3*phi_f])
%title('\psi_{s} vs Vg ')
%xlabel('Vg (in V)') 
%ylabel('  \psi_{s}') 




charge = zeros(1,100,6);
Vg = zeros(1,100,6);
c = zeros(1,100,6);
c_hf = zeros(1,100,6);
for j = 1:3
    Cmax = E_sio2/tox(j);
    phi_f =kt_q*log(na(1)/ni);
    phi_s = linspace(-0.5*phi_f,2.5*phi_f);
    for i = 1:100
        charge(1,i,j) = total_charge(phi_s(1,i),tox(j),na(1));
        Vg(1,i,j) = Vfb+phi_s(1,i)+sign(phi_s(1,i))*(charge(1,i,j)/Cmax);
        c(1,i,j) = c_total(phi_s(1,i),tox(j),na(1));
        c_hf(1,i,j) = c_total_h(phi_s(1,i),tox(j),na(1));
    end
    
%     figure(3*j +1)
% semilogy(phi_s,charge(:,:,j))
% title('Q total VS \psi_{s} (without approximation)')
% xlabel(' \psi_{s} (in V)') 
% ylabel('|Q| . (in C / m^2')  
% 
% 
% figure(3*j +2)
% plot(Vg(:,:,j),phi_s)
% title('VG VS \psi_{s}')
% xlabel('Vg (in V)') 
% ylabel('\psi_{s} (in V)') 

 figure(3*j)
plot(Vg(:,:,j),c(:,:,j),Vg(:,:,j),c_hf(:,:,j))
title(['C vs VG(for tox = ',num2str(tox(j)),'m and na',num2str(na(1)),' /m^3)'])
xlabel(' VG(in V)') 
ylabel('C in F/m^2') 
end


figure(99)
plot(Vg(:,:,1),c(:,:,1),Vg(:,:,2),c(:,:,2),Vg(:,:,3),c(:,:,3))
legend(num2str(tox(1)),num2str(tox(2)),num2str(tox(3)))
title(['C vs VG(for variable tox)'])
xlabel(' VG(in V)') 
ylabel('C in F/m^2') 

for j = 4:6
    Cmax = E_sio2/tox(1);
    phi_f =kt_q*log(na(j-2)/ni);
    for i = 1:100
        charge(1,i,j) = total_charge(phi_s(1,i),tox(1),na(j-2));
        Vg(1,i,j) = Vfb+phi_s(1,i)+sign(phi_s(1,i))*(charge(1,i,j)/Cmax);
        c(1,i,j) = c_total(phi_s(1,i),tox(1),na(j-2));
        c_hf(1,i,j) = c_total_h(phi_s(1,i),tox(1),na(j-2));

    end
    
%         figure(3*j +1)
% semilogy(phi_s,charge(:,:,j))
% title('Q total VS \psi_{s} (without approximation)')
% xlabel(' \psi_{s} (in V)') 
% ylabel('|Q| . (in C / m^2')  
% 
% 
% figure(3*j +2)
% plot(Vg(:,:,j),phi_s)
% title('VG VS \psi_{s}')
% xlabel('Vg (in V)') 
% ylabel('\psi_{s} (in V)') 

 figure(3*j)
plot(Vg(:,:,j),c(:,:,j),Vg(:,:,j),c_hf(:,:,j))
title(['C vs VG(for tox = ',num2str(tox(1)),'m and na',num2str(na(j-2)),' /m^3)'])
xlabel(' VG(in V)') 
ylabel('C in F/m^2') 
end
figure(88)
plot(Vg(:,:,4),c(:,:,4),Vg(:,:,5),c(:,:,5),Vg(:,:,6),c(:,:,6))
legend(num2str(na(2)),num2str(na(3)),num2str(na(4)))



title(['C vs VG(for variable na)'])
xlabel(' VG(in V)') 
ylabel('C in F/m^2') 

figure(34)
plot(Vg(:,:,4),c_hf(:,:,4),Vg(:,:,5),c_hf(:,:,5),Vg(:,:,6),c_hf(:,:,6))
legend(num2str(na(2)),num2str(na(3)),num2str(na(4)))
title(['C vs VG(for variable na)'])
xlabel(' VG(in V)') 
ylabel('C in F/m^2')


figure(35)
plot(Vg(:,:,1),c_hf(:,:,1),Vg(:,:,2),c_hf(:,:,2),Vg(:,:,3),c_hf(:,:,3))
legend(num2str(tox(1)),num2str(tox(2)),num2str(tox(3)))
title(['C vs VG(for variable tox)'])
xlabel(' VG(in V)') 
ylabel('C in F/m^2') 

