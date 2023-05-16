function [root, f_root, flag, iterations] = false_position(func, lower_limit, upper_limit, tolerance, max_iterations)
% false_position: This function finds the roots of a given function using the false position method.
%
% Input Arguments:
%
%     func: The function that will be analyzed
%     lower_limit: The lower limit of the interval to search for the root.
%     upper_limit: The upper limit of the interval to search for the root.
%     tolerance (optional): The tolerance for the solution. The default value is 1e-6.
%     max_iterations (optional): The maximum number of iterations to perform. The default value is 50.
%
% Output Arguments:
%
%     root: The estimated root of the function.
%     f_root: The value of the function at the estimated root.
%     flag: A flag that indicates the success or failure of the method.
%           0: Successful convergence.
%           1: Maximum number of iterations reached without convergence.
%     iterations: The number of iterations performed to find the root.

if nargin < 4
    tolerance = 1e-6;
end

if nargin < 5
    max_iterations = 50;
end

root = lower_limit;
f_root = feval(func, root);

flag = 0;
iterations = 0;

while (abs(f_root) > tolerance) && (iterations < max_iterations)
    iterations = iterations + 1;
    midpoint = (lower_limit * feval(func, upper_limit) - upper_limit * feval(func, lower_limit)) / (feval(func, upper_limit) - feval(func, lower_limit));
    f_midpoint = feval(func, midpoint);
    if f_midpoint * f_root < 0
        upper_limit = midpoint;
    else
        lower_limit = midpoint;
        root = midpoint;
        f_root = f_midpoint;
    end
end

if iterations >= max_iterations
    flag = 1;
end
end
