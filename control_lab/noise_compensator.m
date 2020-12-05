clear
close all
%num = [700]
%dum = [1 -700]
pole_1= 450
pole_2= 450
zero_1= 1900
zero_2= 1900
num1 = [1/zero_1 1]
dum1 = [1/pole_1 1]
num2 = [1/zero_2 1]
dum2 = [1/pole_2 1]
tfff1 = tf( num1 , dum1)
tfff2 = tf( num2 , dum2)
tfff =tfff1*tfff2;
[f,m,ph] = data()
figure(7)
bode(tfff,f)
 [MAG,PHASE] =bode(tfff,f)

 %MAG = MAG(1,1,:)
 for i= 1:1:size(m)
      MAG(1,1,i) = 20*log( MAG(1,1,i));
     mag_new(i,1) = MAG(1,1,i)+m(i,1);
     phase_new(i,1)= PHASE(1,1,i) + ph(i,1);
 end
 %mag_new = (com_mag)'.*(m)'
 %phase_new = PHASE.*
  figure(8)
semilogx(f,mag_new,f,m)
legend('With Compensator','Without Compensator')
title('magnitude')
xlabel('Frequency(in hz)');
ylabel('magnitude(Db)')
figure(10)
semilogx(f,phase_new,f,ph)
legend('With Compensator','Without Compensator')
title('phase')
xlabel('Frequency(in hz)');
ylabel('phase in degree')