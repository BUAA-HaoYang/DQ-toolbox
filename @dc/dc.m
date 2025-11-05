% DQ Toolbox for Matlab 
% Dual complex number class definition and constructor method/function.

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.
classdef (InferiorClasses = {?sym}) dc
    % dc defines the dual complex number class a+bε, where a and b are
    % complex numbers/vectors/matrices and ε² = 0.
    properties (SetAccess = 'private')
        s = [];  % Standard part
        d = [];  % Dual part(coefficient of ε)
    end

    methods
        function a = dc(a1,a2,a3,a4)
            % Construct dual complex numbers from components. 
            % Supported usages:
            % No argument    * returns an empty dual complex number
            % One argument   * If input is a dual complex number, returns 
            %                  it unchanged.
            %                * If input is a dual quaternion, returns it 
            %                  excluding its j-component and k-component.
            %                * If input is a complex number, assigns it as 
            %                  the standard part and sets the dual part to 
            %                  zero (with the same size/type).
            % Two arguments  * If a1 and a2 are both complex numbers, 
            %                  assigns a1 as standard part and a2 as dual 
            %                  part. 
            %                * If one of a1 and a2 is a complex number, the
            %                  other is a quaternion, discard the
            %                  j-components and k-components of that
            %                  quaternion so that it becomes a complex
            %                  number, then assigns a1 as standard part and
            %                  a2 as dual part.
            % Four arguments * assigns arguments as real part of standard
            %                  part, imaginary part of standard part, real
            %                  part of dual part, imaginary part of dual
            %                  part respectively.
            % Throws an error if the number of inputs is invalid.
            nargoutchk(0, 1);
            switch nargin
                case 0  
                    % Construct an empty dual complex number.
                    a.s = [];
                    a.d = [];
                case 1  
                    if isempty(a1)
                        a=dc();
                    elseif isa(a1,'dc')  
                        % Returns it if input is a dual complex number.
                        a=a1;
                    elseif isa(a1,'dq')
                        % If input is a dual quaternion, returns it 
                        % excluding its j-component and k-component.
                        a.s=a1.s.w+a1.s.x*i;
                        a.d=a1.d.w+a1.d.x*i;
                    elseif isnumeric(a1)
                        % If input is a complex number, it becomes the 
                        % standard part, with a zero matrix of the same 
                        % dimension as the dual part.
                        z=zeros(size(a1),'like', a1);
                        a.s=a1;a.d=z;
                    else
                        error('Unsupported input type: %s', class(a1));
                    end
                case 2
                    % if isscalar(a1)||isscalar(a2)
                    %     if ~isscalar(a1)
                    %         a2=a2*ones(size(a1),'like', a1);
                    %     else
                    %         a1=a1*ones(size(a2),'like', a2);
                    %     end
                    %     a.s=a1;
                    %     a.d=a2;
                    % end
                    
                    if isempty(a1)||isempty(a2)
                        if ~isempty(a1)
                            a=dc(a1);
                        else
                            z=zeros(size(a2),'like', a2);
                            a=dc(z,a2);
                        end
                    else
                        if any(size(a1)~=size(a2))
                            error('Standard part and dual part must have the same size');
                        else
                            if isnumeric(a1)&&isnumeric(a2)
                                % assigns a1 as standard part and a2 as dual
                                % part.
                                a.s=a1;
                                a.d=a2;
                            elseif (isa(a1,'quaternion')&&isnumeric(a2))
                                %If one of a1 and a2 is a complex number, the
                                % other is a quaternion, discard the
                                % j-components and k-components of that
                                % quaternion so that it becomes a complex
                                % number, then assigns a1 as standard part and
                                % a2 as dual part.
                                a.s=a1.w+a1.x*i;
                                a.d=a2;
                            elseif (isa(a2,'quaternion')&&isnumeric(a1))
                                a.s=a1;
                                a.d=a2.w+a2.x*i;
                            else
                                error('Unsupported input types.');
                            end
                        end
                    end
                case 4  
                    % assigns arguments as real part of standard part, 
                    % imaginary part of standard part, real part of dual 
                    % part, imaginary part of dual part respectively.
                    as=complex(a1,a2);
                    ad=complex(a3,a4);
                    if any(size(as)~=size(ad))
                        error('Standard part and dual part must have the same size.');
                    else
                        a.s=as;
                        a.d=ad;
                    end
                otherwise
                    error('Invalid number of input arguments');
            end
        end

        function n = numArgumentsFromSubscript(~,~,~)
            % Element counting for supporting array subscript indexing.
            n = 1;
        end

        function dump(d)
            % For debugging: display internal structure.
            a=inputname(1);
            if ~isempty(a), a= [a,'.']; end
            disp([a,'s: [', num2str(size(d.s)), '] ',class(d.s)]);
            disp([a,'d: [', num2str(size(d.d)), '] ',class(d.d)]);
        end
    end

    methods (Static = true)
        % Create an empty dual number array.
        function d=empty(varargin)
            e=double.empty(varargin{:});
            d=dc(e,e);
        end
    end
end
