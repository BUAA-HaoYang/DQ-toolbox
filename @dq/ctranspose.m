function b = ctranspose(a)
% '   Dual quaternion conjugate transpose.
% (Dual quaternion overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.

% b=a;
% b.s=ctranspose(a.s);
% b.d=ctranspose(a.d);
b=dq(ctranspose(a.s),ctranspose(a.d));
end