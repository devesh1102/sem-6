E_sio2 = 3.9*8.85 * 10^-12;
E_si = 11.9*8.85 * 10^-12;
ni = 10^16;
na = 10^23;
tox = 5*10^-9;
k = 1.380*10^-23;
q = 1.6*10^-19;
t = 300;
eg = 1.1;
kt_q = 0.025;
Cmax = E_sio2/tox;
phi_f =kt_q*log(na/ni);
w = 10 *10^-3
ueff = 300 * 10^-4
l = 1* 10^-3;
x = linspace(-1*phi_f,3*phi_f);
y = zeros(1,100);
Vfb = -0.95;
samples = 45;
%%%%%vds vs Ids%%%%%%%%%%%%%5
vg =1.5;
vds = linspace(0,2.5,samples);
pre_fac = sqrt(2*E_si*k*t*na)/Cmax;
psi_s = zeros(1,samples);
% for i = 1:samples
%     syms psi_s1
%     vg_eqn1 = Vfb +psi_s1 +pre_fac*sqrt((psi_s1/kt_q + sign(psi_s1)*(ni/na)*(ni/na)*exp((psi_s1 - vds(1,i))/kt_q)));
%     psi_s(1,i)= solve([vg_eqn1 == vg], psi_s1);
% end
pre_fac2 = sqrt(2*k*t*na/E_si);
pre_int=(q*ueff*w*ni*ni/(na*l))
ratio = ni*ni/(na*na);
Ids = zeros(1,samples);
prefac_1 = ni*ni*q*ueff*w/(l*na*sqrt(2*k*t*na/E_si));
 %%for i = 1:samples 
   %%     syms S V
     %%    den = sqrt ((S /kt_q) + (ratio*exp((S - V)/kt_q));
    %%     num = exp((S - V)/kt_q);
     %%    fun = num/den;
        %fun = @(S,V) exp((S - V)/kt_q)/( sqrt ((S /kt_q) + (ni*ni/(na*na))*exp((S - V)/kt_q)) )
     %%    fun2 = matlabFunction(fun);
      %%  Ids(1,i) = prefac_1* integral2(fun2,0.001,psi_s(1,i),0,vds(1,i));
%         diff=(psi_s(1,j) - vds(1,i))
%         derivative = pre_fac2*sqrt((psi_s(1,j)/kt_q)+ ratio*exp(diff/kt_q));
%         increment = exp((diff)/kt_q)/derivative;
%         dummy= dummy + increment* abs((psi_s(1,j) - psi_s(1,j+1))*(vds(1,i) - vds(1,i+1)));
  %%  end
%     Id(1,i) = dummy*pre_int;
% end
%Id(1,samples) =  Id(1,samples -1);
% % figure(1)
% % plot(vds,Ids)
% % title('I_{ds} . vs V_{ds} ')
% % xlabel(' Vd(in V)') 
% % ylabel('Id in c/m^2')
 syms S V
  
 prefac_1 = ni*ni*q*ueff*w/(l*na*sqrt(2*k*t*na/E_si));
 den = sqrt ((S /kt_q) + (ni*ni/(na*na))*exp((S - V)/kt_q));
 num = exp((S - V)/kt_q);
 expression= num/den;
 int(expression ,S)