function detA = det(A)
% DET    Determinant.
% (Dual complex number overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.
narginchk(1, 1), nargoutchk(0, 1)

[m,n] = size(A);

if m ~= n
    error('Matrix must be square.');
end

As=A.s;
Ad=A.d;
detAd = 0;
for i = 1:m
    detAd = detAd + det([As(:,1:i-1), Ad(:,i),As(:,i+1:r)]);
end
detA=dc(det(As),detAd);

end

