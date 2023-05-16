%% Question 1
clear; clc
t = 0:0.1:10; x = zeros(3, length(t)); omega = zeros(1);
m1 = 37; m2 = 46; m3 = 55;
k1 = 270; k2 = 260; k3 = 250; k4 = 200;

A = [(k1/m1)+(k2/m1), -k2/m1, 0; -k2/m2, (k2/m2)+(k3/m2), -k3/m2; 0, -k3/m3, (k3/m3)+(k4/m3)];
[eigen_vector, eigen_value] = eig(A)

for i = 1:3
    omega(i) = sqrt(abs(eigen_value(i,i)));
end

for i = 1:length(omega)
    x(i, :) = eigen_vector(i, 1) .* cos(omega(i) .* t);
end

subplot(2, 1, 1);
plot(t,x(1, :),'b',t,x(2, :),'r',t,x(3, :),'g');
xlabel('Time (s)'); ylabel('Displacement (m)');  grid on;
legend('Car 1','Car 2','Car 3'); title('First Mode of Oscillation');

for i = 1:length(omega)
    x(i, :) = eigen_vector(i, 1) .* sin(omega(i) .* t);
end

subplot(2, 1, 2);
plot(t,x(1, :),'b',t,x(2, :),'r',t,x(3, :),'g');
xlabel('Time (s)'); ylabel('Displacement (m)'); grid on;
legend('Car 1','Car 2','Car 3'); title('Second Mode of Oscillation');

%% Question 2
clear; clc
% Second Order Polynomial
x = [12.9, 13.5, 13.4, 13.6, 13.7, 14, 15, 16.7, 18.3, 19, 20.2, 21.7, 23.3, 26.7]; order = 2;
y = [13, 12.2, 11.3, 10.1, 8.1, 6.2, 4.2, 2.3, 1.1, 0.8, 0.5, 0.4, 0.3, 0.2]; n = length(x);

a = polyfit(x, y, order); a2 = a(1); a1 = a(2); a0 = a(3); 
fprintf("The second order polynomial is: %.4fx^2 - %.4fx + %.4f\n", a2, abs(a1), a0)

f = @(X) a2*X.^2 + a1*X + a0;
X = 13:27; Y = f(X); Sr = 0;

for i = 1:n
    Sr = Sr + (y(i) - a0 - a1*x(i) - a2*(x(i))^2)^2;
end

Er = sqrt(Sr/(n-order+1));
fprintf("The goodness of fit for the second order polynomial is %.4f\n\n", Er)

subplot(2, 1, 1)
plot(x, y, "+", 'LineWidth', 2, 'MarkerSize', 10); hold on;
plot(X, Y, 'r-', 'LineWidth', 2);
xlabel('x'); ylabel('y'); title('Second-Order Interpolation of Data'); 
legend('Original Data', 'Interpolation'); grid on;

% Third Order Polynomial
order = 3; a = polyfit(x, y, order); a3 = a(1); a2 = a(2); a1 = a(3); a0 = a(4);
fprintf("The third order polynomial is: %.4fx^3 + %.4fx^2 + %.4fx + %.4f\n", a3, a2, a1, a0)

f = @(X) a3*X.^3 + a2*X.^2 + a1*X + a0;
X = 13:27; Y = f(X); Sr = 0;

for i = 1:n
    Sr = Sr + (y(i) - a0 - a1*x(i) - a2*(x(i))^2 - a3*(x(i))^3)^2;
end

Er = sqrt(Sr/(n-order+1));
fprintf("The goodness of fit for the third order polynomial is %.4f\n\n", Er)

subplot(2, 1, 2)
plot(x, y, "+", 'LineWidth', 2, 'MarkerSize', 10); hold on;
plot(X, Y, 'r-', 'LineWidth', 2);
xlabel('x'); ylabel('y'); title('Third-Order Interpolation of Data'); 
legend('Original Data', 'Interpolation'); grid on;

%% Question 3
clear; clc
t = 9:-1:0; S = [4, 6, 4, 15, 37, 46, 42, 39, 8, 0]; start_v = 4; end_v = 6;

% NOTE TO GA: To find 0th, 1st, 2nd order change start_v to 1
for order = start_v:end_v
    speed = lagrange(t, S, 1.5, order);
    if order == 1
        fprintf("The 0th order Langrange estimation for speed of 1.5 s is equal %.4f Km/h\n", speed)
    elseif order == 2
        fprintf("The 1st order Langrange estimation for speed of 1.5 s is equal %.4f Km/h\n", speed)
    elseif order == 3
        fprintf("The 2nd order Langrange estimation for speed of 1.5 s is equal %.4f Km/h\n", speed)
    elseif order == 4
        fprintf("The 3rd order Langrange estimation for speed of 1.5 s is equal %.4f Km/h\n", speed)
    else
        fprintf("The %dth order Langrange estimation for speed of 1.5 s is equal %.4f Km/h\n", order-1, speed)
    end
end

%% Question 4
clear; clc
y = @(x) exp((10.*x)/765); a = 0; b = 360; y_analytical = (153*exp(80/17) - 1)/2;

y_trapz_5 = trap(y, a, b, 5); fprintf("The trapezoidal integration with n = 5 is equal to %.4f\n", y_trapz_5)
y_trapz_20 = trap(y, a, b, 20); fprintf("The trapezoidal integration with n = 20 is equal to %.4f\n", y_trapz_20)
y_trapz_40 = trap(y, a, b, 40); fprintf("The trapezoidal integration with n = 40 is equal to %.4f\n\n", y_trapz_40)

y_simpson13_1 = simpson13(y, 0, 360, 1); fprintf("The simpson 1/3 rule integration with n = 1 is equal to %.4f\n", y_simpson13_1)
y_simpson13_5 = simpson13(y, 0, 360, 5); fprintf("The simpson 1/3 rule integration with n = 5 is equal to %.4f\n", y_simpson13_5)
y_simpson13_15 = simpson13(y, 0, 360, 15); fprintf("The simpson 1/3 rule integration with n = 15 is equal to %.4f\n\n", y_simpson13_15)

fprintf("The difference between trapezoidal n = 5 with analytical is equal to %.4f%%\n", abs(100*(y_analytical-y_trapz_5)/y_analytical))
fprintf("The difference between trapezoidal n = 20 with analytical is equal to %.4f%%\n", abs(100*(y_analytical-y_trapz_20)/y_analytical))
fprintf("The difference between trapezoidal n = 40 with analytical is equal to %.4f%%\n\n", abs(100*(y_analytical-y_trapz_40)/y_analytical))

fprintf("The difference between simpson 1/3 rule n = 1 with analytical is equal to %.4f%%\n", abs(100*(y_analytical-y_simpson13_1)/y_analytical))
fprintf("The difference between simpson 1/3 rule n = 5 with analytical is equal to %.4f%%\n", abs(100*(y_analytical-y_simpson13_5)/y_analytical))
fprintf("The difference between simpson 1/3 rule n = 15 with analytical is equal to %.4f%%\n", abs(100*(y_analytical-y_simpson13_15)/y_analytical))
