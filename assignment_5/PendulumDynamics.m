function [ dx ] = PendulumDynamics( t, x, parameters )
    q = x(1:3);
    dq = x(4:6);
    F = -10*q(1) - dq(1);
    [W, RHS] = PendulumODEMatrices( x, F , parameters);
    dx = [dq;
        W\RHS];
end