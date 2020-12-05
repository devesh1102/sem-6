function [mag,phase] = to_angle(inputArg1)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
mag = real(inputArg1)*real(inputArg1) +imag(inputArg1)*inputArg1;
angle = atan(imag(inputArg1)/real(inputArg1) )*180/pi

end

