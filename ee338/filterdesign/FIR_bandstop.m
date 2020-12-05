clear
%matched
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
wl = bl;
wh = bh;
tt =transition;

ws1 = wl ;
ws2 = wh ;
wp1 = wl- tt;
wp2 = wh+tt;
%kaiser window parameter

A = -20*log10(delta);%log based 10
if(A < 21)
    alpha = 0;
elseif(A <51)
    alpha = 0.5842*(A-21)^0.4 + 0.07886*(A-21);
else
    alpha = 0.1102*(A-8.7);
end
%not sure what is being done
N_min = ceil((A-7.95) / (2.285*2*(2*transition*pi)/(samp_rate)));   %why delta w =0.04        %empirical formula for N_min

%Window length for Kaiser Window
n=N_min+11;%why +12%tuneble parameter
%end
%cutoff_1 = 2*pi*( wp2-(transition/1.11) )/samp_rate%tuneble parameter
%cutoff_2 =2*pi*( wp1 + (transition/1.11) )/samp_rate%tuneble parameter
cutoff_1 = 2*pi*( wp2-(transition) )/samp_rate%tuneble parameter
cutoff_2 =2*pi*( wp1 + (transition) )/samp_rate%tuneble parameter
 bp_ideal =ideal_lp(pi,n)- ideal_lp(cutoff_1,n) + ideal_lp(cutoff_2,n);
 
 kaiser_win = transpose((kaiser(n,alpha/n)));%why was alpha given
 FIR_BandPass = bp_ideal .* kaiser_win;
 fvtool(FIR_BandPass);         %frequency response

%magnitude response
[H,f] = freqz(FIR_BandPass,1,1024, samp_rate);
figure(6)
plot(f,abs(H))
grid






