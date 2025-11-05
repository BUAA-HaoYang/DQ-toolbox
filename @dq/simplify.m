function S = simplify(expr, varargin)
% SIMPLIFY  Algebraic simplification of symbolic dual quaternion.
% (Dual quaternion overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.

narginchk(1, inf), nargoutchk(0, 1)

if ~isa(expr, 'dq')
    error('First argument must be a dual quaternion.')
end


if ~isa(expr.s.x, 'sym') || ~isa(expr.d.x, 'sym')
    error('Dual quaternion components must be symbolic quaternions.')
end


sPart = simplify(expr.s, varargin{:});
dPart = simplify(expr.d, varargin{:});


S = dq(sPart, dPart);

end
