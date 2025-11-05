function x = zeros_d(m,n,type)
% ZEROS_D  Creates an m-by-n dual matrix (dual complex or dual quaternion) 
%          with zeros in both the standard part and the dual part.
%
% Syntax:
%   x = zeros_d(m, n)           % Default: creates a dual complex zero 
%                                 matrix
%   x = zeros_d(m, n, type)     % Creates a dual zero matrix of the 
%                                 specified type
%
% Inputs:
%   m       - Number of rows of the dual matrix (positive integer)
%   n       - Number of columns of the dual matrix (positive integer)
%   type    - (Optional) Specifies the type of the dual matrix. 
%             Default: 'dc' (dual complex).
%             Valid options:
%             - 'dc': Dual complex zero matrix (standard part = zeros(m,n),
%               dual part = zeros(m,n))
%             - 'dq': Dual quaternion zero matrix (standard part = 
%               zeros(m,n), dual part = zeros(m,n))
%
% Outputs:
%   x       - m-by-n dual zero matrix of the specified type. 
%             Both its standard part and dual part are m-by-n zero
%             matrices.

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.

if nargin < 3
    type = 'dc';
end

switch lower(type)
    case 'dq'
        x=dq(zeros(m,n),zeros(m,n));
    otherwise
        x=dc(zeros(m,n),zeros(m,n));
end


end