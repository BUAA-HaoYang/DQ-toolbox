function result=plus(a,b)
% +   Plus.
% (Dual complex number overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.
da=isa(a, 'dc');
db=isa(b, 'dc');
if da&&db
    result=a;
    result.s=a.s+b.s;
    result.d=a.d+b.d;
%    result=dc(a.s+b.s,a.d+b.d);
% elseif da&&isnumeric(b)
%     result=a;
%     result.s=a.s+b;
% elseif isnumeric(a)&&db
%     result=b;
%     result.s=a+b.s;
% elseif (isa(a,'quaternion')&&db)||(da&&isa(b,'quaternion'))
%     result=dq(a)+dq(b);
% else
%     error('Unhandled parameter types in function +/plus')
% end
elseif da
    if isa(b,'dq')
        result=b;
        result.s=a.s+b.s;
        result.d=a.d+b.d;
    elseif isnumeric(b)
        result=a;
        result.s=a.s+b;
    elseif isa(b,'quaternion')
        result=dq(a.s+b,a.d);
    else
        error('Unhandled parameter types in function +/plus')
    end
elseif db
    if isa(a,'dq')
        result=a;
        result.s=a.s+b.s;
        result.d=a.d+b.d;
    elseif isnumeric(a)
        result=b;
        result.s=a+b.s;
    elseif isa(a,'quaternion')
        result=dq(a+b.s,b.d);
    else
        error('Unhandled parameter types in function +/plus')
    end
else
    error('Unhandled parameter types in function +/plus')
end
end

