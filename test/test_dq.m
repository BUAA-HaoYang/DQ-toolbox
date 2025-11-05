clear
clc
%% Constructions and operations of dual quaternion matrices
as = quaternion([1.05, 0; 0, 1], zeros(2,2), ones(2,2), zeros(2,2));
ad = as;

% Construct dual quaternion matrices using different methods:
a = dq(as, ad);          % Construction via dq() 
b = dcdq(as, ad);        % Construction via dcdq() 
c = [a, b; a, b];

% Perform basic arithmetic operations on dual complex matrices
plus = a + b;         % Plus 
minus = a - b;        % Minus
mtimes = a * b;       % Matrix multiplication 
mrdivide = a / a(1);  % Matrix right division
times = a .* b;       % Element-wise multiplication
rdivide = a ./ b;     % Element-wise right division
ctranspose = a';      % Conjugate transpose of dual quaternion matrix a

% Matrix indexing and concatenation operations
subs1 = a(:, 1);      % Extract the first column of dual complex matrix a
subs2 = a(1, 1);      % Extract the (1,1) element of dual complex matrix a
vertical = [a; b];    % Vertically concatenate a and b (stack rows)
horizontal = [a, b];  % Horizontally concatenate a and b (stack columns)

% Compute norms of dual complex matrix a using different norms
normfro = norm(a, 'fro');  % Frobenius norm of a 
normFR = norm(a, 'FR');    % 'FR' norm of a

% Compute the dual complex adjoint matrix of dual quaternion matrix a 
adjoint = adjoint_d(a, 'dc');  

% Construct special dual quaternion matrices of size 2x2
eyedq = eye_d(2, 2, 'dq');    % 2x2 dual quaternion identity matrix
onesdq = ones_d(2, 2, 'dq');  % 2x2 dual quaternion matrix of ones
randndq = randn_d(2, 2, 1, 'dq');  % 2x2 random dual quaternion matrix (noise level = 1)
zerosdc = zeros_d(2, 2, 'dq');  % 2x2 dual quaternion zero matrix

%% Compute the eigenvalue of a Hermitian dual quaternion matrix
% Construct a Hermitian dual quaternion matrix A 
A = a' + a; 

% 1. Use the power method (pm_d) 
v = randn_d(2, 1, 1, 'dq');  % Random initial eigenvector 
maxiter = 1000;              % Maximum iterations for power method
rtol = 1e-8;                 % Convergence tolerance
t_start = tic;               % Start timer for power method
[u, lambda, k, res] = pm_d(A, v, maxiter, rtol);  % Apply power method
time_pm = toc(t_start);      % Record execution time for power method

% 2. Using SMM (smm_d)
t_start = tic;               % Start timer for SMM
[eigVal, eigVec] = smm_d(A, 'dq');  % Apply SMM method
time_smm = toc(t_start);     % Record execution time for SMM
error = verifyeigenpair_d(A,eigVal,eigVec);% Computes the error of eigenpairs

% 3. Using the dual complex adjoint matrix based power method
A_adjoint = adjoint_d(A, 'dc');  
v_adjoint = adjoint_d(v, 'dc');  
v_adjoint = v_adjoint(:, 1);     
t_start = tic;                   % Start timer
[u_adjoint, lambda_adjoint, k_adjoint, res_adjoint] = pm_d(A_adjoint, v_adjoint, maxiter, rtol);
time_pm_adjoint = toc(t_start);  % Record execution time

% 4. Using the dual complex adjoint matrix based SMM
t_start = tic;                   % Start timer for adjoint-based SMM
[eigVal_adjoint, eigVec_adjoint] = smm_d(A_adjoint, 'dc');
time_smm_adjoint = toc(t_start); % Record execution time

% Plot residual history to compare convergence of power method and adjoint-based power method
iteration = 1:k;                 
reshist = res(1:k);               
iteration_adjoint = 1:k_adjoint;  
reshist_adjoint = res_adjoint(1:k_adjoint); 
tiledlayout(1, 1);                
ax1 = nexttile;                   
% Plot residuals: blue for original power method, red for adjoint-based power method
semilogy(iteration, reshist, 'b-', iteration_adjoint, reshist_adjoint, 'r-', 'LineWidth', 2);
xlabel('iteration');              
ylabel('Res');                    
set(gca, 'FontSize', 15);         
legend('pm', 'adjoint-based pm');  