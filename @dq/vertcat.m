function c = vertcat(varargin)
% VERTCAT Vertical concatenation.
% (Dual quaternion overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.

narginchk(1, inf); 

if length(varargin) == 1
    c = varargin{1};
    return
end
a=dq(varargin{1});
b=dq(varargin{2});

if isempty(b)
    if length(varargin) == 2
        c = a;
        return
    else
        remainingArgs = varargin(3:end);
        c = vertcat(a, remainingArgs{:});
        return
    end
elseif isempty(a)
    if length(varargin) == 2
        c = b;
        return
    else
        remainingArgs = varargin(3:end);
        c = vertcat(b, remainingArgs{:});
        return
    end
end
    c=dq(vertcat(a.s,b.s),vertcat(a.d,b.d));

if length(varargin) == 2
    return
else
    % remainingArgs = varargin(3:end);
    % c = vertcat(c, remainingArgs{:});
    c = vertcat(c, varargin{3:end});
end
end