function r = eq(a, b)
% ==  Equal.
% (Dual quaternion overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.

narginchk(2, 2), nargoutchk(0, 1)

if isa(a,'dq')&&isa(b,'dq')
    r=(a.s==b.s) & (a.d==b.d);
elseif isa(a,'dq')&&(isnumeric(b)||isa(b,'dc'))
    r=a==dq(b);
elseif (isnumeric(a)||isa(a,'dc'))&&isa(b,'dq')
    r=dq(a)==b;
end

end

