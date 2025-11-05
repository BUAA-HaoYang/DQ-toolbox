function tf = ishermitian(A, tol)
% ISHERMITIAN  True if the given matrix is Hermitian to within the tolerance
% given (optionally) by the second parameter.

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.

narginchk(1, 2), nargoutchk(0, 1)

if nargin == 1
    tol = eps; % The tolerance was not specified, supply a default.
end

[m, n] = size(A);

if m ~= n
    warning('Cannot test whether a non-square matrix is Hermitian.');
    tf=false;
else
    tf = norm(A'-A,'FR')<tol;
end

end