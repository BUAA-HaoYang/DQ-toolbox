function an = unit_elem(a)
% UNIT_ELEM    Divides a dual complex by its own modulus.
% The result is a dual complex vector/matrix with unit modulus.

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.
b=abs(a);
iszero_a=a==0;
an(iszero_a)=0;
an(~iszero_a)=a(~iszero_a)./b(~iszero_a);

end


