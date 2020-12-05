 clear
m = 9

[tone_out,ffft] = tone(m);
sound(tone_out, 8000);
figure(10)
plot(tone_out,8000);
dummy = ffft(1:4000);
 B = maxk(dummy,2);
 f1 = find(dummy == B(1))
 f2 = find(dummy == B(2))