function A = ones_d(m,n,type)
% ONES_D  Creates an m-by-n dual matrix (dual complex or dual quaternion) 
%         with ones in the standard part and zeros in the dual part.
%
% Syntax:
%   A = ones_d(m, n)           % Default: creates a dual complex matrix of 
%                                ones
%   A = ones_d(m, n, type)     % Creates a dual matrix of ones with the  
%                                specified type
%
% Inputs:
%   m       - Number of rows of the dual matrix (positive integer)
%   n       - Number of columns of the dual matrix (positive integer)
%   type    - (Optional) Specifies the type of the dual matrix. 
%             Default: 'dc' (dual complex).
%             Valid options:
%             - 'dc': Dual complex matrix (standard part = ones(m,n), dual 
%                     part = zeros(m,n))
%             - 'dq': Dual quaternion matrix (standard part = ones(m,n), 
%                     dual part = zeros(m,n))
%
% Outputs:
%   A       - m-by-n dual matrix of the specified type. 
%             Its standard part is an m-by-n matrix of ones (ones(m,n)), 
%             and its dual part is an m-by-n zero matrix (zeros(m,n)).

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.
if nargin <3
    type = 'dc';
end
switch lower(type)
    case 'dq'
        A=dq(ones(m,n),zeros(m,n));
    otherwise
        A=dc(ones(m,n),zeros(m,n));
end
end