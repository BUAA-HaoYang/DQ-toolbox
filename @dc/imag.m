function p = imag(q)
% IMAG   Imaginary part of a dual complex number.
% (Dual complex number overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.

narginchk(1, 1), nargoutchk(0, 1)
p=q;
p.s=imag(q.s);
p.d=imag(q.d);
%p=dc(imag(q.s),imag(q.d));

end


