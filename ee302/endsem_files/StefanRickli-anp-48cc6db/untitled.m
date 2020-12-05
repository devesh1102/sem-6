g = tf([1],[1 0])
g1 = tf([1],[1 1])
g2 = tf([1],[1 9]);
gg = g*g*g1*50;
nyquistplot(gg)
margin(gg)