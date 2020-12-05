w = 1e5;
ni=1e16;
vth=2.6e7;
samples =100;
dit_avg = 0;
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
Vfb =-0.95;
nii = 1.5e10;
vth=2.6e7;
sigma=1e-15;
%E = linspace(0.55 + phi_f-0.5*phi_f, 0.55 + phi_f+2.5*phi_f,samples);
E = linspace(0, 1,samples);
phi_s = linspace(-0.5*phi_f,2.5*phi_f,samples); 
tit_avg = 0;
dit_avg = 0;

for i = 1:samples
    
    dit_avg = dit_avg+ dit_cal(E(i));
    
    
end

dit_avg = dit_avg/samples;
y = zeros(1,samples);
Cs = zeros(1,samples);



c_low = zeros(1,samples);
c_high = zeros(1,samples);
Vg = zeros(1,samples);

c_lowOx = zeros(1,samples);
c_highOx = zeros(1,samples);
VgOx = zeros(1,samples);

q_oxide =q*10^24*tox; 

 %c_derivative(1,1) = derivative(phi_s(1,1),tox,na);    
 %Vg(1,1) = Vfb+phi_s(1,1)+sign(phi_s(1,1))*(y(1,1)/Cmax);
  for i = 1:samples
     % y(1,i) = total_charge(phi_s(1,i),tox,na);
%      %Cs(1,i) = (y(1,i) - y(1,i-1))/(phi_s(1,i) - phi_s(1,i - 1)); C(1,i) =(
%      %Cs(1,i) * Cmax)/(Cmax+Cs(1,i));
      c_lowOx(1,i) = c_total_l(phi_s(1,i),tox,na);
      c_low(1,i) = c_total_l(phi_s(1,i),tox,na);
      Vg(1,i) = Vfb+phi_s(1,i)+sign(phi_s(1,i))*(total_charge(phi_s(1,i),tox,na)/Cmax );
      VgOx(1,i) = Vfb+ (-1*(q*dit_avg*(phi_f - phi_s(1,i)))/Cmax) +phi_s(1,i)+sign(phi_s(1,i))*(total_charge(phi_s(1,i),tox,na)/Cmax );
      c_high(1,i) = c_total_h(phi_s(1,i),tox,na);
      c_highOx(1,i) = c_total_h(phi_s(1,i),tox,na);
     end
%t = linspace(-0.5*phi_f,2.5*phi_f,500)%t is the phi_s
%yt = @(t) c_total(t,tox,na) % yt is Total capacitance
%xt = @(t) Vfb+t+sign(t)*(total_charge(t,tox,na)/Cmax);%x is the VG

 figure(1)
% plot(t,total_charge(t,tox,na))
%fplot(xt,yt)
plot(Vg,c_low,VgOx,c_lowOx)
legend({'Without DIT','With Dit'},'Location','southwest')


%plot(Vg,c)
title('C vs VG ( LFCV)')
xlabel(' VG(in V)') 
ylabel('C in F/m^2') 

 figure(2)
plot(Vg,c_high,VgOx,c_highOx)
legend({'Without DIT','With Dit'},'Location','southwest')
title('C vs VG ( HFCV)')
xlabel(' VG(in V)') 
ylabel('C in F/m^2')

 figure(3)
plot(Vg,c_high,Vg,c_low,VgOx,c_highOx,VgOx,c_lowOx)
%legend({'Without oxide charge','With oxide charge'},'Location','southwest')

title('C vs VG ')
xlabel(' VG(in V)') 
ylabel('C in F/m^2') 




    