m=109
samp_rate =320000;
delta = 0.15
q = floor(0.1*m)
r = m- 10*q
bl = 5+ 1.4*q+ 4*r
bh = bl+10
bl = bl*1000
bh = bh *1000
% bl=55000;
% bh =65000;
wl = 2*pi*bl/samp_rate;
wh = 2*pi*bh/samp_rate;
transition =2000;
tt = 2*pi*transition/samp_rate;

%normalized bandpass
ws1 = wl -(tt);
ws2 = wh +(tt);
wp1 = wl;
wp2 = wh;
%analog filter specs
Aws1 = tan(ws1/2);
Aws2 = tan(ws2/2);
Awp1 =tan(wp1/2);
Awp2 = tan(wp2/2);
%corresponding lpf specs
W0 = sqrt(Awp1*Awp2);%lies between Aws1 and Aws2
B = Awp2 - Awp1;



 pass_toller = 0.85; 
 stop_toller = 0.15; % filter specifications
Wpass =  1.0000; 
Wstop =1.3856;
pass_ripple = sqrt(1/pass_toller^2 - 1); 
stop_ripple = sqrt(1/stop_toller^2 - 1);
k = Wpass/Wstop; 
k1 = pass_ripple/stop_ripple; 
[K,Kp] = ellipk(k); % elliptic integrals
[K1,K1p] = ellipk(k1); % elliptic integrals
N = (K1p/K1)/(Kp/K);
N = ceil(N);
u = (2*1-1)/N; 
zeta = cde(u,k);
zero = Wpass * j./(k*zeta); % filter zeros
v0 = -j*asne(j/pass_ripple, k1)/N; 
pole = Wpass * j*cde(u-j*v0, k); 
pao = Wpass * j*sne(j*v0, k);
syms s
H =( 1-s/(zero))*(1-s/conj(zero))/(( 1-s/(pole))*(1-s/conj(pole)));
H = H/(1-s/pao);

[Num_lpf,dum_lpf] = numden(H);
Num_lpf = sym2poly(Num_lpf);
dum_lpf = sym2poly(dum_lpf);
k = dum_lpf(1);                                          %normalisation factor
Num_lpf = Num_lpf/k
dum_lpf = dum_lpf/k
analog_lpf =(tf(Num_lpf,dum_lpf)) 
W0 = sqrt(Awp1*Awp2);%lies between Aws1 and Aws2
B = Awp2 - Awp1;
syms sb
%%%%%%%%%Analog Bandpass Transfer Function
analog_bpf =simplify (subs(H, (((sb*sb) +(W0*W0))/(B*sb))));
%analog_bpf =simplify( num(1)/den_poly_bpf);
[bpf_N1,bpf_D1] = numden(analog_bpf);
bpf_N1 = sym2poly(bpf_N1);
bpf_D1 = sym2poly(bpf_D1);
k = bpf_D1(1);                                          %normalisation factor
bpf_N1 = bpf_N1/k;
bpf_D1 = bpf_D1/k;
%%[Num1,Den1] = tfdata(analog_lpf);
%analog_lpf2 = (poly2sym(cell2mat(Num1),s)/poly2sym(cell2mat(Den1),s))

%%%%%Discrete Time Realization

syms z %%%
discrete = simplify(subs(analog_bpf, sb, ((z-1)/(z+1)) ));
[discrete_N1,discrete_D1] = numden(discrete);

discrete_N1 = sym2poly(discrete_N1);
discrete_D1 = sym2poly(discrete_D1);
k = discrete_D1(1);                                          %normalisation factor
discrete_N1 = discrete_N1/k
discrete_D1 = discrete_D1/k

figure(1)
[h,f,w] = freqz(discrete_N1,discrete_D1);
freqzplot(h,f,w);
title('Discrete bandpass filter');


figure(2)
% [h,f,w] = freqz(bpf_N1,bpf_D1,'whole',2001);
% freqzplot(h,f,w);

discrete_N1 =discrete_N1
fvtool(discrete_N1,discrete_D1)
figure(12)
[H,f] = freqz(discrete_N1,discrete_D1,1024*1024,samp_rate );
 plot(f,abs(H))
 grid
 
 
 %latex_table = latex(vpa(sym(discrete_D1),4))%%