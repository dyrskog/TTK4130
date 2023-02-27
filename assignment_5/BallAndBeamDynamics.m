function [ dx ] = BallAndBeamDynamics( t, x, parameters )
    q = x(1:2);
    dq = x(3:4);
    T = 200*(q(1) - q(2)) + 70*(dq(1) - dq(2));
    [W, RHS] = BallAndBeamODEMatrices( x, T , parameters);
    dx = [dq;
        W\RHS];
end