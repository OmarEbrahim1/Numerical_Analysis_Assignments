function roots = bisection(func, lower_limit, upper_limit, iterations, convergance)
% Bisection: This function finds the roots using bisection
%
% Input Arguments:
% 
%     func: The function that will be analyzed
%     lower_limit: The lower limit of the interval to search for the root.
%     upper_limit: The upper limit of the interval to search for the root.
%     iterations (optional): The number of iterations to perform in the bisection method. The default value is 50. 
%     convergence (optional): The function stops once the upper - lower = convergance value. the default is 0.01
%
% 
% Outputs:
% 
%     roots: A 1x2 vector of the two endpoints of the interval that contains the root.

if nargin < 3
    error("At least 3 arguments required");
end

if nargin < 4
    iterations = 50;
end

if nargin < 5
    convergance = 0.01;
end

for i = 1:iterations
    if upper_limit - lower_limit <= convergance
        break
    else
        midpoint = (lower_limit + upper_limit) / 2;
        lower_middle = func(lower_limit);
        upper_middle = func(upper_limit);
        midpoint_value = func(midpoint);
        if lower_middle * midpoint_value < 0
            upper_limit = midpoint;
        elseif upper_middle * midpoint_value < 0
            lower_limit = midpoint;
        else
            disp("There are no roots!")
            break
        end
    end
end

roots = [lower_limit, upper_limit];
