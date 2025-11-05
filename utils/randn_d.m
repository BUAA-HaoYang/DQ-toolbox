function x = randn_d(m,n,noiselevel,type)
% RANDN_D  Create different types of dual random matrices.
%
% Syntax:
%   x = randn_d(m, n)                % Default: dual number matrix ('dn')
%                                      with noiselevel = 1
%   x = randn_d(m, n, noiselevel)    % Specifies noise level;
%                                      default type = 'dn'
%   x = randn_d(m, n, noiselevel, type)  % Specifies both noise level and
%                                          matrix type
%
% Inputs:
%   m           - Number of rows of the dual matrix (positive integer) 
%   n           - Number of columns of the dual matrix (positive integer) 
%   noiselevel  - (Optional) Scaling factor for the random values (controls
%                 "noise intensity").
%                 Default: 1 (no additional scaling).
%   type        - (Optional) Specifies the type of dual matrix.
%                 Default: 'dn' (dual number). 
%                 Valid options: 
%                 - 'dn': Dual number matrix (standard/dual parts are 
%                    real-valued random matrices) 
%                 - 'dc': Dual complex matrix (standard/dual parts are 
%                    complex-valued random matrices) 
%                 - 'dq': Dual quaternion matrix (standard/dual parts 
%                    are quaternion random matrices)
%
% Outputs:
%   x           - m-by-n dual random matrix of the specified type.
%                 Its standard part (x.s) and dual part (x.d) are both
%                 m-by-n matrices with entries sampled from a normal
%                 distribution (randn), scaled by 'noiselevel'.
%
% Details:
%   - For 'dn' (dual number): x.s and x.d are real-valued matrices
%     (randn(m,n) * noiselevel). 
%   - For 'dc' (dual complex): x.s and x.d are complex-valued matrices, 
%     where both real and imaginary parts are sampled from randn 
%     (i.e., randn(m,n) + 1i*randn(m,n)) and scaled by noiselevel.
%   - For 'dq' (dual quaternion): x.s and x.d are quaternion matrices with
%     four real components, each sampled from randn(m,n) and scaled by 
%     noiselevel (constructed via quaternion(...) function).

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.
    if nargin < 3
        noiselevel = 1;
    end
    if nargin < 4
         type = 'dn';
    end
    
    switch lower(type)
        case 'dn' 
            x.s = noiselevel*(randn(m,n)); 
            x.d = noiselevel*(randn(m,n)); 
            x = dc(x.s,x.d);
        case 'dc' 
            x.s = noiselevel*(randn(m,n)+1i*randn(m,n)); 
            x.d = noiselevel*(randn(m,n)+1i*randn(m,n)); 
            x = dc(x.s,x.d);
        case 'dq' 
            x.s = noiselevel*(quaternion(randn(m,n),randn(m,n),randn(m,n),randn(m,n))); 
            x.d = noiselevel*(quaternion(randn(m,n),randn(m,n),randn(m,n),randn(m,n))); 
            x = dq(x.s,x.d);
    end
 
     
end