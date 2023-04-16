clear; close all;

A = [1/4    1/4-sqrt(3)/6;
     1/4+sqrt(3)/6  1/4];
b = [1/2;
     1/2];
c = [1/2-sqrt(3)/6; 
     1/2+sqrt(3)/6];

ButcherArray.A = A;
ButcherArray.b = b;
ButcherArray.c = c;

f = @(t,x) [5*(x(2) - x(1)); 
            x(1)*(20 - x(3)) - x(2); 
            x(1)*x(2) - 2*x(3)];

dfdx = @(t,x) [-5           5       0; 
                20-x(3)     -1      -x(1);
                x(2)        x(1)    -2];
x0 = [1; 1; 1];

N = 200;
T = linspace(0,2,N);

x = IRK(ButcherArray, f, dfdx, T, x0);

% Plotting

figure(1)
hold on;
for i=1:height(x)
    plot(T,x(i,:));
end
hold off;
grid;
legend('x', 'y', 'z');