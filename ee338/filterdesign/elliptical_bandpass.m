clear%s[pecs 
% the passband is from BL(m) kHz to BH(m) kHz, 
%For bandpass filters, the transition band is 2 kHz on either side of the passband.
%For bandstop filters, the transition band is 2 kHz on either side of the stopband.
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
Aws1_lp = (Aws1*Aws1 - W0*W0)/(B*Aws1);
Aws2_lp = (Aws2*Aws2 - W0*W0)/(B*Aws2);
Awp1_lp = (Awp1*Awp1 - W0*W0)/(B*Awp1);
Awp2_lp = (Awp2*Awp2 - W0*W0)/(B*Awp2);
stop_lp = min(abs(Aws2_lp),abs(Aws1_lp));
pass_lp = min(abs(Awp2_lp),abs(Awp1_lp));
d1 = 1/((1-delta)*(1-delta)) -1;
d2 = 1/(delta*delta)-1;
