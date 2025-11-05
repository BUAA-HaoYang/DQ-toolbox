function result = minus(a, b)
% -   Minus.
% (Dual complex number overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.
narginchk(2, 2), nargoutchk(0, 1)

result = plus(a, -b);

end

