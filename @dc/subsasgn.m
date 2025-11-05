function r = subsasgn(a, ss, b)
% SUBSASGN Subscripted assignment.
% (Dual complex number overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.

switch ss.type
    case '()'
        if length(ss) ~= 1
            error('Multiple levels of subscripting are not supported for dual complex numbers.')
        end

        if ~isa(a, 'dc')

            error('Left side must be a dual complex number if right side is a dual complex number.')
        end

        if ~isa(b, 'dc')

            if isempty(b)
                as = a.s; as(ss.subs{:}) = [];
                ad = a.d; ad(ss.subs{:}) = [];
                r = dc(as,ad);
                return
            end
            if isa(b,'quaternion')||isa(b,'dq')
                a=dq(a);
                r=subsasgn(a, ss, b);
                return
            end

            if isnumeric(b)
                b = dc(b);
            else
                error(['Cannot handle right-hand argument of class ', ...
                    class(b)]);
            end

        end
        as = a.s; as(ss.subs{:}) = b.s;
        ad = a.d; ad(ss.subs{:}) = b.d;
        r = dc(as,ad);
    case '{}'
        error('Cell array indexing is not valid for dual complex numbers.')
    case '.'
        switch ss.subs
            case {'s', 'standard'}
                if isempty(b)
                    r=dc(zeros(size(a.d)),a.d);
                elseif isscalar(b)&&isnumeric(b)
                    r=dc(b*ones(size(a.d)),a.d);
                elseif isnumeric(b)
                    if any(size(b)~=size(a.d))
                        error('Standard part and dual part must have the same size');
                    else
                        r=dc(b,a.d);
                    end
                elseif isa(b,'quaternion')
                    a=dq(a);
                    r=subsasgn(a, ss, b);
                    return
                else
                    error(['Cannot handle right-hand argument of class ', ...
                        class(b)])
                end
            case {'d', 'dual'}
                if isempty(b)
                    r=dc(a.s,zeros(size(a.s)));
                elseif isscalar(b)&&isnumeric(b)
                    r=dc(a.s,b*ones(size(a.s)));
                elseif isnumeric(b)
                    if any(size(b)~=size(a.s))
                        error('Standard part and dual part must have the same size');
                    else
                        r=dc(a.s,b);
                    end
                elseif isa(b,'quaternion')
                    a=dq(a);
                    r=subsasgn(a, ss, b);
                    return
                else
                    error(['Cannot handle right-hand argument of class ', ...
                        class(b)])
                end
            otherwise
                error('Dual complex number subsasgn received an invalid subscripting type.')
        end

end

