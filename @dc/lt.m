function r = lt(a, b)
% <  Less than
% (Dual complex number overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.

narginchk(2, 2), nargoutchk(0, 1)
if isa(a,'dc')&&isa(b,'dc')
    as=a.s;
    ad=a.d;
    bs=b.s;
    bd=b.d;
    if isreal(as)&&isreal(ad)&&isreal(bs)&&isreal(bd)
        r=(as<bs) | (as==bs & ad<bd);
    else
        r=real(a)<real(b);
    end
elseif isa(a,'dc')&&isnumeric(b)
    r=a<dc(b);
elseif isnumeric(a)&&isa(b,'dc')
    r=dc(a)<b;
end

end
