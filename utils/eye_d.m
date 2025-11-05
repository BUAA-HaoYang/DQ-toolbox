function E = eye_d(m,n,type)
% EYE_D   m-by-n dual complex/quaternion identity matrix. 
%
% Syntax:
%   E = eye_d(m, n)           % Default: generates a dual complex (dc) 
%                               identity matrix
%   E = eye_d(m, n, type)     % Generates a dual identity matrix of the 
%                               specified type
%
% Inputs:
%   m       - Number of rows of the identity matrix (positive integer)
%   n       - Number of columns of the identity matrix (positive integer)
%   type    - (Optional) Specifies the type of dual identity matrix. 
%             Default: 'dc' (dual complex).
%             Valid options:
%             - 'dc': Dual complex identity matrix 
%             - 'dq': Dual quaternion identity matrix
%
% Outputs:
%   E       - m-by-n dual identity matrix of the specified type. 
%             Its standard part is the conventional identity matrix 
%             eye(m,n), and its dual part is a zero matrix of size m-by-n.

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.

if nargin < 3
    type = 'dc';
end

switch lower(type)
    case 'dq'
        E=dq(eye(m,n));
    otherwise
        E=dc(eye(m,n));
end
end