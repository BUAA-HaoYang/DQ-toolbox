function Z = mpower(X, Y)
% ^   Matrix power.
% (Dual quaternion overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.
narginchk(2, 2), nargoutchk(0, 1)
[m,n]=size(X);
if m ~= n
    error('Matrix must be square.');
end
if isscalar(X)&&isreal(Y)&&isscalar(Y)
    Z=power(X,Y);
elseif m==n&&isscalar(Y)&&isreal(Y)
    switch Y
        case 0
            Z=dq(eye(m,n));
        case 1
            Z=X;
        case 2
            Z=X*X;
        case -1
            Z=inv(X);
        otherwise
            if Y>0&&isinteger(Y)
                Z=dq(eye(m,n));
                for k=1:Y
                    Z=X*Z;
                end
            elseif Y<0&&isinteger(Y)
                Z=inv(X)^(-Y);
            else
                Z=X;
                warning('The value of the exponent that is currently not supported,return the original value of the matrix.');
            end
    end
else
    warning('Matrix must be square and the exponent must be a real scalar.')
end

end


