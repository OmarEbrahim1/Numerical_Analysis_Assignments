function I = trap(func, a, b, n, varargin)
%TRAP: Composite trapezoidal rule quadrature.
%   I = TRAP(func, a, b) computes the integral of a function "func"
%   between "a" and "b" using the composite trapezoidal rule with a
%   default of 100 segments.
%
%   I = TRAP(func, a, b, n) computes the integral using "n" segments.
%
%   I = TRAP(func, a, b, n, p1, p2, ...) evaluates "func" with
%   additional parameters "p1", "p2", etc.
%
%   Example: Integrate f(x) = x^2 from 0 to 1 using 50 segments.
%       >> f = @(x) x.^2;
%       >> I = trap(f, 0, 1, 50)
%   
%   See also QUAD, QUADL, QUADGK, DBLQUAD, TRIPLEQUAD.

% Check for minimum number of input arguments
if nargin < 2
    error('At least two input arguments are required.');
end

% Check for the correctness of the bounds
if b <= a
    error('The upper bound must be greater than the lower bound.');
end

% Set default values
if nargin < 4 || isempty(n)
    n = 100;
end

% Compute segment size
h = (b - a) / n;

% Evaluate function at endpoints
s = func(a, varargin{:}) + func(b, varargin{:});

% Evaluate function at interior points
for i = 1:n-1
    x = a + i*h;
    s = s + 2*func(x, varargin{:});
end

% Compute final result
I = h * s / 2;

end
