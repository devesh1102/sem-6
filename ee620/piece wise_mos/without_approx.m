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
Vfb = -0.2;
facter = (ni*ni)/(na*na);
samples=100;
pre2 = 2*sqrt(2*E_si *q*na)/(3*Cmax);
pre1= ueff*Cmax*w/l;



%% FOR Vds VS IDS(without taylor series)
ids_max = 0;
index = 0;
vg1 =   1.0311;%above threshold
vds1 = linspace(0,2.5,samples);
Ids_vd = zeros(1,samples);
for i= 1:samples
  
  first1 = (vg1 - Vfb -2*phi_f - vds1(1,i)/2) * vds1(1,i);
  second1 = (2*phi_f +vds1(1,i))^1.5 - (2*phi_f)^1.5;
  Ids_vd(1,i) = pre1*(first1 - pre2 * second1);
  if(ids_max> Ids_vd(1,i))
    Ids_vd(1,i) = ids_max ;
  else
      ids_max =   Ids_vd(1,i);
  end
end
figure(2)
plot(vds1,Ids_vd)
title('I_{ds} , vs V_{ds}(without taylor series) ')
xlabel(' Vds(in V)') 
ylabel('Id in c/m^2')

%% FOR Vds VS IDS(taylor series one term)
ids_max1 = 0;
index1 = 0;
Ids_vd1 = zeros(1,samples);
for i= 1:samples
  first1 = (vg1 - Vfb -2*phi_f - vds1(1,i)/2) * vds1(1,i);
  second2 = 1.5*(sqrt(2*phi_f)*(vds1(1,i) + 0.25 * (vds1(1,i)*vds1(1,i))/(2*phi_f)));
  Ids_vd1(1,i) = pre1*(first1 - pre2 * second2);
  if(ids_max1> Ids_vd1(1,i))
    Ids_vd1(1,i) = ids_max1 ;
  else
      ids_max1 =   Ids_vd1(1,i);
  end
end
figure(3)
plot(vds1,Ids_vd1)
title('I_{ds} , vs V_{ds}(taylor series one term) ')
xlabel(' Vds(in V)') 
ylabel('Id in c/m^2')

%% FOR Vds VS IDS(taylor series two term)
ids_max2 = 0;
index2 = 0;
Ids_vd2 = zeros(1,samples);
for i= 1:samples
  first = (vg1 - Vfb -2*phi_f - vds1(1,i)/2);
  second = sqrt(2*E_si*q*na*2*phi_f)/Cmax;
  third =  vds1(1,i) *(sqrt(E_si*q*na/(4*phi_f)))/(Cmax*2);
  Ids_vd2(1,i) = pre1*(first - second  - third)*vds1(1,i)
  if(ids_max2> Ids_vd2(1,i) )
     Ids_vd2(1,i) = ids_max2 ;
  else
      ids_max2 =    Ids_vd2(1,i);
  end
end
figure(4)
plot(vds1,Ids_vd2)
title('I_{ds} , vs V_{ds}(taylor series two term) ')
xlabel(' Vds(in V)') 
ylabel('Id in c/m^2')














