function r = unit(a)
% Unit dual quaternion.

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.
narginchk(1, 1), nargoutchk(0, 1)

nm_a = norm(a);
if nm_a > 0
    r=a/norm(a,'fro');
else
    r=dq(zeros(size(a.s)),zeros(size(a.d)));
end

end


