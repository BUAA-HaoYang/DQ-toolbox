function B = permute(A, order)
% PERMUTE Rearrange dimensions of N-D array
% (Dual complex overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.


narginchk(2, 2), nargoutchk(0, 1)

B = dc(permute(A.s,order),permute(A.d,order));

end

