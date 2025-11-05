% Dual Quaternion Toolbox for Matlab
% Dual Quaternion class definition and constructor method/function.

% Copyright © 2025 Chunfeng Cui,Hao Yang and Tao Sang.
classdef (InferiorClasses = {?quaternion, ?sym}) dq
    % Dual quaternion class definition
    properties (SetAccess = 'private', Hidden = false)
        s = quaternion();  % Standard part
        d = quaternion();  % Dual part
    end

    methods
        function a = dq(s0,s1,s2,s3,d0,d1,d2,d3)
            % Constructor for dual quaternion objects.
            %
            % Supported usages:
            % No argument      * returns an empty dual quaternion scalar,
            %                    vector, or matrix.
            % One argument     * If input is a dual quaternion, returns it
            %                    unchanged.
            %                  * If input is a quaternion, assigns it as
            %                    the standard part and set the dual part to
            %                    zero (with the same size/type).
            %                  * If input is numeric, logical, or symbolic,
            %                    convert it to a quaternion and assign it
            %                    to the standard part; dual part is zero.
            %                  * If input is a char/string, attempt to
            %                    create a symbolic quaternion variable.
            % Two arguments    * standard part + dual part. If inputs are
            %                    not quaternions, they will be converted.
            %                    Both parts must have the same size.
            % Eight arguments  * specify a full dual quaternion (s0, s1,
            %                    s2, s3 for standard; d0, d1, d2, d3 for
            %                    dual).
            % Throws an error if the number of inputs is invalid.
            nargoutchk(0, 1)

            switch nargin
                case 0 % Construct an empty dual quaternion.
                    a.s = quaternion();
                    a.d = quaternion();

                case 1
                    if isa(s0, 'dq')
                        % Input is already a dual quaternion, 
                        % return unchanged
                        a = s0;
                    elseif isa(s0,'dc')
                        a.s=quaternion(real(s0.s),imag(s0.s),zeros(size(s0.s)),zeros(size(s0.s)));
                        a.d=quaternion(real(s0.d),imag(s0.d),zeros(size(s0.s)),zeros(size(s0.s)));
                        %it may be not right 
                    elseif isa(s0, 'quaternion')
                        % Input is a quaternion, set as standard part
                        % dual part = 0
                        a.s = s0;
                        a.d = quaternion(zeros(size(s0), 'like', s0.w));

                    elseif isnumeric(s0) || islogical(s0) || isa(s0, 'sym')
                        % When input is numeric, logical, or symbolic, 
                        % convert it to quaternion
                        a.s = quaternion(real(s0),imag(s0),zeros(size(s0)),zeros(size(s0)));
                        a.d = quaternion(zeros(size(s0), 'like', s0));

                    elseif ischar(s0) || isstring(s0)
                        if ischar(s0) && isrow(s0)
                            % Handle symbolic variable creation from string
                            if evalin('caller', ['exist(''', s0, ''', ''var'')'])
                                error([s0 ' already exists, please use the variable name directly.']);
                            else
                                evalin('caller', ['syms ', s0]); 
                                a.s = quaternion(evalin('caller', ['sym(''', s0, ''')']));
                                a.d = quaternion(zeros(1, 'like', a.s.w));
                            end
                        else
                            error('String input must be a single symbolic variable name (row vector).');
                        end

                    else
                        % Any other input type is not supported
                        error('Unsupported input type: %s', class(s0));
                    end

                case 2
                    % Two arguments: interpret as standard part + dual part
                    % Convert to quaternion if necessary
                    if isnumeric(s0)&&isreal(s0)
                        s0 = quaternion(s0);
                    elseif ~isa(s0, 'quaternion')||(isnumeric(s0)&&~isreal(s0))
                        s0=quaternion(real(s0),imag(s0),zeros(size(s0)),zeros(size(s0)));
                    end
                    if isnumeric(s1)&&isreal(s1)
                        s1 = quaternion(s1);
                    elseif ~isa(s1, 'quaternion')||(isnumeric(s1)&&~isreal(s1))
                        s1=quaternion(real(s1),imag(s1),zeros(size(s1)),zeros(size(s1)));
                    end

                    % Both standard and dual parts must be the same size
                    if ~isequal(size(s0), size(s1))
                        error('Standard part and dual part must have the same size.');
                    end

                    a.s=s0;
                    a.d=s1;

                case 8
                    % Eight arguments: specify standard and dual parts 
                    % component-wise
                    a.s = quaternion(s0, s1, s2, s3);
                    a.d = quaternion(d0, d1, d2, d3);

                otherwise
                    error('Invalid number of arguments.');
            end
        end

        function n = numArgumentsFromSubscript(~, ~, ~)
            % Define how many output arguments are returned when
            % dualquaternion objects are indexed
            % Always return a single element/object
            n = 1;
        end

        function dump(a)
            % Display the contents of a dual quaternion
            st = inputname(1);
            if ~isempty(st)
                st = [st '.'];
            end
            fprintf('%sStandard part: ', st); disp(a.s);
            fprintf('%sDual part: ', st); disp(a.d);
        end
    end

    methods (Static = true) % Factory methods for creating dual quaternions
        function a = empty(varargin)
            % Create an empty dual quaternion array with specified size
            % Usage:
            %   dq.empty()        -> 0x0 empty
            %   dq.empty(m,n)    -> mxn empty array
            if nargin == 0
                sz = [0 0];
            else
                sz = [varargin{:}];
            end

            % If any dimension is zero, return a single empty object
            if any(sz == 0)
                a = dq();
            else
                % Otherwise create an array of zero-valued dual quaternions
                a = dq(...
                    quaternion(zeros(sz)), ...
                    quaternion(zeros(sz)) ...
                    );
            end
        end
    end
end
