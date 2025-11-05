function a=dcdq(as,ad)
% DCDQ  Create a dual complex number or dual quaternion. This function 
%       unifies the construction of dual algebraic structures, 
%       automatically determining whether to return a dual complex (dc) or 
%       dual quaternion (dq) based on input types and count.
%
% Syntax:
%   a = dcdq()
%   a = dcdq(as)
%   a = dcdq(as,ad)
%
% Supported usages:
% -No argument    * returns an empty dual quaternion
% -One argument   * If input is a dual complex number or a dual quaternion,
%                   returns it unchanged.
%                 * If input is a complex number, assigns it as the 
%                   standard part and sets the dual part to zero (with the 
%                   same size). Returns a dual complex number.
%                 * If input is a quaternion, assigns it as the standard
%                   part and sets the dual part to zero (with the same
%                   size), returns a dual quaternion.
% -Two arguments  * If as and ad are both complex numbers, assigns as as
%                   standard part and ad as dual part. Returns a dual
%                   complex number.
%                 * If one of as and ad is a complex number, the
%                   other is a quaternion, assigns as as standard part and
%                   ad as dual part. Returns a dual quaternion.
% Throws an error if the number of inputs is invalid.

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.
nargoutchk(0, 1);
switch nargin
    case 0
        a.s = [];
        a.d = [];
        a = dq(a.s,a.d);
    case 1
        if isa(as,'dc')||isnumeric(as)
            a = dc(as);
        elseif isa(as,'dq')||isa(as,'quaternion')
            a = dq(as);
        else
            error('Unsupported input type: %s', class(as));
        end
    case 2
        if any(size(as)~=size(ad))
            error('Standard part and dual part must have the same size');
        else
            if isnumeric(as)&&isnumeric(ad)
                a = dc(as,ad);
            elseif isa(as,'quaternion')&&isa(ad,'quaternion')
                a = dq(as,ad);
            elseif (isa(as,'quaternion')&&isnumeric(ad))||(isa(ad,'quaternion')&&isnumeric(as))
                a = dq(as,ad);
            else
                error('Unsupported input type: %s,%s', class(as),class(ad));
            end
        end
    otherwise
        error('Invalid number of input arguments')
end

end
