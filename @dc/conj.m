function b = conj(a)
% CONJ   Dual complex number conjugate.
% (Dual complex number overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.
b=a;
b.s=conj(a.s);
b.d=conj(a.d);
%b=dc(conj(a.s),conj(a.d));
end