clear
clc
% This script demonstrates the core functionalities of the DQ Toolbox 
% related to dual complex matrices.
%% Constructions and operations of dual complex matrices
as = [1+1i, 2; 1, 1];  
ad = [1, 2; 1, 1];    

% Construct a dual complex matrix 'a' using dc() constructor, combining 
% standard part (as) and dual part (ad)
a = dc(as, ad);

% Construct dual complex matrices using different methods
b11 = dc(1, 1);      
b12 = dcdq(1, 1);     % Construction via dcdq()
b21 = dc(1);         
b22 = dc(b21);        
b = [b11, b12; b21, b22];

% Perform basic arithmetic operations on dual complex matrices
plus = a + b;         % Plus 
minus = a - b;        % Minus
mtimes = a * b;       % Matrix multiplication 
mrdivide = a / a(1);  % Matrix right division
times = a .* b;       % Element-wise multiplication
rdivide = a ./ b;     % Element-wise right division
ctranspose = a';      % Conjugate transpose of dual complex matrix a

% Matrix indexing and concatenation operations
subs1 = a(:, 1);      % Extract the first column of dual complex matrix a
subs2 = a(1, 1);      % Extract the (1,1) element of dual complex matrix a
vertical = [a; b];    % Vertically concatenate a and b (stack rows)
horizontal = [a, b];  % Horizontally concatenate a and b (stack columns)

% Compute norms of dual complex matrix a using different norms
normfro = norm(a, 'fro');  % Frobenius norm of a 
normFR = norm(a, 'FR');    % 'FR' norm of a

% Construct special dual complex matrices of size 2x2
eyedc = eye_d(2, 2, 'dc');   % 2x2 dual complex identity matrix 
onesdc = ones_d(2, 2, 'dc'); % 2x2 dual complex matrix of ones 
randndn = randn_d(2, 2, 1, 'dn'); % 2x2 dual number random matrix (noise level = 1)
randndc = randn_d(2, 2, 1, 'dc'); % 2x2 dual complex random matrix (noise level = 1)
zerosdc = zeros_d(2, 2, 'dc'); % 2x2 dual complex zero matrix 

%% Compute the eigenvalue of a Hermitian dual complex matrix
% Construct a Hermitian dual complex matrix A 
A = a' + a;  
% 1. Use the power method (pm_d)
u = randn_d(2, 1, 1, 'dc');  
maxiter = 1000;              
rtol = 1e-8;                 
% Compute the eigenvalues of Hermitian matrices by the power method
[u, lambda, k, res] = pm_d(A, u, maxiter, rtol);
% Plot the residual history over iterations to visualize convergence
iteration = 1:k;             
reshist = res(1:k);          
tiledlayout(1, 1);          
ax1 = nexttile;              
semilogy(iteration, reshist, 'b-', 'LineWidth', 2);  
xlabel('iteration');         
ylabel('Res');               
set(gca, 'FontSize', 15);  

% 2. Using SMM (smm_d)
[eigVal, eigVec] = smm_d(A, 'dc');  % 'dc' specifies dual complex type
error = verifyeigenpair_d(A,eigVal,eigVec);% Computes the error of eigenpairs
