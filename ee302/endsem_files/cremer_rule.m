% 2x + y + z = 3
% x – y – z = 0
% x + 2y + z = 0
syms s
A = [2 1 1; 1 -1 -1; 1 2 1]     % Coefficient Matrix
X = [3; 0; 0]
Ax = [X A(:,2) A(:,3) ] 
Ay = [A(:,1) X A(:,3) ] 
Az = [A(:,1) A(:,2) X ] 
detA=det(A)
x = det(Ax)/detA
y = det(Ay)/detA
z = det(Az)/detA