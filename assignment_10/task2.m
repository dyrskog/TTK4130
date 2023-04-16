close all; clear;

g = 9.81;
k = 2.40;
xd = 1.32;
m = 200;

x0 = [2; 0];

f = @(t,x) [x(2); 
            -g*(1-(xd/x(1))^k)];

dfdx = @(t,x) [0                                1;
                k*g*(xd/(x1^2))*(xd/x1)^(k-1)   0];

ButcherArray.A = A;
ButcherArray.b = b';
ButcherArray.c = c;

delta_t = 0.01;
tf = 10;
T = 0:delta_t:tf;
