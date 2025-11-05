function xinv = inv(x)
% INV   Inverse of a dual complex number.
% (Dual complex number overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.
[m, n] = size(x);

if m ~= n
    error('Matrix must be square.');
end
xinv=x;
xinv.s=inv(x.s);
xinv.d=-xinv.s*x.d*xinv.s;
end