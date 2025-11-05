function b = subsref(a, ss)
% SUBSREF Subscripted reference.
% (Dual quaternion overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.

if ~isa(a, 'dq')
    error('subsref:invalid input');
end
if isscalar(ss)
    switch ss.type
        case '()'  % Array indexing (e.g., d(1,2))
            % Index both standard part and dual part simultaneously.
            b = dq(a.s(ss.subs{:}), a.d(ss.subs{:}));
        case '{}'  % Cell indexing is not supported.
            error('Dual quaternions do not support cell indexing.');
        case '.'   % Property access (e.g., a.s, d.real)
            switch ss.subs
                case {'s', 'standard'}   
                    b = a.s;
                case {'d', 'dual'}    
                    b = a.d;
                case 'full'         
                    b = a;
                case 'w'
                    b=dc(a.s.w,a.d.w);
                case 'x'
                    b=dc(a.s.x,a.d.x);
                case 'y'
                    b=dc(a.s.y,a.d.y);
                case 'z'
                    b=dc(a.s.z,a.d.z);
                otherwise
                    error('Invalid property: .%s', ss.subs);
            end
        otherwise
            error('Invalid indexing type: %s', ss.type);
    end
else 
    % Handle multi-level indexing by recursively applying subsref.
    b=subsref(a,ss(1));
    b=subsref(b, ss(2:end));
end
end
