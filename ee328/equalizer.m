%pkg load signal;
b = sign(randn(10,1));
p = [1 2 -2];
r = conv(upsample(b', 2), p);
r = r + 1 * randn(size(r));
U = zeros(5,3);
U(:,1) = [p(2) p(3) 0 0 0];
U(:,2) = [0 p(1) p(2) p(3) 0];
U(:,3) = [0 0 0 p(1) p(2)];
c = U * inv(U'*U) * [0 1 0]';
br = zeros(size(b));
br(1) = 1;
j = 2;
for i=2:2:(length(r) - 4)
  br(j) = c'*r(i:i+4)';
  j = j + 1;
end;
disp([b br]);
%zero forcing 