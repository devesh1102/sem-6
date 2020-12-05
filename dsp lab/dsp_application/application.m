clear
symbol = {'1','2','3','4','5','6','7','8','9','*','0','#'};
low_f = [697 770 852 941]; % Low frequency group
high_f = [1209 1336 1477];  % High frequency group
f  = [];
for i=1:4,
    for j=1:3,
        f = [ f [low_f(i);high_f(j)] ];
    end
end
Fs  = 8000;      
N = 16000;          
t   = (0:N-1)/Fs;
tones = zeros(N,size(f,2));
for k=1:12
   
    tones(:,k) = 512*sum(sin(f(:,k)*2*pi*t))';
    
    figure(1)
    subplot(4,3,k),plot(t*1e3,tones(:,k));
    title(['input symbol=  ', symbol{k},])
      set(gca, 'Xlim', [0 10]);
     set(gca, 'Ylim', [-1024 1024]);
 
    if k>9, xlabel('Time (ms)'); end
end
 
%  for k=1:10
    sound(tones(:,5), 8000);
%         play(p);
%         pause(0.5);
       
%  end   
% %   for k=1:12
%   figure(2);
%  [H,fkk] = freqz(tones(:,k),1000,8000);
%  subplot(4,3,k),plot(fkk,abs(H));
%  grid
%  end 

for k=1:12
%   a=abs(fft(tones(:,k),8000));
  
  subplot(4,3,k),plot(abs(fft(tones(:,k),8000)));
end


%%

fftq = (abs(fft(tones(:,k),8000)));



%%

