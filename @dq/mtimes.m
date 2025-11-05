function result = mtimes(a, b)
% *   Matrix multiply.
% (Dual quaternion overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.
da=isa(a, 'dq');
db=isa(b, 'dq');
if da&&db
    result=a;
    result.s=a.s*b.s;
    result.d=a.d*b.s+a.s*b.d;
    % result=dq(a.s*b.s,a.d*b.s+a.s*b.d);
elseif da
    if isa(b,'dc')
        result=a;
        result.s=a.s*b.s;
        result.d=a.d*b.s+a.s*b.d;
    elseif isnumeric(b)||isa(b,'quaternion')
        result=a;
        result.s=a.s*b;
        result.d=a.d*b;
    else
        error('Unhandled parameter types in function */mtimes')
    end
elseif db
    if isa(a,'dc')
        result=b;
        result.s=a.s*b.s;
        result.d=a.d*b.s+a.s*b.d;
    elseif isnumeric(a)||isa(a,'quaternion')
        result=b;
        result.s=a*b.s;
        result.d=a*b.d;
    else
        error('Unhandled parameter types in function */mtimes')
    end
else
    error('Unhandled parameter types in function */mtimes')
end

end
