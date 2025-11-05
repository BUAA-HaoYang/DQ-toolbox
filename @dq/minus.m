function result = minus(a, b)
% -   Minus.
% (Dual quaternion overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.
narginchk(2, 2), nargoutchk(0, 1)
result = plus(a, -b);
end