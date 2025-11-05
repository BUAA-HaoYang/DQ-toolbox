function a = normdq(q)
% NORMDQ Norm of a dual quaternion, the sum of the squares of the components.
% The norm is also equal to the product of a dual quaternion with its conjugate.

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.
narginchk(1, 1), nargoutchk(0, 1) 
qs=q.s;
qd=q.d;
a=q;
a.s=normq(qs);
a.d=(qs.w.*qd.w+qs.x.*qd.x+qs.y.*qd.y+qs.z.*qd.z)*2;

end
