function r = mrdivide(a, b)
% /   Slash or right matrix divide.
% (Dual quaternion overloading of standard Matlab function.)
%
% This function is implemented only for the case in which the
% second parameter is a scalar. In this case, the result is as
% given by the ./ function.

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.

narginchk(2, 2), nargoutchk(0, 1)

if isscalar(b)
    r = a ./ b;
else
    warning('Dual quaternion/mrdivide is implemented only for division by a scalar.');
end

end

