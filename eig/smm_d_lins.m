function [eigVal, eigVec] = smm_d_lins(A,type)
% SMM_D_LINS  Computing all eigenpairs by SMM. Instead of using the closed 
%             forms, we solve linear systems directly
%
% Syntax:
%   [eigVal, eigVec] = smm_d_lins(A,type)
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
    [V,D] = eig(As);
    eigAs = diag(D);   

    [eigU,~,ic] = uniquetol(eigAs,1e-12);
     
    if strcmpi(type,'dq')
        eigAd = zerosq(n,1);
        eigvAd = zerosq(n,1);
    else
        eigAd = zeros(n,1);
        eigvAd = zeros(n,1);
    end
    eigvAs = V;
    for i = 1:length(eigU) 
        lmds = eigU(i);
        idx = find(ic==i)';
        nmultip = length(idx);
        w = V(:,idx);
        lmd = ctranspose(w)*Ad*w;
        if nmultip == 1   
            xs = V(:,idx);
            eigAd(idx) = lmd;
            if strcmpi(type,'dq')
                eigvAd(:,idx) = linsolve_q([As-lmds*eye(n);ctranspose(xs)],...
                    [-Ad*xs + lmd*xs;0]); 
            else
                   eigvAd(:,idx) = linsolve([As-lmds*eye(n);ctranspose(xs)],...
                    [-Ad*xs + lmd*xs;0]); 
            end
        else
            if strcmpi(type,'dq')
                tmp = ctranspose(w)*Ad*w;
                [Y,eigW] = eig((tmp+ctranspose(tmp))/2);
            else                
                [Y,eigW] = eig(ctranspose(w)*Ad*w);
            end
            eigAd(idx) = diag(eigW);
            Xs = w*Y;
            eigvAs(:,idx) = Xs; 
            if strcmpi(type,'dq')
                eigvAd(:,idx) = linsolve_q([As-lmds*eye(n);ctranspose(Xs)], ...
                    [-Ad*Xs +  Xs*diag(eigW);zeros(nmultip,nmultip)]); 
            else
                 eigvAd(:,idx) = linsolve([As-lmds*eye(n);ctranspose(Xs)], ...
                    [-Ad*Xs +  Xs*diag(eigW);zeros(nmultip,nmultip)]); 
            end
        end   
    end
    
    eigVal=dcdq(eigAs,eigval_d);
    eigVec=dcdq(eigvAs,eigvec_d);
end