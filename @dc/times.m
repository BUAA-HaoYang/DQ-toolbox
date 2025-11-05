function result = times(a, b)
% .*  Array multiply.
% (Dual complex number overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.

da=isa(a, 'dc');
db=isa(b, 'dc');
if da&&db
    result=a;
    result.s=a.s.*b.s;
    result.d=a.s.*b.d+a.d.*b.s;
%    result=dc(a.s+b.s,a.d+b.d);
elseif da
    if isa(b,'dq')
        result=b;
        result.s=a.s.*b.s;
        result.d=a.d.*b.s+a.s.*b.d;
    elseif isnumeric(b)
        result=a;
        result.s=a.s.*b;
        result.d=a.d.*b;
    elseif isa(b,'quaternion')
        result=dq(a.s.*b,a.d.*b);
    else
        error('Unhandled parameter types in function */times')
    end
elseif db
    if isa(a,'dq')
        result=a;
        result.s=a.s.*b.s;
        result.d=a.s.*b.d+a.d.*b.s;
    elseif isnumeric(a)
        result=b;
        result.s=a.*b.s;
        result.d=a.*b.d;
    elseif isa(a,'quaternion')
        result=dq(a.*b.s,a.*b.d);
    else
        error('Unhandled parameter types in function .*/times')
    end
else
    error('Unhandled parameter types in function .*/times')
end
end


