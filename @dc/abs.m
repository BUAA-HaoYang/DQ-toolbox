function m = abs(a)
% ABS    Absolute value.
% (Dual complex number overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.

as = a.s;
ad = a.d;

% absolute value is a dual number
m.s = abs(as);
m.d = m.s;

pureQ_id = m.s<1e-20;
if ~isempty(pureQ_id)
    m.d(pureQ_id) = abs(ad(pureQ_id));
end

p = conj(as(~pureQ_id)).*ad(~pureQ_id) + conj(ad(~pureQ_id)).*as(~pureQ_id);
if ~isempty(p)
    m.d(~pureQ_id) = p/2./m.s(~pureQ_id);
end
m.d = reshape(m.d, size(m.s));
m=dc(m.s,m.d);
end