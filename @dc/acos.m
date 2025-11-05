function theta = acos(a)
% ACOS    Inverse cosine.
% (Dual complex number overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.
theta=a;
theta.s = acos(a.s);
if abs(sin(theta.s)) < 1e-16
    theta.d = 0;
else
    theta.d = -a.d./sin(theta.s);
end

end