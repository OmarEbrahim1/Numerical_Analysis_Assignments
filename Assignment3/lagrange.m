function yint = lagrange(x,y,xx, order)
%LAGRANGE: Lagrange interpolating polynomial
%   yint = lagrange(x,y,xx, order) uses (order - 1) Lagrange interpolating
%   polynomial based on (order - 1) to determine a value of the dependent
%   variable (yint) at a given value of the independent variable, xx.

% Check input sizes
if ~isequal(size(x), size(y))
    error('x and y must be the same size.');
end

% Check for duplicate values of x
if length(unique(x)) ~= length(x)
    error('x values must be unique.');
end

% Number of data points
n = order;

% Initialize interpolated value
yint = zeros(size(xx));

% Loop over each value of xx
for k = 1:length(xx)
    % Initialize sum for Lagrange polynomial
    s = 0;
    
    % Loop over each data point
    for i = 1:n
        % Initialize product for Lagrange polynomial
        product = y(i);
        
        % Loop over each data point (except i)
        for j = 1:n
            if i ~= j
                % Update product with next term of Lagrange polynomial
                product = product .* (xx(k) - x(j)) ./ (x(i) - x(j));
            end
        end
        
        % Add current term of Lagrange polynomial to sum
        s = s + product;
    end
    
    % Store interpolated value for current xx
    yint(k) = s;
end

end
