clear
R1 = 1200
R =10000
C = 10*10^-9
Vmax = 2.5;
pre_factor = Vmax*R1/R;

Num =  [ C*R*pre_factor pre_factor]
Den=[1]
transferfunction = tf(Num ,Den)
syms f
realPart = pre_factor;
imagPart = pre_factor*2*pi*f*C*R;
lowerlimit= 100
upperlimit= 50000
samples =1000
F   = linspace(lowerlimit,upperlimit,samples);
for i=1:samples
    tff(i) = R1*j*2*pi*C*F(i)/(R*j*2*pi*F(i)*C +1);
    real1(i) =real(tff(i)) ;
    imag1(i) =imag(tff(i)) ;
    mag(i) = sqrt(real1(i) *real1(i)  +  imag1(i)* imag1(i));
    phase(i) =  atan(imag1(i)/real1(i))*180/(pi);
end
figure(1)
plot(F,mag)
xlabel(' F(in Hz)') 
ylabel('V_{out} magnitude') 
title(['mag(for R1 = ',num2str(R1),', R ',num2str(R),', C',num2str(C)])

figure(2)
plot(F,phase)
xlabel(' F(in Hz)') 
ylabel('Phase in degree') 
title(['Phase(for R1 = ',num2str(R1),', R ',num2str(R),', C ',num2str(C)])




