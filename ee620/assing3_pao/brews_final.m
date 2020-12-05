
 vg=0.6561;
 kt_q=0.025
[vds_brew,Ids_brew] = brew_IDS(vg);
[vds_brew5,Ids_brew5] = brew_IDS(vg + 5*kt_q);
[vds_brew10,Ids_brew10] = brew_IDS(vg +10*kt_q);
[vds_brew15,Ids_brew15] = brew_IDS(vg +15*kt_q);

figure(1)
plot(vds_brew,Ids_brew)
title('I_{ds} . vs V_{ds} brews 0')
xlabel(' Vd(in V)') 
ylabel('Id in A')

figure(2)
plot(vds_brew5,Ids_brew10)
title('I_{ds} . vs V_{ds}brews vg +5*kt_q')
xlabel(' Vd(in V)') 
ylabel('Id in A')

figure(3)
plot(vds_brew10,Ids_brew10)
title('I_{ds} . vs V_{ds} brews vg +10*kt_q')
xlabel(' Vd(in V)') 
ylabel('Id in A')

figure(4)
plot(vds_brew15,Ids_brew15)
title('I_{ds} . vs V_{ds} brews vg + 15*kt_q')
xlabel(' Vd(in V)') 
ylabel('Id in A')

figure(5)
plot(vds_brew,Ids_brew,vds_brew5,Ids_brew5,vds_brew10,Ids_brew10,vds_brew15,Ids_brew15)
title('I_{ds} . vs V_{ds} brews')
legend(num2str(vg),num2str(vg + 5*kt_q),num2str(vg + 10*kt_q),num2str(vg + 15*kt_q))
xlabel(' Vd(in V)') 
ylabel('Id in A')
