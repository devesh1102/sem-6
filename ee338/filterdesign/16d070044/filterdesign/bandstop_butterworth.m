clear%meets the specification checked
%For bandpass filters, the transition band is 2 kHz on either side of the passband.
%For bandstop filters, the transition band is 2 kHz on either side of the stopband
m=109;
q = floor(0.1*m)
r = m- 10*q
bl = 5+ 1.2*q+ 2.5*r
bh = bl+6
bl = bl*1000;
bh = bh *1000;
samp_rate = 250000;
delta = 0.15;
transition = 2000;
wl = 2*pi*bl/samp_rate;
wh = 2*pi*bh/samp_rate;
tt = 2*pi*transition/samp_rate;
%normalized bandstop
ws1 = wl ;
ws2 = wh ;
wp1 = wl- tt;
wp2 = wh+tt;
%analog filter specs
Aws1 = tan(ws1/2);
Aws2 = tan(ws2/2);
Awp1 =tan(wp1/2);
Awp2 = tan(wp2/2);
W0 = sqrt(Awp1*Awp2);%lies between Aws1 and Aws2
B = Awp2 - Awp1;
Aws1_lp = -(B*Aws1)/(Aws1*Aws1 - W0*W0);
Aws2_lp = -(B*Aws2)/(Aws2*Aws2 - W0*W0);
Awp1_lp = -(B*Awp1)/(Awp1*Awp1 - W0*W0);
Awp2_lp = -(B*Awp2)/(Awp2*Awp2 - W0*W0);
stop_lp = min(abs(Aws2_lp),abs(Aws1_lp));
pass_lp = min(abs(Awp2_lp),abs(Awp1_lp));
d1 = 1/((1-delta)*(1-delta)) -1;
d2 = 1/(delta*delta)-1;
ns = log(sqrt(d2/d1))/log((stop_lp/pass_lp))

ns =ceil (ns);
limitL = pass_lp/ d1^(1/(2*ns));
limitH = stop_lp/ d2^(1/(2*ns));
cutoff = (limitL+ limitH)/2 ;%%%my parameter between limitL - limitH
syms s

%poly =zeros(1,ns+1); %ci polynomial is present in poly(i+1)
%pole =repmat(s,1,ns);% creates array of struct
for j= 1:2*ns
   pole(j) = i*cutoff*exp(i*pi*(2*j +1)/(2*ns));
end
hs_hs =(expand(prod((s-pole))));
dum = sym2poly(hs_hs)
lhp = pole(real(pole) < 0);%lhp-> poles in left hand plane
den = sym2poly(expand(prod((s-lhp))));%-> constructing  eqn by taking poles  in lhp 
den_poly = (expand(prod((s-lhp))));
num = cutoff^ns;
analog_lpf =(tf(num,den)) 

figure(4)
pzmap(tf([1],dum),'r',tf(den,[1]),'g')
legend('poles for H(s)*H(-s)','poles for H(s) ')

syms sb
%%%%%%%%%Analog Bandpass Transfer Function
den_poly_bpf =simplify (subs(den_poly, ((B*sb)/((sb*sb) +(W0*W0)))));
analog_bpf =simplify( num(1)/den_poly_bpf);
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
fvtool(discrete_N1,discrete_D1)
figure(11)
[H,f] = freqz(discrete_N1,discrete_D1,1024*1024,samp_rate );
 plot(f,abs(H))
 grid
 
% figure(1)
% [h,f,w] = freqz(discrete_N1,discrete_D1,'whole',2001);
% freqzplot(h,f,w);
% title('Discrete bandstop filter');


















