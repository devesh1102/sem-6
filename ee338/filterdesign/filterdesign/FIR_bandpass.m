 clear%matched
m=109;
samp_rate =320000;
delta = 0.15;
q = floor(0.1*m);
r = m- 10*q;
bl = 5+ 1.4*q+ 4*r;;
bh = bl+10;
bl = bl*1000;
bh = bh *1000;
% bl=55000;
% bh =65000;
%wl = 2*pi*bl/samp_rate;
%wh = 2*pi*bh/samp_rate;
wl = bl;
wh = bh;
transition =2000;
tt = 2000;
%tt = 2*pi*transition/samp_rate;

ws1 =wl -tt;
ws2 = wh +tt;
wp1 = wl;
wp2 = wh;
wp1_N = 2*pi*wp1/samp_rate;%normalized pass band
wp2_N = 2*pi*wp2/samp_rate;
Wc1 = wp1*2*pi/samp_rate;
Wc2  = wp2*2*pi/samp_rate;
%kaiser window parameter

A = -20*log10(delta);%log based 10
if(A < 21)
    alpha = 0;
elseif(A <51)
    alpha = 0.5842*(A-21)^0.4 + 0.07886*(A-21);
else
    alpha = 0.1102*(A-8.7);
end
N_min = ceil((A-8) / (2.285*2*(2*transition*pi)/(samp_rate)));   

%Window length for Kaiser Window
n=N_min+5;
%end
cutoff_1 = 2*pi*( wp2 + 0)/samp_rate;
cutoff_2 =2*pi*( wp1 - 0)/samp_rate;
 bp_ideal = ideal_lp(cutoff_1,n) - ideal_lp(cutoff_2,n)
 
 kaiser_win = transpose((kaiser(n,alpha/n)));%why was alpha given
 FIR_BandPass = bp_ideal .* kaiser_win;
 fvtool(FIR_BandPass);         %frequency response

%magnitude response
[H,f] = freqz(FIR_BandPass,1,1024, samp_rate);
figure(6)
plot(f,abs(H))
grid
 












