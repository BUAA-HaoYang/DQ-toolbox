function b = uminus(a)
% -  Unary minus.
% (Dual complex number overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.
narginchk(1, 1), nargoutchk(0, 1)
b=a;
b.s=-a.s;
b.d=-a.d;
%b=dc(-a.s,-a.d);
end

