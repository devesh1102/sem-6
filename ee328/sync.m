samples =1000
noise_var = 0.1;
 r1 =  randi( [0,1],samples,1);
 r2 = randi( [0,1],samples,1);
 r1(r1==0)=-1;
 r2(r2==0)=-1;
 b2 = (r1 + r2*i)/sqrt(2)
 G1 =random('norm', 0, noise_var, samples,1);
 
 G2 =random('norm', 0, noise_var, samples,1);
 A=1;
 y = A*b2
  y = y+ (G1+i*G2)/sqrt(2)
% y = awgn(y,1)
 %if bi is known
 theta = pi/2
 y_phase = y .* exp(i*theta)
 
 scatterplot(y_phase)
  scatterplot(y)
 
 
 
 A_ess = mean(abs(y./b2))
 ain =100;
 % for blind
 A_ess_blind= mean(abs(y.* tanh(ain*y/noise_var)))
 %a = mean(abs(b2))
scatterplot(y)