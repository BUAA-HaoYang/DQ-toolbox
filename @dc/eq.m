function r = eq(a, b)
% ==  Equal.
% (Dual complex number overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.

narginchk(2, 2), nargoutchk(0, 1)

if (isa(a,'dc')&&isa(b,'dc'))
    r=(a.s==b.s) & (a.d==b.d);
elseif isa(a,'dc')&&(isnumeric(b)||isa(b,'dq'))
    r=dq(a)==b;
elseif (isnumeric(a)||isa(a,'dq'))&&isa(b,'dc')
    r=a==dq(b);
end

end

