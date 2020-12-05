  syms s;
    A = [1+s; -s; 0]
    B=[-s;1+2*s;-1*s]
    C = [0; -s; s+1+(1/s)]
    out = [1; 0 ;0]
    D = [A B C]
    I1 = [out B C]
    I2 = [A out C]
    I3 = [A B out]
    I1 = det(I1)/det(D)
    I2 = det(I2)/det(D)
    t=0:0.01:20;
    I3 = det(I3)/det(D)
    step(I3,t)
    ilaplace(I3)
    a = (1+5/s)/(5+5/s)
    pretty(ilaplace(a))
   pretty( simplify(a))
