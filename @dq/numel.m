function n = numel(dq, varargin)
% NUMEL   Number of elements in an array or subscripted array expression.
% (Dual quaternion overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.
if isempty(dq)
    n = 0; 
    return;
end

if nargin == 1
    n = builtin('numel', dq.s);
else
    warning('dual quaternion numel function called with varargin, unexpected.');
end
end