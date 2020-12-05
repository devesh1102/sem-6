
vg=0.6561;
 kt_q=0.025
 [vds5,Ids5] = pao_f(2.5);
 [vds,Ids] = without_approx(2.5);
[vds1,Ids1] = brew_IDS(2.5);



figure(2)
plot(vds5,Ids5)
title('I_{ds} . vs V_{ds} pao shah vg +5*kt_q')
xlabel(' Vd(in V)') 
ylabel('Id in A')


figure(3)
plot(vds,Ids)
title('I_{ds} , vs V_{ds}(without taylor series) ')
xlabel(' Vds(in V)') 
ylabel('Id in A')

figure(4)
plot(vds1,Ids1)
title('I_{ds} . vs V_{ds} brews vg + 15*kt_q')
xlabel(' Vd(in V)') 
ylabel('Id in A')

figure(5)
plot(vds5,Ids5,vds,Ids,vds1,Ids1)
title('I_{ds} . vs V_{ds} ')
legend('pao','with approx','brew')
xlabel(' Vd(in V)') 
ylabel('Id in A')
