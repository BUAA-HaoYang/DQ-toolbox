function disp(a)
% DISP    Display array.
% (Dual complex number overloading of standard Matlab function.)

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.
narginchk(1, 1);
S = blanks(5);  %  Indentation for alignment

if isempty(a)
    % Handle empty dual complex numbers.
    s = size(a);
    if all(s == 0)
        S = [S '[] dual complex'];
    else
        S = [S 'empty dual complex array:'];
        for k = 1:length(s)
            S = [S, num2str(s(k))];
            if k ~= length(s)
                S = [S, '×'];
            end
        end
    end
elseif isscalar(a)
    % Handle scalar dual complex numbers: display as a + bε.
    as_str = num2str(a.s);% String representation of standard part
    ad_str = num2str(a.d);% String representation of dual part
    S = [S as_str ' + (' ad_str ')ε'];
else
    % Handle dual complex arrays: display size and type.
    s = size(a);
    for k = 1:length(s)
        S = [S, num2str(s(k))];
        if k ~= length(s)
            S = [S, '×'];% Multiplication symbol for dimensions
        end
    end
    S = [S ' dual complex array'];
    % % Display component type if not double.
    % if ~isa(a.s, 'double')
    %     S = [S, '(', class(a.s), 'type)'];
    % end
end

disp(S);
end
