function c = horzcat(varargin)
% HORZCAT  Horizontally concatenate multiple dc objects.
% (Dual complex number overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.

narginchk(1, inf);

if length(varargin) == 1
    c = varargin{1};
    return
end
a=varargin{1};
b=varargin{2};
if isa(a,'quaternion')||isa(a,'dq')||isa(b,'quaternion')||isa(b,'dq')
    for i = 1:nargin
        varargin{i}=dq(varargin{i});
    end
    c = horzcat(varargin{:});
    return
else
    a=dc(a);
    b=dc(b);
end

if isempty(b)
    if length(varargin) == 2
        c = a;
        return
    else
        remainingArgs = varargin(3:end);
        c = horzcat(a, remainingArgs{:});
        return
    end
elseif isempty(a)
    if length(varargin) == 2
        c = b;
        return
    else
        remainingArgs = varargin(3:end);
        c = horzcat(b, remainingArgs{:});
        return
    end
end
c=dc(horzcat(a.s,b.s),horzcat(a.d,b.d));

if length(varargin) == 2
    return
else
    % remainingArgs = varargin(3:end);
    % c = horzcat(c, remainingArgs{:});
    c = horzcat(c, varargin{3:end});
end
end

