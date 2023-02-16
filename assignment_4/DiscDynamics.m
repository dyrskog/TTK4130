function [ dxdt ] = DiscDynamics( t, x, parameters, J )
    R = reshape(x(1:9), [3,3]);
    omega = x(10:12);
    omega_skew = [0, -omega(3), omega(2); 
                omega(3), 0, -omega(1); 
                -omega(2), omega(1), 0];
    
    L = parameters(1);
    m = parameters(2);
    rc = L*[0;0;1];
    rc_skew =   [0, -rc(3), rc(2); 
                rc(3), 0, -rc(1); 
                -rc(2), rc(1), 0];
    F0 = -m*[0;0;9.81];
    Fb = R'*F0;
    
    R_dot = R*omega_skew;

    omega_dot = Jb\(rc_skew*Fb - omega_skew*J*omega);

    dxdt = [reshape(R_dot, [9,1]); omega_dot];
end