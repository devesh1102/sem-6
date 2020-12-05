a=[0 1 0; 0 0 1;-24 -26 -9];
b = [0;0;1];
c = [1 1 0];
d = [0];
[num,den] = ss2tf(a,b,c,d);% making transfer function of l
l = tf(num,den );
sensi = 1/(1+l);% with transfer function of l finding sensitivity
num = [1 9 26 24];%transfer function sensitivity
dum = [1 9 27 25];
display(' sensitivity ')
[A B C D] = tf2ss(num,dum)%using transfer function of sensitivity to find statespace of sensitivity
comp_sensi = 1- sensi;
numC = [ 1 1];%transfer function of complement sensitivity
dumC = [1 9 27 25];
display('complement sensitivity ')
[A_C B_C C_C D_C] = tf2ss(numC,dumC)%state space of complement sensitivity