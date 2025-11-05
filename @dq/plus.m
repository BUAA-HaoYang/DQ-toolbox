function result = plus(a, b)
% +   Plus.
% (Dual quaternion overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.
narginchk(2, 2);
nargoutchk(0, 1);
da=isa(a, 'dq');
db=isa(b, 'dq');
if da&&db
    result=a;
    result.s=a.s+b.s;
    result.d=a.d+b.d;
    % result=dq(a.s+b.s,a.d+b.d);
elseif da
    if isa(b,'dc')
        result=a;
        result.s=a.s+b.s;
        result.d=a.d+b.d;
    elseif isnumeric(b)||isa(b,'quaternion')
        result=a;
        result.s=a.s+b;
    else
        error('Unhandled parameter types in function +/plus')
    end
elseif db
    if isa(a,'dc')
        result=b;
        result.s=a.s+b.s;
        result.d=a.d+b.d;
    elseif isnumeric(a)||isa(a,'quaternion')
        result=b;
        result.s=a+b.s;
    else
        error('Unhandled parameter types in function +/plus')
    end
else
    error('Unhandled parameter types in function +/plus')
end
end