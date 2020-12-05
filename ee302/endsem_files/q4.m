g1=tf([1],[1 0]) % your GH(s) transfer function
g3=tf([1],[1 4])
g2=tf ([1], [1 4 20] )
%g2=tf([1],[1 100 2600]) % your second TF (s+1)/(s+9)
%g4=tf([1],[1 5])
 g=g1*g3*g2
 RLocusGui(g) 
