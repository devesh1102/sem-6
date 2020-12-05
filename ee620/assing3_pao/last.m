
 vg=0.6561;
 kt_q=0.025
 [vds_piece,Ids_piece] = without_approx(vg);
 [vds_piece5,Ids_piece5] = without_approx(vg + 5*kt_q);
 [vds_piece10,Ids_piece10] = without_approx(vg +10*kt_q);
 [vds_piece15,Ids_piece15] = without_approx(vg +15*kt_q);
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[vds_pao,Ids_pao] = pao_f(vg);
[vds_pao5,Ids_pao5] = pao_f(vg + 5*kt_q);
[vds_pao10,Ids_pao10] = pao_f(vg +10*kt_q);
[vds_pao15,Ids_pao15] = pao_f(vg +15*kt_q);


[vds_brew,Ids_brew] = brew_IDS(vg);
[vds_brew5,Ids_brew5] = brew_IDS(vg + 5*kt_q);
[vds_brew10,Ids_brew10] = brew_IDS(vg +10*kt_q);
[vds_brew15,Ids_brew15] = brew_IDS(vg +15*kt_q);

figure(1)
plot(vds_pao,Ids_pao)
title('I_{ds} . vs V_{ds} pao shah 0')
xlabel(' Vd(in V)') 
ylabel('Id in A')

figure(2)
plot(vds_pao5,Ids_pao5)
title('I_{ds} . vs V_{ds} pao shah vg +5*kt_q')
xlabel(' Vd(in V)') 
ylabel('Id in A')

figure(3)
plot(vds_pao10,Ids_pao10)
title('I_{ds} . vs V_{ds} pao shah vg +10*kt_q')
xlabel(' Vd(in V)') 
ylabel('Id in A')

figure(4)
plot(vds_pao15,Ids_pao15)
title('I_{ds} . vs V_{ds} pao shah vg + 15*kt_q')
xlabel(' Vd(in V)') 
ylabel('Id in A')

figure(5)
plot(vds_pao,Ids_pao,vds_pao5,Ids_pao5,vds_pao10,Ids_pao10,vds_pao15,Ids_pao15)
title('I_{ds} . vs V_{ds} pao')
legend(num2str(vg),num2str(vg + 5*kt_q),num2str(vg + 10*kt_q),num2str(vg + 15*kt_q))
xlabel(' Vd(in V)') 
ylabel('Id in A')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 vg=0.6561;
 kt_q=0.025


figure(6)
plot(vds_brew,Ids_brew)
title('I_{ds} . vs V_{ds} brews 0')
xlabel(' Vd(in V)') 
ylabel('Id in A')

figure(7)
plot(vds_brew5,Ids_brew10)
title('I_{ds} . vs V_{ds}brews vg +5*kt_q')
xlabel(' Vd(in V)') 
ylabel('Id in A')

figure(8)
plot(vds_brew10,Ids_brew10)
title('I_{ds} . vs V_{ds} brews vg +10*kt_q')
xlabel(' Vd(in V)') 
ylabel('Id in A')

figure(9)
plot(vds_brew15,Ids_brew15)
title('I_{ds} . vs V_{ds} brews vg + 15*kt_q')
xlabel(' Vd(in V)') 
ylabel('Id in A')

figure(10)
plot(vds_brew,Ids_brew,vds_brew5,Ids_brew5,vds_brew10,Ids_brew10,vds_brew15,Ids_brew15)
title('I_{ds} . vs V_{ds} brews')
legend(num2str(vg),num2str(vg + 5*kt_q),num2str(vg + 10*kt_q),num2str(vg + 15*kt_q))
xlabel(' Vd(in V)') 
ylabel('Id in A')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


figure(11)
plot(vds_pao,Ids_pao,vds_piece,Ids_piece,vds_brew,Ids_brew)
title('I_{ds} . vs V_{ds} (for vg = 0.6561V) ')
legend('pao','with approx','brew')
xlabel(' Vd(in V)') 
ylabel('Id in A')

figure(12)
plot(vds_pao5,Ids_pao5,vds_piece5,Ids_piece5,vds_brew5,Ids_brew5)
title('I_{ds} . vs V_{ds} (for vg = 0.6561V + 5*kt/q) ')
legend('pao','with approx','brew')
xlabel(' Vd(in V)') 
ylabel('Id in A')

figure(13)
plot(vds_pao10,Ids_pao10,vds_piece10,Ids_piece10,vds_brew10,Ids_brew10)
title('I_{ds} . vs V_{ds} (for vg = 0.6561V +10*kt/q) ')
legend('pao','with approx','brew')
xlabel(' Vd(in V)') 
ylabel('Id in A')


figure(14)
plot(vds_pao15,Ids_pao15,vds_piece15,Ids_piece15,vds_brew15,Ids_brew15)
title('I_{ds} . vs V_{ds} (for vg = 0.6561V +15*kt/q) ')
legend('pao','with approx','brew')
xlabel(' Vd(in V)') 
ylabel('Id in A')