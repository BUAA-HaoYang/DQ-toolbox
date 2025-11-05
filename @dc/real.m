function p = real(q)
% REAL   Real part of a dual complex number.
% (Dual complex number overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.

narginchk(1, 1), nargoutchk(0, 1)

p=dc(real(q.s),real(q.d));

end

