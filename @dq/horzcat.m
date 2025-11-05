function c = horzcat(varargin)
% HORZCAT  Horizontally concatenate multiple dc objects.
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
        c = horzcat(a, varargin{3:end});
        return
    end
elseif isempty(a)
    if length(varargin) == 2
        c = b;
        return
    else
        c = horzcat(b, varargin{3:end});
        return
    end
end
    c=dq(horzcat(a.s,b.s),horzcat(a.d,b.d));

if length(varargin) == 2
    return
else
    % remainingArgs = varargin(3:end);
    % c = horzcat(c, remainingArgs{:});
    c = horzcat(c, varargin{3:end});
end
end
