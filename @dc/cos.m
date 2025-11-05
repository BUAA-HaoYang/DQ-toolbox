function a = cos(theta)
% COS    Cosine.
% (Dual complex number overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.
a=thata;
a.s = cos(theta.s);
a.d = -theta.d.*sin(theta.s);
%a=dc(a.s,a.d);
end