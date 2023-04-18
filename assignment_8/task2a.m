clear; close all;
tf = 25;
tspan = [0 tf];
x0 = [2; 0];


odefunc = @(t,x,u) [x(2); u*(1-x(1)^2)*x(2) - x(1);];

u = 5;
[t, x] = ode45(@(t,x) odefunc(t, x, u), tspan, x0);

% Plotting

figure(1)
plot(t, x);
grid; legend('x', 'y');

tstep = diff(t);
figure(2)
plot(tstep);
grid;

%% RK4

delta_t = 0.05;
[tRK, xRK] = RK4(odefunc, x0, u, delta_t, tf);

figure(3)
plot(tRK, xRK);
grid; legend('x', 'y');

figure(4)
hold on;
plot(t, x);
plot(tRK, xRK);
hold off; legend('x', 'y', 'xRK', 'yRK');
grid;


function [t, x] = RK4(f, x0, u, h, tf)
    N = tf/h;
    x = zeros(length(x0), length(N));
    x(:,1) = x0;
    t = 0:h:tf;
    for k = 1:N
        K1 = f(t(k), x(:,k), u);
        K2 = f(t(k), x(:,k) + h/2*K1, u);
        K3 = f(t(k), x(:,k) + h/2*K2, u);
        K4 = f(t(k), x(:,k) + h*K3, u);
        x(:,k+1) = x(:,k) + h*(K1/6 + K2/3 + K3/3 + K4/6);
    end
end
