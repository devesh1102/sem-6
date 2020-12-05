close all
clear
R= 3900;
C = 4.7*10^-9;
R1 =1200;

F= [100 200 300 400 500 600 700 800 900 1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 15000 20000 25000 30000 35000 40000 45000 ];
[a b]= size(F)
samples = b;
for j = 1: samples
    eqn = R/(R*i*2*pi*F(1,j)*C +1);
    real11 = real (eqn)  ;
    imag11 = imag(eqn)
    mag_ex(j) = sqrt(real11*real11 + imag11*imag11);
    phase_ex(j) = atan(imag11/real11)*180/pi;
end
[read] = data();
read(:,1) = (read(:,1)>100)
toggle = read(1,1); 
toggle_new = read(2,1);
[data_pt col] = size(read);
frequency_seen = b;
aver = zeros(b,col)
i= 1;
for j = 1:frequency_seen
    k = 1;
    while toggle_new == toggle
        aver(j,:) = aver(j,:) +  read(i,:)
        i = i+1;
        k = k+1;
        if (i == data_pt +1)
            break;
        end
        toggle_new = read(i,1);
    end
    toggle = toggle_new;
end
aver = aver/k;
mag = R1*aver(:,2)./aver(:,3);
subplot(221)
plot(F,mag)
xlabel(' F(in Hz)') 
ylabel('Magnitude') 
title(['MAGNITUDE(ohm)for R1 = ',num2str(R1),', R ',num2str(R),', C',num2str(C)])
subplot(222)
plot(F,-aver(:,4))
xlabel(' F(in Hz)') 
ylabel('Vphase') 
title(['phase1(for R1 = ',num2str(R1),', R ',num2str(R),', C',num2str(C)])

subplot(223)
plot(F,mag_ex)
xlabel(' F(in Hz)') 
ylabel('Magnitude(ohm)') 
title(['MAGNITUDE expected R ',num2str(R),', C',num2str(C)])

subplot(224)
plot(F,phase_ex)
xlabel(' F(in Hz)') 
ylabel('phase') 
title(['Phase expected R ',num2str(R),', C',num2str(C)])


% figure(1)
% plot(F,phase_ex/max(abs(phase_ex(1,:))),F,(-aver(:,4)/max(aver(:,4))));
% xlabel('phase') 
% legend('phase_ex', 'Voltage' )
% ylabel('voltage') 
% title(['phase char(for R1 = ',num2str(R1),', R ',num2str(R),', C',num2str(C)])
% % 
% figure(2)
% plot(phase_ex,aver(:,5))
% xlabel(' phase') 
% ylabel('voltage') 
% title(['phase char(for R1 = ',num2str(R1),', R ',num2str(R),', C',num2str(C)])

