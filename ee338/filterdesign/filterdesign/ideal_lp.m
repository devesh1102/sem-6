% function output = ideal_lp(F,order);
% if( mod(order,2) == 0)
%     order = order+1;
% end
% for i = 1:(order-1)/2;
%     m(i) =  -1* (order-1)/2 +i -1;
% end
% for i = 1+ (order-1)/2:(order);
%     m(i) =  -1* (order-1)/2 +i -1;
% end
% 
% output = sin(F*m) ./ (pi*m);
% output(1+(order-1)/2) = 1;
% 
% end
function lowpass = ideal_lp(Wc,F);

alpha = (F-1)/2;
n = [0:1:(F-1)];
m = n - alpha+eps;
lowpass = sin(Wc*m)./(pi*m);
end
