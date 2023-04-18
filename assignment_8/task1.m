clear; close all;

% Task 1a

lambda = -2;
tf = 2;
x0 = 1;

f = @(t,x,u) lambda*x;
f_solved = @(t) x0*exp(lambda*t); % Analytical solution of the ODE

delta_t = 0.4;
u = 0;
[t1, x1] = RK1(f, x0, u, delta_t, tf);
[t2, x2] = RK2(f, x0, u, delta_t, tf);
[t4, x4] = RK4(f, x0, u, delta_t, tf);

t = linspace(0, tf, 1000);

x_true = f_solved(t);

figure(1)
hold on;
plot(t1, x1);
plot(t2, x2);
plot(t4, x4);
plot(t, x_true)
hold off;
grid; legend('RK1', 'RK2', 'RK4', 'Analytical');


% Task 1b



delta_ts = linspace(0.01, 1, 50);
RK1_error = zeros(1, length(delta_ts));
RK2_error = zeros(1, length(delta_ts));
RK4_error = zeros(1, length(delta_ts));

for i = 1:length(delta_ts)
    [t1, x1] = RK1(f, x0, u, delta_ts(i), tf);
    [t2, x2] = RK2(f, x0, u, delta_ts(i), tf);
    [t4, x4] = RK4(f, x0, u, delta_ts(i), tf);
    RK1_error(i) = x1(end) - f_solved(t1(end));
    RK2_error(i) = x2(end) - f_solved(t2(end));
    RK4_error(i) = x4(end) - f_solved(t4(end));
end

figure(2)
hold on;
loglog(delta_ts, RK1_error);
loglog(delta_ts, RK2_error);
loglog(delta_ts, RK4_error);
hold off;
grid; legend('RK1', 'RK2', 'RK4');
% set(gca, 'YScale', 'log')


function [t, x] = RK1(f, x0, u, h, tf)
    N = tf/h;
    x = zeros(length(x0), length(N));
    x(:,1) = x0;
    t = 0:h:tf;
    for k = 1:N
        K1 = f(t(k), x(:,k), u);
        x(:,k+1) = x(:,k) + h*K1;
    end
end

function [t, x] = RK2(f, x0, u, h, tf)
    N = tf/h;
    x = zeros(length(x0), length(N));
    x(:,1) = x0;
    t = 0:h:tf;
    for k = 1:N
        K1 = f(t(k), x(:,k), u);
        K2 = f(t(k), x(:,k) + h/2*K1, u);
        x(:,k+1) = x(:,k) + h*K2;
    end
end


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