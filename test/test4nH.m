%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Overall Function:
% 1. Construct a 4x4 Laplacian matrix, which is a non-Hermitian DQM 
% 2. Solve the dominant eigenvalue of the matrix via the Power Method (PM)
% and Dual Complex Adjoint Matrix based Power Method (DCAM-PM)
% 3. Plot a semi-logarithmic curve of "iteration count vs. residual" to compare convergence performance
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear; 
clc;   

%% ====================== 1. Initialize Core Parameters ======================
n = 4;               % Dimension of the matrix (construct a 4x4 dual quaternion matrix)
kmax = 100;          % Maximum number of iterations
delta = 10^(-10);    % Convergence threshold (stops if residual < delta)
rng(2026);           % Set random number seed to 2026 for reproducible experimental results

%% ====================== 2. Generate Random Unit Dual Quaternions ======================
% randn_d: Custom function to generate random dual quaternions of specified dimensions ('dq' = dual quaternion)
% unit(): Custom function to normalize a dual quaternion (ensures its norm equals 1)
q12 = randn_d(1,1,1,'dq');  % Generate a 1x1 random dual quaternion q12
q12 = unit(q12);            % Normalize the dual quaternion q12

q23 = randn_d(1,1,1,'dq');  % Generate a random dual quaternion q23
q23 = unit(q23);            % Normalize the dual quaternion q23

q34 = randn_d(1,1,1,'dq');  % Generate a random dual quaternion q34
q34 = unit(q34);            % Normalize the dual quaternion q34

q41 = (q12*q23*q34)';       % Compute q41 as the conjugate transpose of the product q12*q23*q34

%% ====================== 3. Construct the Target Matrix A ======================
% Build a 4x4 Laplacian matrix using the generated unit dual quaternions
A = [1,   -q12,    0,     0;
     0,    1,    -q23,    0;
     0,    0,     1,    -q34;
    -q41,   0,     0,     1];

%% ====================== 4. Solve Eigenvalue via Standard Power Method (PM) ======================
v = randn_d(n,1,1,'dq');  % Generate an n×1 random dual quaternion vector as the initial iteration vector

% Call the Power Method function pm_d to solve for eigenvalues
% Outputs: u (eigenvector), lambda (eigenvalue), k (actual number of iterations), reshist (residual value)
[u, lambda, k, reshist] = pm_d(A, v, kmax, delta);

%% ====================== 5. Solve Eigenvalue via DCAM-PM ======================
% Call DCAM-PM function to solve eigenvalues 
% Inputs: Original matrix A, initial vector v, max iterations kmax, convergence threshold delta
% Outputs: u_adjoint (eigenvector from DCAM-PM), lambda_adjoint (eigenvalue), k_adjoint (actual iterations), reshist_adjoint (residual history)
A_adjoint=adjoint_d(A);
v_adjoint=adjoint_d(v);
v_adjoint=v_adjoint(:,1);
[u_adjoint, lambda_adjoint, k_adjoint, reshist_adjoint] = pm_d(A_adjoint, v_adjoint, kmax, delta);

%% ====================== 6. Organize Iteration Data ======================
iteration = 1:k;               % Iteration count vector for PM (1 to actual iterations k)
res = reshist(1:k);            % Residual history for standard PM (residuals of first k iterations)
iteration_adjoint = 1:k_adjoint;  % Iteration count vector for DCAM-PM
res_adjoint = reshist_adjoint(1:k_adjoint);  % Residual history for DCAM-PM


%% ====================== 8. Plot Semi-Logarithmic Curve ======================
semilogy(iteration, res, 'b-', iteration_adjoint, res_adjoint, 'r-', 'LineWidth', 2);
xlabel('iteration');           % Set x-axis label: Iteration count
ylabel('Res');                 % Set y-axis label: Residual
set(gca, 'FontSize', 15);      % Set font size of axes to 15
% Set legend with LaTeX interpreter (supports mathematical notation)
legend('PM', 'DCAM-PM', 'Interpreter', 'latex');