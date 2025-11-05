function sa = sqrt(a)
% SQRT   Square root.
% (Dual complex number overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.

assert(a.s>0)
sa=a;
sa.s = sqrt(a.s);
sa.d = a.d/(2*sa.s);
%sa=dc(sa.s,sa.d);
end

