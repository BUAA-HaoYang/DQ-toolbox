function varargout = size(a, dim)
% SIZE   Size of matrix.
% (Dual quaternion overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.
switch nargout
    case 0
        switch nargin
            case 1
                size(a.s)
            case 2
                size(a.s, dim)
            otherwise
                error('Too many input parameters.')
        end
    case 1
        switch nargin
            case 1
                varargout{1} = size(a.s);
            case 2
                varargout{1} = size(a.s, dim);
            otherwise
                error('Too many input parameters.')
        end
    case 2
        switch nargin
            case 1
                [varargout{1}, varargout{2}] = size(a.s);
            case 2
                error('Unknown option.');
            otherwise
                error('Too many input parameters.')
        end
    otherwise
        switch nargin
            case 1
                d = size(a.s);
                for k = 1:length(d)
                    varargout{k}=d(k);
                end
            case 2
                error('Unknown option.');
            otherwise
                error('Too many input parameters.')
        end
end
end