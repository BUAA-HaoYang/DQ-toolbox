function b = uminus(a)
% -  Unary minus.
% (Dual quaternion overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.

narginchk(1, 1), nargoutchk(0, 1)
b=a;
b.s=-a.s;
b.d=-a.d;
end