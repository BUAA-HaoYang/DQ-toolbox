function disp(q)
% DISP    Display array.
% (Dual quaternion overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.
narginchk(1, 1);
S = blanks(5);  %  Indentation for alignment

if isempty(q)
    % Handle empty dual quaternion.
    s = size(q);
    if all(s == 0)
        S = [S '[] dual quaternion'];
    else
        S = [S 'empty dual quaternion array:'];
        for k = 1:length(s)
            S = [S, num2str(s(k))];
            if k ~= length(s)
                S = [S, '×'];
            end
        end
    end
elseif isscalar(q)
    % Handle scalar dual quaternion
    as_str = char(q.s);% String representation of standard part
    ad_str = char(q.d);% String representation of dual part
    S = [S as_str ' + (' ad_str ')ε'];
else
    % Handle dual quaternion arrays: display size and type.
    s = size(q);
    for k = 1:length(s)
        S = [S, num2str(s(k))];
        if k ~= length(s)
            S = [S, '×'];% Multiplication symbol for dimensions
        end
    end
    S = [S ' dual quaternion array'];
end

disp(S);
end
