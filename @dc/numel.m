function n = numel(a, varargin)
% NUMEL   Number of elements in an array or subscripted array expression.
% (Dual complex number overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.
if isempty(a)
    n = 0;
    return;
end

if nargin == 1
    n = builtin('numel', a.s);
else
    error('dual complex numel function called with varargin, unexpected.');
end
end