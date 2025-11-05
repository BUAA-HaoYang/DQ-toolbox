function c = vertcat(varargin)
% VERTCAT Vertical concatenation.
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
    c = vertcat(varargin{:});
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
    c=dc(vertcat(a.s,b.s),vertcat(a.d,b.d));

if length(varargin) == 2
    return
else
    % remainingArgs = varargin(3:end);
    % c = vertcat(c, remainingArgs{:});
    c = vertcat(c, varargin{3:end});
end
end

