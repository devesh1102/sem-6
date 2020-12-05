clear%s[pecs 
% the passband is from BL(m) kHz to BH(m) kHz, 
%For bandpass filters, the transition band is 2 kHz on either side of the passband.
%For bandstop filters, the transition band is 2 kHz on either side of the stopband.
m=109;
samp_rate =320000;
delta = 0.15;
q = floor(0.1*m);
r = m- 10*q;
bl = 5+ 1.4*q+ 4*r;
bh = bl+10;
bl = bl*1000;
bh = bh *1000;
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
Aws1_lp = (Aws1*Aws1 - W0*W0)/(B*Aws1);
Aws2_lp = (Aws2*Aws2 - W0*W0)/(B*Aws2);
Awp1_lp = (Awp1*Awp1 - W0*W0)/(B*Awp1);
Awp2_lp = (Awp2*Awp2 - W0*W0)/(B*Awp2);
stop_lp = min(abs(Aws2_lp),abs(Aws1_lp));
pass_lp = min(abs(Awp2_lp),abs(Awp1_lp));
d1 = 1/((1-delta)*(1-delta)) -1;
d2 = 1/(delta*delta)-1;
ns = acosh(sqrt(d2/d1))/acosh((stop_lp/pass_lp));
Eq = sqrt(d1);
ns = ceil(ns);
syms s

%poly =zeros(1,ns+1); %ci polynomial is present in poly(i+1)
poly =repmat(s,1,ns+1);% creates array of struct
poly(1) = 1;
poly(2) = s;
for i =3:ns+1
    poly(i) =simplify( 2*s*poly(i-1) - poly(i-2));
end
analog_2 = simplify(1/(1+Eq*Eq*poly(ns+1)*poly(ns+1)));
dum = sym2poly(1/analog_2);
 
pole_present = pole(tf([1],dum));
pole_present = j*(pole_present);
lhp = pole_present(real(pole_present) < 0);%lhp-> poles in left hand plane
den = sym2poly(expand(prod((s-lhp))));%-> constructing  eqn by taking poles  in lhp 
den_poly = (expand(prod((s-lhp))));
num = [prod(-1*lhp )/(sqrt(1+d1))];
analog_lpf =(tf(num,den)) ;


%den = (expand(prod((s-lhp))))
syms sb
%%%%%%%%%Analog Bandpass Transfer Function
den_poly_bpf =simplify (subs(den_poly, (((sb*sb) +(W0*W0))/(B*sb))));
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
%%analog_bpf =(subs(analog_lpf2, s, (s*s -W0*W0)/ (B*s) ))
%%[symNum,symDen] = numden(analog_bpf)
%%%TFnum = sym2poly(symNum);    %Convert Symbolic num to polynomial
%%TFden = sym2poly(symDen);    %Convert Symbolic den to polynomial
%%ans1 =(tf(TFnum,TFden));

%%num = prod(lhp);



