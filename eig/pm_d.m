function [u,lambda,k,res] = pm_d(A, u, maxiter, rtol)
% PM_D  Computing the dominant eigenvalue by power method
%
% Syntax:
%   [u,lambda,k,res] = pm_d(A, u, maxiter, rtol)
%   [u,lambda,k,res] = pm_d(A, u, maxiter)
%   [u,lambda,k,res] = pm_d(A, u)
%   [u,lambda,k,res] = pm_d(A)
%
% Inputs:
%   A        - Input matrix (typically a dual quaternion Hermitian matrix)
%   u        - Initial eigenvector estimate (optional; if empty, a random 
%              vector is generated)
%   maxiter  - Maximum number of iterations (default: 1000)
%   rtol     - Relative tolerance for convergence (default: 1e-10)
%
% Outputs:
%   u        - Estimated dominant eigenvector
%   lambda   - Estimated dominant eigenvalue 
%   k        - Number of iterations performed
%   res      - Sequence of residual norms across iterations, 2R-norm of 
%              A*u-u*lambda

% Copyright © 2025 Chunfeng Cui, Hao Yang, and Tao Sang.

% Reference:
%
% Cui, Chunfeng, and Liqun Qi, 'A power method for computing the dominant 
% eigenvalue of a dual quaternion Hermitian matrix', Journal of Scientific 
% Computing 100.1 (2024):21.
    if nargin < 2, u = []; end
    if nargin < 3, maxiter = 1000; end
    if nargin < 4, rtol = 1e-10; end
    
    if isempty(u)
       u = randn_d(length(A),1,1,class(A));
    end
    
    normAest = norm(A,'FR');
    Av = A*u;
    lambda.s = 0; lambda.d = 0;
    for k = 1:maxiter
        % Take a power method step and compute Rayleigh quotient
        u = Av/norm(Av,2);  
        Av = A*u;
        lambda = u'*Av; 
        % Compute the residual and check vs tolerance
        normr = norm(Av-u*lambda,'2R'); 
        res(k) = normr;
        if normr < rtol
            return;
        end 
    end

    %% If we get here, give a warning
    warning(sprintf('Power did not converge (rel resid %e after %d steps)', ...
        normr/normAest, maxiter));
end