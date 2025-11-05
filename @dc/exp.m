function a = exp(theta)
% EXP   Exponential
% (Dual complex number overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.
% a.s = exp(theta.s);
% a.d = theta.d*a.s;
% a=dc(a.s,a.d);
a=theta;
a.s=exp(theta.s);
a.d = theta.d.*a.s;
end