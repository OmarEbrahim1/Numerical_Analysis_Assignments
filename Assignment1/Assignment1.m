% Student name: Omar Ebrahim
% Student ID: 110076575

%% Question 2
% Part 1
clear; clc
student_id = [1 1 0 0 7 6 5 7 5];
x = 1:9;
y = student_id(:);

plot(x, y, "Marker", "*", "MarkerEdgeColor", "red", "MarkerSize", 10)
title("The Position of the Digit vs Student ID")
xlabel("Position of the Digit")
ylabel("Student ID")
legend("Student ID")
grid on

% Part 2
squared_sum = sum(y.^2);
fprintf("The sum of the square of ID = %d\n", squared_sum)

% Part 3
sum = sum(y);
sum_sin = sin(sum);
fprintf("The sine of the sum of ID = %1.4f\n", sum_sin)

%% Question 3
% Part 1 with timestep of 10 seconds
% a1 = 7; a2 = 6; a3 = 5;
clear;clc
k = 0.07; final_metal_heat = 576; legend_size = 5;
metal_heat = zeros(1); time = zeros(1); water_heat = ones(1);
time_step1 = 10; time_step2 = 1; time(1) = 0;
metal_heat(1) = 1200; water_heat(1) = 25;

for i = 1:20
    metal_heat(i+1) = -k*time_step1*(metal_heat(i)-water_heat(1)) + metal_heat(i);
    time(i+1) = time(i) + time_step1;
end

time_to_cool_576 = (final_metal_heat-metal_heat(1))/(-k*(metal_heat(1)-water_heat));
fprintf("Part 1: The time to cool to 576 Celsius for time step of 10 seconds = %1.4f seconds\n", time_to_cool_576)

figure(1);
subplot(2,2,1)
hold on; grid on;
scatter(time_to_cool_576 , final_metal_heat, 200, "+","red")
plot(time, metal_heat, "Color","blue")
title("Part 1: Time vs Metal's Temperature")
xlabel("Time (seconds) step of 10")
ylabel("Metal's Temperature (Celsius)")
legend('Final Temperature', 'Metal Temperature', 'Location', 'best', 'FontSize', legend_size)

% Part 1 with time step of 1 second
for i = 1:20
    metal_heat(i+1) = -k*time_step2*(metal_heat(i)-water_heat(1)) + metal_heat(i);
    time(i+1) = time(i) + time_step2;
end

time_to_cool_576 = (final_metal_heat-metal_heat(1))/(-k*(metal_heat(1)-water_heat));
fprintf("Part 1: The time to cool to 576 Celsius for time step of 1 second = %1.4f seconds\n", time_to_cool_576)

subplot(2, 2, 2)
hold on; grid on;
scatter(10.448 , final_metal_heat, 200, "+","red")
plot(time, metal_heat, "Color","cyan")
title("Part 1: Time vs Metal's Temperature")
xlabel("Time (seconds) step of 1")
ylabel("Metal's Temperature (Celsius)")
legend('Final Temperature', 'Metal Temperature', 'Location', 'best', 'FontSize', legend_size)

% Part 2 with time step of 10 seconds
time_to_boil_water = 1765;
m = (100-water_heat)/time_to_boil_water;

for i = 1:20
    metal_heat(i+1) = -k*time_step1*(metal_heat(i)-water_heat(i)) + metal_heat(i);
    time(i+1) = time(i) + time_step1;
    water_heat(i+1) = m*i+25;
end

fprintf("Part 2: The time to cool to 576 Celsius for time step of 10 seconds = 10.448 seconds\n")

subplot(2, 2, 3)
hold on; grid on;
scatter(time_to_cool_576 , final_metal_heat, 200, "+","red")
plot(time, metal_heat, "Color", "magenta")
title("Part 2: Time vs Metal's Temperature")
xlabel("Time (seconds) step of 10")
ylabel("Metal's Temperature (Celsius)")
legend('Final Temperature', 'Metal Temperature', 'Location', 'best', 'FontSize', legend_size)


% Part 2 with time step of 1 second
for i = 1:20
    metal_heat(i+1) = -k*time_step2*(metal_heat(i)-water_heat(i)) + metal_heat(i);
    time(i+1) = time(i) + time_step2;
    water_heat(i+1) = m*i+25;
end

fprintf("Part 2: The time to cool to 576 Celsius for time step of 1 second = 10.448 seconds\n")

subplot(2, 2, 4)
hold on; grid on;
scatter(10.448 , final_metal_heat, 200, "+","red")
plot(time, metal_heat, "Color", "black")
title("Part 2: Time vs Metal's Temperature")
xlabel("Time (seconds) step of 1")
ylabel("Metal's Temperature (Celsius)")
legend('Final Temperature', 'Metal Temperature', 'Location', 'best', 'FontSize', legend_size)

%% Question 4
clear; clc
a1 = 7; a2 = 6; a3 = 5;
function_1 = @(x) a1*(x.^2)+a2*exp(x.^2)+cos(a3*x);
x = -5:0.01:5;
y = function_1(x);

plot(x, y)
title("X vs F(x)"); xlabel("X"), ylabel("F(x)")
grid on;

%% Question 5
clear; clc
% a1 = 7; a2 = 6; a3 = 5;
x0 = 1;
dx = 2;
f = @(x) 7*(x^3)-6*(x^0.5) + 5;
f1 = @(x) 21*x^2-3/(x^0.5);
f2 = @(x) 42*x+1.5/(x^1.5);
f3 = @(x) 42-2.25/(x^2.5);
f4 = @(x) 5.625/(x^3.5);

taylor_0 = f(x0);
taylor_1 = f(x0) + f1(x0)*dx;
taylor_2 = f(x0) + f1(x0)*dx + (1/2)*f2(x0)*dx^2;
taylor_3 = f(x0) + f1(x0)*dx + (1/2)*f2(x0)*dx^2 + (1/6)*f3(x0)*dx^3;
taylor_4 = f(x0) + f1(x0)*dx + (1/2)*f2(x0)*dx^2 + (1/6)*f3(x0)*dx^3 + (1/24)*f4(x0)*dx^4;
taylor_full = [taylor_0, taylor_1, taylor_2, taylor_3, taylor_4,];

exact_solution = f(x0 + dx);
fprintf('Exact solution: %.4f\n', exact_solution)

error = ones(1);
for i = 1:length(taylor_full)
    error(i) = abs((taylor_full(i) - exact_solution)/exact_solution)*100;
end

order = ["Zeroth", "First", "Second", "Third", "Fourth"];
for i = 1:(length(order)*2)
    if i <= 5
        fprintf('%s order approximation: %.4f\n', order(i), taylor_full(i))
    else
        fprintf('%s order percentage error: %.4f%%\n', order(i-5), error(i-5))
    end
end
