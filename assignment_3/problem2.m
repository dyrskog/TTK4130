syms q1 q2 L1 L2 real
syms dq1 dq2 real

q = [q1;q2];

[B, C] = joint_position(q, L1, L2);

% Rotation of frame 1 about z0
R10 =   [cos(q1) -sin(q1) 0;
        sin(q1) cos(q1) 0;
        0 0 1];

% Rotation of frame 2 about y1
R21 =   [cos(q2) 0 sin(q2);
        0 1 0;
        -sin(q2) 0 cos(q2)];

R20 = R10*R21;

dR10 = diff(R10, q1)*dq1; %+ diff(R10, q2)*dq2;
dR20 = diff(R20, q1)*dq1 + diff(R20, q2)*dq2;


Omega1 = simplify(dR10 * R10.');
omega1 = [Omega1(3,2);Omega1(1,3);Omega1(2,1)];

Omega2 = simplify(dR20 * R20.');
omega2 = [Omega2(3,2);Omega2(1,3);Omega2(2,1)];

% Linear velocity

vB = cross(omega1,B);
vC = cross(omega2,C);
