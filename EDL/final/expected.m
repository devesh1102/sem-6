clear
close all
R= 3900
C = 4.7*10^-9

F= [100 200 300 400 500 600 700 800 900 1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 15000 20000 25000 30000 35000 40000 45000 ];
[a b] = size(F)
samples = b

for j = 1: samples
    eqn = R/(R*i*2*pi*F(1,j)*C +1);
    real11 = real (eqn)  ;
    imag11 = imag(eqn)
    mag(j) = sqrt(real11*real11 + imag11*imag11);
    phase(j) = atan(imag11/real11)*180/pi;
end
figure(55)
plot(F,mag)
xlabel(' F(in Hz)') 
ylabel('Magnitude(ohm)') 
title(['MAGNITUDE expected R ',num2str(R),', C',num2str(C)])

figure(66)
plot(F,phase)
xlabel(' F(in Hz)') 
ylabel('phase') 
title(['Phase expected R ',num2str(R),', C',num2str(C)])