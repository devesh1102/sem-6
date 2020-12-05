% every unit is in SI units

[vg,c_pre,c_post] = data();
c_pre = c_pre*10^4%converting in F/m^2
c_post = c_post*10^4%converting in F/m^2
k = 1.380*10^-23;
q = 1.6*10^-19;
t = 300;
kt_q = 0.025;
ni = 10^16;
E_sio2 = 3.9*8.85 * 10^-12;
E_si = 11.9*8.85 * 10^-12;
Cox = max(c_pre(:));
Cmin = min(c_pre(:));
Wmax = E_si * (Cox-Cmin)/(Cmin*Cox)


syms Na
    eqn = [sqrt(2* E_si*2* kt_q*(log(Na/ni))/(q*Na) )==  Wmax];
     A  = solve(eqn, [Na]);
na = vpa(A(1));%doping;
na =double(na);
na = round(na,-15)
phif = kt_q*log (na/ni);
%cfb
ld = sqrt(E_si*kt_q/(q*na));
cfb = Cox*(E_si/ld)/(Cox + (E_si/ld) );
%c mg
w_mg = sqrt (2*E_si*phif/(q*na));
cmg = Cox*(E_si/ w_mg)/(Cox + (E_si/w_mg) );
%for midgap
[cfound1 index1] = min(abs(c_pre - cmg));
vmg_pre = vg(index1);
[cfound2 index2] = min(abs(c_post - cmg));
vmg_post = vg(index2);
%for flatband
[cfound3 index3] = min(abs(c_pre - cfb));
vfb_pre = vg(index3);
[cfound4 index4] = min(abs(c_post - cfb));
vfb_post = vg(index4);
%for ideal device
vfb_ideal  = -1*phif;
vmg_ideal = vfb_ideal + phif+ (total_charge(phif,Cox,na)/Cox);
%fixed charge
%forpost
qoxide_post = Cox*(vmg_ideal - vmg_post);
qoxide_pre = -1*Cox*(vmg_pre - vmg_ideal);
figure(1)
plot(vg,c_pre,vg,c_post)
legend('c pre','c post')
title('C vs VG (given)')
xlabel(' VG(in V)') 
ylabel('C in F/m^2') 


% figure(2)
% plot(vg - ( vmg_pre - vmg_ideal),c_pre,vg +( vmg_ideal - vmg_post),c_post)
% legend('c pre','c post')
% title('C vs VG (removing fixed charge)')
% xlabel(' VG(in V)') 
% ylabel('C in F/m^2') 
% %ideal cv
samples = 100000;
phi_s = linspace(-0.88*phif,2.5*phif,samples);
%phi_s = linspace(,2*phif,samples);
for i = 1:samples
      c_ideal(1,i) = c_total_h(phi_s(1,i),Cox,na);
      vg_ideal(1,i) = vfb_ideal+phi_s(1,i)+sign(phi_s(1,i))*(total_charge(phi_s(1,i),Cox,na)/Cox );
end
    vg_pre =  vg - ( vmg_pre - vmg_ideal);
    vg_post = vg +( vmg_ideal - vmg_post);
figure(2)
plot(vg - ( vmg_pre - vmg_ideal),c_pre,vg +( vmg_ideal - vmg_post),c_post,vg_ideal,c_ideal)
legend('c pre','cpost','c ideal')
title('C vs VG (removing fixed charge)')
xlabel(' VG(in V)') 
ylabel('C in F/m^2') 

vg_pre = vg - ( vmg_pre - vmg_ideal);
vg_post = vg+( vmg_ideal - vmg_post);
c_low =    7.5840e-04;% lowest c value for dit calculation( after this there is uncertainty
c_high =   0.0310% lowest c value for dit calculation( after this there is uncertainty
[dum highIndexpr] =   min(abs(c_low - c_pre));
[dum lowIndexpr] =   min(abs(c_high - c_pre));
for i = lowIndexpr:highIndexpr
    [c index] = min(abs(c_ideal - c_pre(i)));
    dit_pre(i- lowIndexpr + 1) = Cox*abs((vg_ideal(1,index) - vg_pre(i)))/( q* abs(phif - phi_s(1,index)));
    psi_pre (i- lowIndexpr + 1) = phi_s(1,index);
end
c_highPO = 0.0312;
c_lowPO = 0.00059;
[dum highIndexPO] =   min(abs(c_lowPO- c_post));
[dum lowIndexPO] =   min(abs(c_highPO - c_post));
%c_lowPO = 
for i = lowIndexPO:highIndexPO
    [c index] = min(abs(c_ideal - c_post(i)));
    dit_post(i- lowIndexPO + 1) = Cox*(abs(vg_ideal(1,index) - vg_post(i)))/((q)*abs(phif - phi_s(1,index)));
    psi_post(i- lowIndexPO + 1) = phi_s(1,index);
    dummy(i) = i;
    if i- lowIndexPO + 1 == 35||i- lowIndexPO + 1 == 31
         dit_post(i- lowIndexPO + 1) =  dit_post(i- lowIndexPO)
    end
    
end
figure(3)
semilogy(psi_post,dit_post,psi_pre,dit_pre)
legend('dit post','dit pre')
title('dit vs psi')
xlabel(' /psi_s ') 
ylabel('dit ( SI UNIT)') 


figure(5)
plot(vg,c_pre,vg - ( vmg_pre - vmg_ideal),c_pre)
legend('before removing oxide','after removing oxide')
title('C vs VG (Pre dtress)')
xlabel(' VG(in V)') 
ylabel('C in F/m^2') 


figure(6)
plot(vg,c_post,vg +( vmg_ideal - vmg_post),c_post)
legend('before removing oxide','after removing oxide')
title('C vs VG (Post stress)')
xlabel(' VG(in V)') 
ylabel('C in F/m^2') 
vt_ideal = vfb_ideal+2*phif+sign(2*phif)*(total_charge(2*phif,Cox,na)/Cox )
[dum inde] = min(abs(vg_ideal- vt_ideal));
ct_ideal = c_ideal(inde);
[dum inde_pre]  = min(abs(c_pre- ct_ideal));
[dum inde_post]  = min(abs(c_post- ct_ideal));
vt_pre = vg_pre(inde_pre)
vt_post = vg_pre(inde_post)
% % figure(44)
% % plot(psi_post,dit_post,psi_pre,dit_pre)
% % legend('dit post','dit pre')
% % title('dit vs psi')
% % xlabel(' psi') 
% % ylabel('dit') 
% 
% figure(4)
% semilogy(dit_pre)
% title('dit pre ')
% ylabel('dit') 
% figure(5)
% semilogy(dit_post)
% title('dit post')
% ylabel('dit') 



