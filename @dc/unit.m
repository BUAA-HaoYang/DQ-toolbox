function r = unit(a)
% Unit dual complex number.

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.
narginchk(1, 1), nargoutchk(0, 1)

nm_a = norm(a);
if nm_a > 0
    r=a/nm_a;
else
    r=dc(zeros(size(a.s)),zeros(size(a.d)));
end

end


