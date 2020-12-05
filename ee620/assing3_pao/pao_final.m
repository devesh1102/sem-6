
 vg=0.6561;
 kt_q=0.025
[vds_pao,Ids_pao] = pao_f(vg);
[vds_pao5,Ids_pao5] = pao_f(vg + 5*kt_q);
[vds_pao10,Ids_pao10] = pao_f(vg +10*kt_q);
[vds_pao15,Ids_pao15] = pao_f(vg +15*kt_q);

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