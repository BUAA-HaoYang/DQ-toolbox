function d = diag(v, k)
% DIAG Diagonal matrices and diagonals of a matrix.
% (Dual quaternion overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.

narginchk(1, 2), nargoutchk(0, 1) 

if nargin == 1
    d = dq(diag(v.s),diag(v.d));
else
    d = dq(diag(v.s,k),diag(v.d,k));
end

end

