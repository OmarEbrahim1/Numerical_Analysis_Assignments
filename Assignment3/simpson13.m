function I = simpson13(f, a, b, n)
% SIMPSON13  Numerically estimate the definite integral of a function
%            using Simpson's 1/3 rule.
%
%   I = SIMPSON13(F, A, B, N) estimates the definite integral of function F
%   over the interval [A, B] using Simpson's 1/3 rule with N subintervals.
%
%   The input function F must be defined as a function handle. It can accept
%   a scalar input and should return a scalar output.
%
%   The input arguments A and B are the lower and upper limits of integration,
%   respectively. They must be finite scalars.
%
%   The input argument N is the number of subintervals used to estimate the
%   integral. N must be an even integer greater than or equal to 2.
%
%   The function returns the estimated value of the definite integral of F
%   over [A, B] using Simpson's 1/3 rule.
%
%   Example:
%      f = @(x) x.^2;   % Define function
%      a = 0;           % Integration limit
%      b = 1;
%      n = 4;           % Number of intervals (must be even)
%      I = simpson13(f, a, b, n)   % Estimate integral of f between a and b
%
%   See also QUAD, QUADL, QUADGK.

% Check if n is even
n = n+1;
if mod(n, 2) ~= 0
    error('n must be an even integer greater than or equal to 2.')
end

% Calculate the interval size and x values
h = (b-a)/n;
x = a:h:b;

% Calculate the y values
y = f(x);

% Calculate the integral using Simpson's 1/3 rule
I = h/3 * (y(1) + 4*sum(y(2:2:end-1)) + 2*sum(y(3:2:end-2)) + y(end));

end
