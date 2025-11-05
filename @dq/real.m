function p = real(q)
% REAL   Real part of a dual quaternion.
% (Dual quaternion overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.

narginchk(1, 1), nargoutchk(0, 1)

p=dq(realq(q.s),realq(q.d));

end