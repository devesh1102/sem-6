%syms z

%eqn =  (49 +79*(1/z) +49* (z^-2))/(100+ 50*(z^-1)+ 40*(z^-2));
H = tf([49 79 49],[100 50 40]);
pzmap(H)
grid on
num =[49 79 49];
den = [100 50 40]
[h,w] = freqz(num,den,'whole',2001);
plot(w/pi,20*log10(abs(h)))
ax = gca;
ax.YLim = [-100 20];
ax.XTick = 0:.5:2;
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')
