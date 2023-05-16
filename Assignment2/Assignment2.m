%% Question 1
clear; clc
convergance = 0.01; upper_height = 0.5; lower_height = 0; iterations = 30;

eq = @(h) (4067*pi)/80 - (4067*acos((40*h)/7 - 1))/80 ...
    + 1660*(- h^2 + (7*h)/20)^(1/2)*(h - 7/40) - 5535031457702571/35184372088832;

eqbisect = bisection(eq, lower_height, upper_height, iterations);
fprintf("%.4f bisection\n", eqbisect(1))
eqfalse = false_position(eq, lower_height, upper_height, convergance, iterations);
fprintf("%.4f false position\n", eqfalse)

%% Question 2
% Clearing the command window and workspace
clear; clc;

% Constants for the equation
H = 39; % height of water in cm
g = 9.81; % acceleration due to gravity
L = 76; % length of pipe in cm
d = 0.1; % diameter of pipe in cm
Lelbow = 30 * d; % length of elbow in cm
Lvalve = 8 * d; % length of valve in cm
K = 0.5; % friction factor
f = 0.025; % minor losses factor
A = (pi * d^2) / 4; % area of pipe in cm^2

% Tolerance and maximum iteration values
tol = 0.0001;
max_iter = 30;

% Defining the equation using symbolic variables
syms V;
eq = @(V) f * (((L + H) / d) + (Lelbow / d) + (Lvalve / d)) * ((V.^2) / 2) + K * ((V.^2) / 2) + ((V.^2) / 2) - g * H;

% Derivative of the equation
archimedes_equation_derivative = matlabFunction(diff(eq(V)));

% Initial guess for the velocity
V0 = 0.1;

% Initializing iteration and x values
iter = 0;
velocity = V0;

% Newton-Raphson method
while (iter < max_iter)
f_x = eq(velocity);
f_prime_x = archimedes_equation_derivative(velocity);
velocity_new = velocity - f_x / f_prime_x;
if abs(velocity_new - velocity) < tol
break
end
velocity = velocity_new;
iter = iter + 1;
end

% Final velocity and flow rate values
V = velocity;
Q = A * V;

% Displaying the flow rate
disp(Q);


%% Question 3
clear;clc
A = @(Pstatic) sqrt((Pstatic-96)/12);
P = @(A) 96 + 12*A.^2;

A0 = 4; P0 = 200;
tol = 0.0001; diff = Inf; iter = 0;

while diff > tol
    if iter <= 30
    An = A(P0);
    diff = abs(An - A0);
    A0 = An;
    P0 = P(A0);
    iter = iter + 1;
    else
        break
    end
end

fprintf("flow rate %.4f\n", A0)
fprintf("static pressure %.4f\n", P0)

%% Question 4
clear; clc

k1 = 19; k2 = 16; k3 = 15; g = 9.8;
m1 = 0.089; m2 = 0.076; m3 = 0.066;

A = [k1+k2 -k2 0; -k2 k2+k3 -k3; 0 -k3 k3];
B = [m1 * g; m2 * g; m3 * g];
x = A\B;

for i = 1:3
    disp(x(i))
end
