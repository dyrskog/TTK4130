function [ state_dot ] = Kinematics( t, state, parameters )
    % state_dot is time derivative of your state.
    % Hints:
    % - take a look at eq. (2) in the assignment
    % - "parameters" allows you to pass some parameters to the "Kinematic" function.
    % - "state" will contain representations of the solid orientation (SO(3)).
    % - use the "reshape" function to turn a matrix into a vector or vice-versa.
    % - check matlab documentation on how to invert a matrix, alternatively
    %   how to best solve Ax = b for x (what is recommended?) 
    % Code your equations here...

    [Rba, M] = Rotations(state);

    % The "\"-operator is recommended when performing Matrix inversion in Matlab
    state_dot = inv(M)\parameters;
end
