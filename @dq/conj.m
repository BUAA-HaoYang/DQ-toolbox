function b = conj(a)
% CONJ   Dual quaternion conjugate.
% (Dual quaternion overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.
b=a;
b.s=conj(a.s);
b.d=conj(a.d);
%b=dq(conj(a.s),conj(a.d));
end