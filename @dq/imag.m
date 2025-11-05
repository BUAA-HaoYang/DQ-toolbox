function p = imag(q)
% IMAG   Imaginary part of a dual quaternion.
% (Dual quaternion overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.

narginchk(1, 1), nargoutchk(0, 1)

p=dq(imagq(q.s),imagq(q.d));

end

