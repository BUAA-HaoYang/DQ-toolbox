function b = repmat(a, m, n)
% REPMAT Replicate and tile an array.
% (Dual complex number overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.
narginchk(2, 3), nargoutchk(0, 1) 

if nargin == 2
    b = dc(repmat(a.s,m),repmat(a.d,m));
else
    b = dc(repmat(a.s,m,n),repmat(a.d,m,n));
end

end

