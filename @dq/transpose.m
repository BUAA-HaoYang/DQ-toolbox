function t = transpose(a)
% .'  Transpose.
% (Dual quaternion overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.

narginchk(1, 1), nargoutchk(0, 1)
t=dq(transpose(a.s),transpose(a.d));

end

