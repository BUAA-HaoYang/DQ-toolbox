function a = sin(theta)
% SIN    Sine.
% (Dual complex number overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.
a=theta;
a.s = sin(theta.s);
a.d = theta.d.*cos(theta.s);
%a=dc(a.s,a.d);
end