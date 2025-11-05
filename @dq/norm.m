function n = norm(A, normtype)
% NORM   Matrix or vector norm.
% (Dual quaternion overloading of standard Matlab function.)

% Copyright © 2025 Hao Yang, Tao Sang, and Chunfeng Cui.

narginchk(1, 2), nargoutchk(0, 1)

if nargin == 1
    n = norm(A, 'fro');
    return
end

if isvector(A)
    % A is a vector.
    switch normtype
        case 1
            n = real(dc(sum(abs(A))));
        case {2,'fro','Fro'}
            As=A.s;Ad=A.d;
            nA=sum(As.w.^2+As.x.^2+As.y.^2+As.z.^2);
            if ~(nA==0)
                n = sqrt(dc(nA,sum(As.w.*Ad.w+As.x.*Ad.x+As.y.*Ad.y+As.z.*Ad.z)*2));
            else
                n=dc(0,norm(A.d,2));
            end
            % case other integer values of p are not supported, although the
            % standard Matlab norm function does handle them.
        case {'2R','2r'}
            n=sqrt(norm(A.s,2)^2+norm(A.d,2)^2);
        case {'FR','fr','Fr'}
            n=sqrt(norm(A.s,2)^2+norm(A.d,2)^2);
        case inf
            %        n = max(abs(A));
            n = norm(A,2);
            warning('The infinity norm of a dual quaternion vector is currently not supported, return its 2-norm.')
        case -inf
            %        n = min(abs(A));
            warning('The infinity norm of a dual quaternion vector is currently not supported, return its 2-norm.')
            n = norm(A,2);
        case 'st'
            n=sum(abs(A.s));
            n=n.w;
        otherwise
            warning('Illegal second parameter to dual quaternion vector norm, return its 2-norm.')
            n = norm(A,2);
    end
elseif ismatrix(A)
    % A is a matrix.
    switch normtype
        case 1
            %        n = max(sum(abs(A)));
            warning('The 1-norm of a dual quaternion matrix is currently not supported, return its Frobenius norm.')
            n = norm(A,'fro');
        case 2
            warning('The 2-norm of a dual quaternion matrix is currently not supported, return its Frobenius norm.')
            n = norm(A,'fro');
            %        t = svd(A);
            %        n = t(1);
        case inf
            warning('The infinity norm of a dual quaternion matrix is currently not supported, return its Frobenius norm.')
            n = norm(A,'fro');
            %       n = max(sum(abs(A')));
        case {'fro','Fro'}
            if ~isequal(A,zeros(size(A)))
                n = sqrt(real(dc(sum(diag(A'*A)))));
            else
                n=dc(0,norm(A.d,'fro'));
            end
        case {'FR','fr','Fr'}
            n=sqrt(norm(A.s,'fro')^2+norm(A.d,'fro')^2);
        otherwise
            warning('Illegal second parameter to dual quaternion matrix norm, return its Frobenius norm.')
            n = norm(A,'fro');
    end
else
    % A has more than two dimensions.
    error('Cannot compute norm of arrays with more than two dimensions.')
end

end