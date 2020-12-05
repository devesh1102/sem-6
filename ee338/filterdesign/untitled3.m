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

 Gp = 0.87; Gs = 0.13; % filter specifications
Wp =  1.0000; Ws = 1.6146;
fp = Wp/(2*pi); fs = Ws/(2*pi);
ep = sqrt(1/Gp^2 - 1); es = sqrt(1/Gs^2 - 1); % ripples εp = 0.3287, εs = 19.9750
k = Wp/Ws; % k = 0.8889
k1 = ep/es; % k1 = 0.0165
[K,Kp] = ellipk(k); % elliptic integrals K = 2.2353, K = 1.6646
[K1,K1p] = ellipk(k1); % elliptic integrals K1 = 1.5709, K
Nexact = (K1p/K1)/(Kp/K); N = ceil(Nexact); % Nexact = 4.6961, N = 5
k = ellipdeg(N,k1); % recalculated k = 0.9143
fs_new = fp/k; % new stopband fs = 4.3751
L = floor(N/2); r = mod(N,2); i = transpose(1:L); % L = 2, r = 1, i = [1; 2]
u = (2*i-1)/N; zeta_i = cde(u,k); % ui = [0.2; 0.6], ζi = [0.9808; 0.7471]
za = Wp * j./(k*zeta_i); % filter zeros
v0 = -j*asne(j/ep, k1)/N; % v0 = 0.2331
pa = Wp * j*cde(u-j*v0, k); % filter poles
pa0 = Wp * j*sne(j*v0, k);
B = [ones(L,1), -2*real(1./za), abs(1./za).^2]; % numerator second-order sections
A = [ones(L,1), -2*real(1./pa), abs(1./pa).^2]; % denominator second-order sections
if r==0, % prepend first-order sections
B = [Gp, 0, 0; B]; % DC gain is H0 = Gp, if N is even
A = [1, 0, 0; A];
else
B = [1, 0, 0; B];
A = [1, -real(1/pa0), 0; A];
end
%f = linspace(0,10,2001);
%for n=1:length(f), % calculate frequency response
%s = j*2*pi*f(n); % s = jΩ = 2πjf
syms s
H = prod((B(:,1) + B(:,2)*s + B(:,3)*s^2)./... % cascade filter sections
(A(:,1) + A(:,2)*s + A(:,3)*s^2));


W0 = sqrt(Awp1*Awp2);%lies between Aws1 and Aws2
B = Awp2 - Awp1;
syms sb
%%%%%%%%%Analog Bandpass Transfer Function
analog_bpf =simplify (subs(H, ((B*sb)/((sb*sb) +(W0*W0)))));
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

fvtool(discrete_N1,discrete_D1)
figure(12)
[H,f] = freqz(discrete_N1,discrete_D1,1024*1024,samp_rate );
 plot(f,abs(H))
 grid