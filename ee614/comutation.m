s11=0.954*(cos(-51.934*0.0175) +i*sin(-51.934*0.0175))
s22=0.734*(cos(-135*0.0175) +i*sin(-135*0.0175))
s21=10.175*(cos(-175*0.0175) +i*sin(-175*0.0175))
s12 =1.788*10^(-4)*(cos(12*0.0175) +i*sin(12*0.0175))
delta = s11*s22 - s21*s12
K =( 1- abs(s11)*abs(s11)-abs(s22)*abs(s22)+ abs((delta*delta)))/(2*abs(s21*s12))
OstabilityR = abs(21*s12)/(abs(s22)*abs(s22)-abs((delta*delta)))
OstabilityC = (s22 - delta*(s11)')'/(abs(s22)*abs(s22)-abs((delta*delta)))
IstabilityR = abs(21*s12)/(abs(s11)*abs(s11)-abs((delta*delta)))
IstabilityC = (s11 - delta*(s22)')'/(abs(s11)*abs(s11)-abs((delta*delta)))
gp_max = (K- sqrt(K*K -1))/abs(s21*s12)
Gp_max = gp_max*abs(s21*s21)
%  20*log(Gp_max)/  2.3026 db
Gp =8.0690;
gp = Gp/abs(s21*s21)
