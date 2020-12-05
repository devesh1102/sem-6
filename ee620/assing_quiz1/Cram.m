function [out]=Cram(A,b)
n=length(b);
%res=zeros(n,1);
D=det(A);
if A==0
    error('No Solution')
elseif D==0
    error('No Solution')
end
for i=1:n
    Aug=A;
    Aug(:,i)=b;
    res(i)=(det(Aug)/D);
end
out=res;

