# DQ toolbox for Matlab 
DQ Toolbox is a MATLAB-based software package designed for efficient manipulation of dual complex numbers and dual quaternions—mathematical objects critical to fields like robotics, computer graphics, and mechanical engineering.  It is available for download at https://github.com/BUAA-HaoYang/DQ-toolbox.
If your work involves dual quaternions, the quaternion toolbox `qtfm` requires a separate download. It can be accessed at https://sourceforge.net/projects/qtfm/.

## Core Capabilities
The toolbox provides comprehensive support for two primary data types:  
### 1. Dual Complex Matrix (`dc`)
- A dual complex matrix is defined as $a=a_s+a_d \varepsilon$, where $a_s$(standard part) and $a_d$ (dual part) are complex matrices, and $\varepsilon^2 = 0$. $a_s$ and $a_d$ are of the same size. We can use `dc(as,ad)` or `dcdq(as,ad)` to construct a `dc`(i.e., a dual complex matrix).
- Supported operations: Addition, multiplication, division, norm calculation, ctranspose, unitization, indexing operations, and so on.
### 2. Dual Quaternion Matrix (`dq`)
- A dual quaternion matrix is defined as $a=a_s+a_d \varepsilon$, where $a_s$(standard part) and $a_d$ (dual part) are quaternion matrices, and $\varepsilon^2 = 0$. $a_s$ and $a_d$ are of the same size. We can use `dq(as,ad)` or `dcdq(as,ad)` to construct a `dq`(i.e., a dual quaternion matrix).
- Supported operations: Addition, multiplication, division, norm calculation, ctranspose, unitization, indexing operations, and so on.
## Quick Start
Here are some examples.
### 1. Working with Dual Complex Matrix (`dc`)
```matlab
as = [1+i, 2; 1, 1];
ad = [1, 2; 1, 1];

% Construct dual complex matrices
a = dc(as, ad);
b = dcdq(as, ad);

% Some basic arithmetic operations of dual complex matrices
plus = a + b;
minus = a - b;
mtimes = a * b;
mrdivide = a / a(1);
times = a .* b;
rdivide = a ./ b;
ctranspose = a';

% Matrix indexing and concatenation operations
subs1 = a(:, 1);
subs2 = a(1, 1);
vertical = [a; b];
horizontal = [a, b];
normfro = norm(a, 'fro');
normFR = norm(a, 'FR');

% Construct special dual complex matrices
eyedc = eye_d(2, 2, 'dc');
onesdc = ones_d(2, 2, 'dc');
randndn = randn_d(2, 2, 1, 'dn');
randndc = randn_d(2, 2, 1, 'dc');
zerosdc = zeros_d(2, 2, 'dc');

% Compute the eigenvalues of Hermitian matrices
A = a' + a;
u = randn_d(2, 1, 1, 'dc');
maxiter = 1000;
rtol = 1e-8;
% By the power method
[u, lambda, k, res] = pm_d(A, u, maxiter, rtol);
% By SMM
[eigVal, eigVec] = smm_d(A, 'dc');
```
### 2. Working with Dual Quaternion Matrix (`dq`)
```matlab
as = quaternion([1.05, 0; 0, 1], zeros(2, 2), ones(2, 2), zeros(2, 2));
ad = as;

% Construct dual quaternion matrices
a = dq(as, ad);
b = dcdq(as, ad);

% Some basic arithmetic operations of dual quaternion matrices
plus = a + b;
minus = a - b;
mtimes = a * b;
mrdivide = a / a(1);
times = a .* b;
rdivide = a ./ b;
ctranspose = a';
normfro = norm(a, 'fro');
normFR = norm(a, 'FR');

% Matrix indexing and concatenation operations
subs1 = a(:, 1);
subs2 = a(1, 1);
vertical = [a; b];
horizontal = [a, b];

% Construct special dual complex matrices
adjoint = adjoint(a, 'dc');
eyedq = eye_d(2, 2, 'dq');
onesdq = ones_d(2, 2, 'dq');
randndq = randn_d(2, 2, 1, 'dq');
zerosdc = zeros_d(2, 2, 'dq');

% Compute the eigenvalues of Hermitian matrices
% By the power method
A = a' + a;
v = randn_d(2, 1, 1, 'dq');
maxiter = 1000;
rtol = 1e-8;
[u, lambda, k, res] = pm_d(A, v, maxiter, rtol);

% By SMM
[eigVal, eigVec] = smm_d(A, 'dq');

% By the dual complex adjoint matrix
A_adjoint = adjoint(A, 'dc');
v_adjoint = adjoint(v, 'dc');
v_adjoint = v_adjoint(:, 1);
[u_adjoint, lambda_adjoint, k, res] = pm_d(A_adjoint, v_adjoint, maxiter, rtol);
[eigVal, eigVec] = smm_d(A_adjoint, 'dc');
```
For comprehensive details, please consult `test_dc.m` and `test_dq.m` which are located in the test folder.
## Matters needing attention
When basic arithmetic operations are performed between a dual complex matrix (`dc`) and a dual quaternion matrix (`dq`), errors may occur. This is because the results of basic arithmetic operations between a complex number and a quaternion in the `qtfm` package do not meet our expectations. See the example below:
```matlab
a = 1 + i;
b = quaternion(1, 1, 1, 0);
c = a + b,
d = a * b,
```
The result is 
```matlab
c = (2+1i) + 1 * I + 1 * J + 0 * K
d = (1+1i) + (1+1i) * I + (1+1i) * J + 0 * K
```
To prevent this error, it is recommended that basic arithmetic operations between a dual complex matrix (`dc`) and a dual quaternion matrix (`dq`) be avoided. If it cannot be avoided, `dq(a)` can be used to convert a (originally `dc`) into `dq` before performing the relevant calculations.
## Contact Information
To send feedback, code, documentation corrections or bug reports, please
send email to:

Chunfeng Cui: &ensp;  chunfengcui@buaa.edu.cn   
Hao Yang: &ensp;&ensp;&ensp;&ensp;&ensp;  uyh@buaa.edu.cn    
Tao Sang: &ensp;&ensp;&ensp;&ensp;&ensp;&ensp;sangtao@buaa.edu.cn
