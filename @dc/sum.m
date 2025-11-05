function t = sum(a, dim)
% SUM Sum of elements.
% (Dual complex number overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.

narginchk(1, 2), nargoutchk(0, 1)
as=a.s;
ad=a.d;
if nargin == 1
    t=dc(sum(as),sum(ad));
else
    if ischar(dim)
        if (strcmp(dim, 'double') || strcmp(dim, 'native'))
            error(['Parameters ''double'' or ''native'' are not'...
                ' implemented in the dual complex number sum function.']);
        elseif strcmp(dim, 'all')||strcmp(dim, "all")
            t=dc(sum(as,dim),sum(ad,dim));
        else
            error('Dimension argument must be numeric');
        end
    else
        if ~isnumeric(dim)
            error('Dimension argument must be numeric');
        elseif ismember(dim, 1:ndims(a))
            t=dc(sum(as,dim),sum(ad,dim));
        else
            error('Dimension argument must be in the indexing range.');
        end
    end

end

end

