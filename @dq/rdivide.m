function r = rdivide(a, b)
% ./  Right array divide.
% (Dual quaternion number overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.

narginchk(2, 2), nargoutchk(0, 1)

if isnumeric(b)||isa(b,'quaternion')
    r = a;
    r.s=a.s./b;
    r.d=a.d./b;
elseif isa(b,'dq')&&isa(a,'dq')
    if isscalar(b)&&(b.s~=0)
        r=a.*inv(b);
    elseif isscalar(b)&&(b.s==0)
        [m,n]=size(a);
        b=ones(m,n)*b;
        rs=a.s./b.s;
        as=a.s;ad=a.d;
        bd=b.d;
        rd=quaternion();
        iszeroa_s=abs(as)<1e-20;
        rd(~iszeroa_s)=0;
        rs(iszeroa_s)=ad(iszeroa_s)./bd;
        rd(iszeroa_s)=0;
        %       rd(~iszerob_s)=ad(~iszerob_s)./bs(~iszerob_s)-as(~iszerob_s)./bs(~iszerob_s).*bd(~iszerob_s)./bs(~iszerob_s);
        rd=reshape(rd,size(rs));
        r=dq(rs,rd);
    elseif all(size(a)==size(b))
        rs=a.s./b.s;
        as=a.s;ad=a.d;
        bs=b.s;bd=b.d;
        rd=quaternion();
        iszeroa_s=abs(as)<1e-20;
        iszerob_s=abs(bs)<1e-20;
        if ~isempty(iszerob_s)
            rd((~iszeroa_s)&iszerob_s)=0;
            rs(iszeroa_s&iszerob_s)=ad(iszeroa_s)./bd(iszeroa_s);
            rd(iszeroa_s&iszerob_s)=0;
        end
        rd(~iszerob_s)=ad(~iszerob_s)./bs(~iszerob_s)-as(~iszerob_s)./bs(~iszerob_s).*bd(~iszerob_s)./bs(~iszerob_s);
        rd=reshape(rd,size(rs));
        r=dq(rs,rd);
    else
        error('The size of the array is incompatible in function ./ /rdivide')
    end
elseif isa(b,'dq')||isa(a,'dq')
    a=dq(a);
    b=dq(b);
    r=a./b;
else
    warning('Unhandled parameter types in function ./ /rdivide')
end

end
