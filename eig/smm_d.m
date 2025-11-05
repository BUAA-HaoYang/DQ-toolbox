function [eigVal, eigVec] = smm_d(A,type)
% SMM_D  Computing all eigenpairs by SMM
%
% Syntax:
%   [eigVal, eigVec] = smm_d(A,type)
%
% Inputs:
%   A       - Dual complex Hermitian matrix or dual quaternion Hermitian
%             matrix 
%   type    - Algebraic type specification for operations (optional, 
%             default: 'dc')
%             - 'dc': Dual complex — default type
%             - 'dq': Dual quaternion — for dual quaternion matrices
%
% Outputs:
%   eigVal  - Full set of eigenpairs for the dual matrix 
%   eigVec  - Corresponding eigenvectors for the dual matrix 
%             Same algebraic type as eigVal

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.

% Reference:
%
% Qi, Liqun, and Chunfeng Cui. "Eigenvalues of dual Hermitian matrices with
% application in formation control." SIAM Journal on Matrix Analysis and 
% Applications 45.4 (2024): 2135-2154.

    if nargin <= 1
        type = 'dc';
    end
    % the standard part of eigenvalues and eigenvectors
    As = A.s;
    Ad = A.d;
    n = size(As,1);   
    if strcmpi(type,'dq')
        [V,D] = eig(As); 
    else
        [V,D] = eig(As);
    end
   
    eigAs = diag(D);   

    [eigU,~,ic] = uniquetol(eigAs,1e-12);
     
    if strcmpi(type,'dq')
        eigval_d = zerosq(n,1);
        eigvec_d = zerosq(n,1);
    else
        eigval_d = zeros(n,1);
        eigvec_d = zeros(n,1);
    end
    eigvAs = V;
    for i = 1:length(eigU) 
        lmds = eigU(i);
        idx = find(ic==i)';
        nrep = length(idx);
        W = V(:,idx);
        lmd = ctranspose(W)*Ad*W;
        if strcmpi(type,'dq')
            lmd = lmd.w;
        else            
            lmd = (ctranspose(lmd)+lmd)/2;
        end
        if nrep == 1   
            xs = V(:,idx);
            eigval_d(idx) = lmd;
            eigvec_d(:,idx) = V*pinv(lmds*eye(n) - D)*ctranspose(V)*(Ad*xs);  
        else 
            SM = ctranspose(W)*Ad*W;
            [Y,eigW] = eig((ctranspose(SM)+SM)/2); 
            eigval_d(idx) = diag(eigW);
            Xs = W*Y;
            eigvAs(:,idx) = Xs; 
            eigvec_d(:,idx) = V*pinv(lmds*eye(n) - D)*ctranspose(V)*(Ad*Xs); 
        end   
    end
    
    eigVal=dcdq(eigAs,eigval_d);
    eigVec=dcdq(eigvAs,eigvec_d);
end