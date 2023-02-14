%% Problem 2
% Code used to solve problem 2 of TTK4130 Assignment 3

syms q1 q2 L1 L2 real
syms dq1 dq2 real

q = [q1;q2];

% Coordinates of point B and C
[B, C] = joint_position(q, L1, L2);

% Rotation of frame 1 about z0
R10 =   [cos(q1) -sin(q1) 0;
        sin(q1) cos(q1) 0;
        0 0 1];

% Rotation of frame 2 about y1
R21 =   [cos(q2) 0 sin(q2);
        0 1 0;
        -sin(q2) 0 cos(q2)];

% Rotation of frame 2 in terms of frame 0
R20 = R10*R21;

% Differentiate the rotational matrices
dR10 = diff(R10, q1)*dq1;
dR20 = diff(R20, q1)*dq1 + diff(R20, q2)*dq2;

% Angular velocities in terms of frame 0
Omega1 = simplify(dR10 * R10.');
omega1 = [Omega1(3,2);Omega1(1,3);Omega1(2,1)];

Omega2 = simplify(dR20 * R20.');
omega2 = [Omega2(3,2);Omega2(1,3);Omega2(2,1)];

% Linear velocity
vB = simplify(cross(omega1,B));
vC = simplify(cross(omega2,C));
