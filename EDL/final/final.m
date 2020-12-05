clear
close all
F= [100 200 300 400 500 600 700 800 900 1000 2000 3000 4000 5000 6000 7000 8000 9000 10000 15000 20000 25000 30000 35000 40000 45000 ];
[a b]= size(F)
R1 =1200
R= 3900
C = 4.7*10^-9
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
figure(1)
plot(F,aver(:,2))
xlabel(' F(in Hz)') 
ylabel('1st reading') 
title(['Vin mag(for R1 = ',num2str(R1),', R ',num2str(R),', C',num2str(C)])

figure(2)
plot(F,aver(:,3))
xlabel(' F(in Hz)') 
ylabel('2nd reading') 
title(['Vout(for R1 = ',num2str(R1),', R ',num2str(R),', C',num2str(C)])

figure(3)
plot(F,-aver(:,4))
xlabel(' F(in Hz)') 
ylabel('Vphase') 
title(['phase1(for R1 = ',num2str(R1),', R ',num2str(R),', C',num2str(C)])

figure(4)
plot(F,aver(:,5))
xlabel(' F(in Hz)') 
ylabel('4th reading') 
title(['phase2(for R1 = ',num2str(R1),', R ',num2str(R),', C',num2str(C)])


mag = R1*aver(:,2)./aver(:,3);
figure(5)
plot(F,mag)
xlabel(' F(in Hz)') 
ylabel('Magnitude') 
title(['MAGNITUDE(ohm)for R1 = ',num2str(R1),', R ',num2str(R),', C',num2str(C)])

phase = abs ( aver(:,4) -  aver(:,5))

figure(6)
plot(F,phase)
xlabel(' F(in Hz)') 
ylabel('phase(Voltage)') 
title(['phase(for R1 = ',num2str(R1),', R ',num2str(R),', C',num2str(C)])












