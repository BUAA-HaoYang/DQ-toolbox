function b = ctranspose(a)
% '   Dual complex number conjugate transpose.
% (Dual complex number overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.
% b=a;
% b.s=ctranspose(a.s);
% b.d=ctranspose(a.d);
b=dc(ctranspose(a.s),ctranspose(a.d));
end