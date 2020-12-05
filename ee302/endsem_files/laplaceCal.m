syms t
syms s
laplace(t)
laplace(t*heaviside(t));% to get u(t)======use heavyside(t)
ilaplace((4*exp(-4*s))/s + exp(-4*s)/s^2)

%final vaue theorem :f(infinity) = lim s tending to zero sF(s)
%initial vaue theorem :f(0+) = lim s tending to infinity sF(s)
% Laplace of delta is 1
%integration(0- to infi):F(s)/s
%differentiation L(df/dt) = sF(s) - f(0-) 