function r = ne(a, b)
% ~=  Not equal.
% (Dual complex number overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.

narginchk(2, 2), nargoutchk(0, 1) 

r = ~(a == b); 

end


