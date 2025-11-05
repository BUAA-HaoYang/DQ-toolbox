function err = verifyeigenpair_d(A,eigA, eigvecA)
% VERIFYEIGENPAIR_D  Computes the error of eigenpairs (eigenvalues and 
%                    eigenvectors) for a dual matrix. Quantifies how well 
%                    each eigenpair (λ_i, x_i) satisfies the eigenvector 
%                    equation: A*x_i = x_i*λ_i.
% Syntax:
%   err = verifyeigenpair_d(A,eigA, eigvecA)
%
% Inputs:
%   A         - Dual matrix (e.g., dual complex or dual quaternion matrix) 
%               for which eigenpairs are verified
%   eigA      - Vector of eigenvalues corresponding to A 
%   eigvecA   - Matrix of eigenvectors corresponding to A (where each 
%               column is an eigenvector x_i)
%
% Outputs:
%   err       - Column vector of errors, where err(i) is the norm of the 
%               residual for the i-th eigenpair: 
%               err(i) = ||A*x_i - x_i*λ_i|| 
%               (using 'FR'-norm for dual matrices)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.
n = length(eigA.s);
err = zeros(n,1);
for i = 1:n
    lmdi=eigA(i);
    xi=eigvecA(:,i);
    % lmdi.s = eigA.s(i);
    % lmdi.d = eigA.d(i);
    % xi.s = eigvecA.s(:,i);
    % xi.d = eigvecA.d(:,i);
    err(i) = norm(A*xi-xi*lmdi,'FR');
end

end