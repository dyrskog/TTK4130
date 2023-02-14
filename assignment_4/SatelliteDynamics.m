function [ state_dot ] = SatelliteDynamics( t, x, parameters )

    % Code your equations here...

    % The code must return in the order you selected, e.g.:
    %    state_dot =  [velocity;
    %                  orientation_dot;
    %                  acceleration (ac);
    %                  angular acceleration (omega dot)];

    %    state = [position (3);
    %             orientation (9);
    %             velocity (3);
    %             angular velocity (3)]
    
    G = 6.674e-11; % Gravitational constant
    mT = 5.9722e24; % Earth mass

    p = x(1:3); % Position
    R = reshape(x(4:12), [3,3]); % Orientation
    v = x(13:15); % Velocity
    omega = x(16:18); % Angular velocity

    % Skew symmetric omega
    omega_skew = [0, -omega(3), omega(2); 
                omega(3), 0, -omega(1); 
                -omega(2), omega(1), 0];
    J = parameters; % Inertia matrix
  
    p_dot = v; % Velocity
    R_dot = reshape(R*omega_skew, [9,1]); % Change in orientation
    v_dot = -(G*mT*p)/(norm(p)^3); % Acceleration
    omega_dot = -J\omega_skew*(J*omega); % Angular acceleration

    state_dot = [p_dot;
                R_dot;
                v_dot;
                omega_dot];
end
