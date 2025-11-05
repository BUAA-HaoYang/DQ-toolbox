function C = adjoint_d(A,type)
% ADJOINT_D   Computes the adjoint matrix of a dual complex matrix or a
% dual quaternion matrix
%
% Syntax:
%   C = adjoint_d(A)               % Default: computes dual complex adjoint
%                                    matrix (type = 'dc')
%   C = adjoint_d(A, 'c')          % Computes dual complex adjoint matrix
%   C = adjoint_d(A, 'dc')         % Same as above (dual complex)
%   C = adjoint_d(A, 'complex')    % Same as above (dual complex)
%   C = adjoint_d(A, 'r')          % Computes dual number adjoint matrix
%   C = adjoint_d(A, 'dn')         % Same as above (dual number)
%   C = adjoint_d(A, 'real')       % Same as above (dual number)
%
% Inputs:
%   A       - Input matrix, which can be of type:
%             - 'dc' (dual complex)
%             - 'dq' (dual quaternion)
%             - numeric (real/complex matrix, treated as dual complex with 
%               trivial dual part)
%             - 'quaternion' (quaternion matrix)
%   type    - (Optional) Specifies the algebraic type for the adjoint 
%             operation. 
%             Default: 'dc' (dual complex).
%             Valid options:
%             - 'c', 'dc', 'complex': Dual complex adjoint matrix
%             - 'r', 'dn', 'real': Dual number adjoint matrix
%
% Outputs:
%   C       - Adjoint matrix of A, with type matching the specified 'type' 
%             (dual complex or dual number).
%             If input type is unsupported, returns A with a warning.

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.

% Reference:
%
% Chen, Yongjun, and Liping Zhang. "Dual Complex Adjoint Matrix and 
% Applications to Hand-Eye Calibration and Multi-Agent Formation Control." 
% Journal of Scientific Computing 104.1 (2025): 4.


if nargin < 2
    type='dc';
end

switch lower(type)
    case {'c','dc','complex'}
        if isa(A,'dq')
            C=dc(adjoint(A.s),adjoint(A.d));
        elseif isa(A,'dc')||isnumeric(A)
            A=dq(A);
            C=dc(adjoint(A.s),adjoint(A.d));
        elseif isa(A,'quaternion')
            C=adjoint(A);
        else
            warning('Unsupported input matrix class: %s', class(A));
            C=A;
        end
    case {'r','dn','real'}
        if isa(A,'dq')
            C=dc(adjoint(A.s,'real'),adjoint(A.d,'real'));
        elseif isa(A,'dc')||isnumeric(A)
            A=dq(A);
            C=dc(adjoint(A.s,'real'),adjoint(A.d,'real'));
        elseif isa(A,'quaternion')
            C=adjoint(A,'real');
        else
            warning('Unsupported input matrix class: %s', class(A));
            C=A;
        end
    otherwise
        warning('The second input parameter is not supported.');
        C=A;
end
end


