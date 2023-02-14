% Function used to calculate position of point B and C
function [B, C] = joint_position(q, L1, L2)
    q1 = q(1);
    q2 = q(2);
    
    % Rotation of frame 1 about z0
    R10 =   [cos(q1) -sin(q1) 0;
            sin(q1) cos(q1) 0;
            0 0 1];

    % Rotation of frame 2 about y1
    R21 =   [cos(q2) 0 sin(q2);
            0 1 0;
            -sin(q2) 0 cos(q2)];
            
    % Origin of frame 1 in terms of frame 0 (point B)
    o10 = [L1*cos(q1); L1*sin(q1); 0];

    % Origin of frame 2 in terms of frame 1 (point C)
    o21 = [L2*cos(q2); 0; -L2*sin(q2)];

    % Homogenous transformation of frame 1 in terms of frame 0
    H10 = [R10 o10; zeros(1,3) 1];
    % Homogenous transformation of frame 2 in terms of frame 1
    H21 = [R21 o21; zeros(1,3) 1];
    % Homogenous transformation of frame 2 in terms of frame 0
    H20 = H10*H21;
    
    % B coordinates in terms of frame 0
    B = o10;
    % Extract C coordinates in terms of frame 0
    C = [H20(1,4); H20(2,4); H20(3,4)];
end

