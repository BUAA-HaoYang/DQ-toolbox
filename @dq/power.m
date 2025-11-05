function Z = power(X, Y)
% .^   Array power.
% (Dual quaternion overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.

narginchk(2, 2), nargoutchk(0, 1)
if isa(X,'dq')
    if isreal(Y)&&isscalar(Y)&&(Y>=0)
        Y=round(Y);
        if isscalar(X)
            if Y==0
                Z=dq(1);
            else
                Z=dq(1);
                for k=1:Y
                    Z=Z*X;
                end
            end
        else
            [m,n]=size(X);
            if Y==0
                Z=onesd(m,n,'dq');
            else
                Z=onesd(m,n,'dq');
                for k=1:Y
                    Z=Z.*X;
                end
            end
        end
    elseif isreal(Y)&&isscalar(Y)&&(Y<0)
        [m,n]=size(X);
        for k=m*n
            X(k)=inv(X(k));
        end
        Y=-Y;
        Z=X.^Y;
    elseif size(X)==size(Y)
        [m,n]=size(X);
        Z=ones(m,n,'dq');
        for k=m*n
            Z(k)=X(k)^Y(k);
        end
    else
        warning('The second variable must be a real number or a real array with the same dimensions as the first variable.')
    end
end
end

