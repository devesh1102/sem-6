w = 1e3;
ni=1.5e16;
vth=2.6e7;
samples =40;
E = linspace(0,1.2,samples);
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
for i = 1:samples
   dit(i)  = dit_cal(E(i));
   dit_avg = dit_avg +dit_cal(E(i));
end
dit_avg = dit_avg/samples;
cit = dit_avg*q;
phi_s = linspace(-0.5*phi_f,2.5*phi_f,samples); 
tit = exp(-1*abs( phi_f)/kt_q)/(nii*vth*sigma);%%%%%
rit = tit /cit;
gp_n = w*w*(q*(dit_avg*tit));
gp_d = 1 + ((w*tit).*(w*tit));
gp = gp_n./gp_d


cs_low = zeros(1,samples);
cs_high = zeros(1,samples);
Vg = zeros(1,samples);

  for i = 1:samples
      cs_low(1,i) = c_total_l(phi_s(1,i),tox,na);
      Vg(1,i) = Vfb+phi_s(1,i)+sign(phi_s(1,i))*(total_charge(phi_s(1,i),tox,na)/Cmax );
      cs_high(1,i) = c_total_h(phi_s(1,i),tox,na);
  end
     
  
  %%%%%%%%%%now for lfcv%%%%%%%%%%%%%%%%%%%%%%%%%%

cs_low2 =(cs_low*Cmax)./(cs_low +Cmax);
cs_low = (cs_low + cit)./gp_d;
cs_low =cs_low*w;
z = complex(gp, cs_low);
zin = 1./z;
zin_real = real (zin);
zin_img = imag (zin);
cons = 1/(w*Cmax);

gm_f_lfcv = zeros(1,samples);
cm_f_lfcv= zeros(1,samples);
  for i = 1:samples
    syms gm y
    eqn = [gm/(gm*gm  + (y*y)) == zin_real(i), cons  - (y/(gm*gm+y*y)) ==zin_img(i) ] ;
    A = solve(eqn, [gm y]);
    cm_f_lfcv(i) = vpa(A.y)/w;
    gm_f_lfcv(i) = vpa(A.gm);
     end

figure(30)
plot(Vg,cm_f_lfcv)
figure(31)
plot(Vg,cs_low2)
figure(33)
plot(Vg,cm_f_lfcv,Vg,cs_low2)


% figure(76)
% plot(E,dit)
  
  
cs_high2 =(cs_high*Cmax)./(cs_high +Cmax);
%%%%%%now for HFCV
cp_high = cs_high + cit./gp_d;
cp_high =cp_high*w;
z = complex(gp, cp_high);
zin = 1./z;
zin_real = real (zin);
zin_img = imag (zin);
cons = 1/(w*Cmax);

syms gm y
eqn = [gm/(gm*gm  + (y*y)) == zin_real(1), cons  - (y/(gm*gm+y*y)) ==zin_img(1) ] ;
A = solve(eqn, [gm y]);

gm_f = zeros(1,samples);
cm_f= zeros(1,samples);
  for i = 1:samples
    syms gm y
    eqn = [gm/(gm*gm  + (y*y)) == zin_real(i), cons  - (y/(gm*gm+y*y)) ==zin_img(i) ] ;
    A = solve(eqn, [gm y]);
    cm_f(i) = vpa(A.y)/w;
    gm_f(i) = vpa(A.gm);
     end

figure(23)
plot(Vg,cm_f,Vg,cs_high2)

