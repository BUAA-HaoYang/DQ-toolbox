function Z = power(X, Y)
% .^   Array power.
% (Dual complex number overloading of standard Matlab function.)
% It temporarily supports the scenario where exponents are real numbers.
% Due to the particularity of the dual part of dual complex numbers, this 
% function may yield incorrect results when the standard part is equal to 
% zero.

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.

narginchk(2, 2), nargoutchk(0, 1)
if isa(X,'dc')&&isreal(Y)

    Z.s = X.s.^Y;
    Z.d = Y.*X.s.^(Y-1).*X.d;
    Z=dc(Z.s,Z.d);
else
    warning('The value of the exponent that is currently not supported,return the original value of the dual complex number.');
    Z=X;
end

