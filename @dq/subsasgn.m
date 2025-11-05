function r = subsasgn(a, ss, b)
% SUBSASGN Subscripted assignment.
% (Dual quaternion overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.

switch ss.type
    case '()'
        if length(ss) ~= 1
            error('Multiple levels of subscripting are not supported for dual quaternion.')
        end

        if ~isa(a, 'dq')

            error('Left side must be a dual quaternion if right side is a dual quaternion.')
        end

        if ~isa(b, 'dq')

            if isempty(b)
                as = a.s; as(ss.subs{:}) = [];
                ad = a.d; ad(ss.subs{:}) = [];
                r = dq(as,ad);
                return
            end
            if isa(b,'quaternion')||isa(b,'dq')
                a=dq(a);
                r=subsasgn(a, ss, b);
                return
            end

            if isnumeric(b)
                b = dq(b);
            else
                error(['Cannot handle right-hand argument of class ', ...
                    class(b)]);
            end

        end
        as = a.s; as(ss.subs{:}) = b.s;
        ad = a.d; ad(ss.subs{:}) = b.d;
        r = dq(as,ad);
    case '{}'
        error('Cell array indexing is not valid for dual quaternions.')
    case '.'
        switch ss.subs
            case {'s', 'standard'}
                if isempty(b)
                    r=dq(zeros(size(a.d)),a.d);
                elseif isscalar(b)&&(isnumeric(b)||isa(b,'quaternion'))
                    r=dq(b*ones(size(a.d)),a.d);
                elseif isnumeric(b)||isa(b,'quaternion')
                    if any(size(b)~=size(a.d))
                        error('Standard part and dual part must have the same size');
                    else
                        r=dq(b,a.d);
                    end
                else
                    error(['Cannot handle right-hand argument of class ', ...
                        class(b)])
                end
            case {'d', 'dual'}
                if isempty(b)
                    r=dq(a.s,zeros(size(a.s)));
                elseif isscalar(b)&&(isnumeric(b)||isa(b,'quaternion'))
                    r=dq(a.s,b*ones(size(a.s)));
                elseif isnumeric(b)||isa(b,'quaternion')
                    if any(size(b)~=size(a.s))
                        error('Standard part and dual part must have the same size');
                    else
                        r=dq(a.s,b);
                    end
                else
                    error(['Cannot handle right-hand argument of class ', ...
                        class(b)])
                end
            otherwise
                error('Dual quaternion number subsasgn received an invalid subscripting type.')
        end

end

