clc; clear all; close all; 

%% Make rotation matrix function R = R(k, theta) (fill in)
skew = @(w) [0, -w(3), w(2); w(3), 0, -w(1); -w(2), w(1), 0]; % may become helpful
R_func = @(k, theta) cos(theta)*eye(3) + sin(theta)*skew(k) + (1-cos(theta))*k*k'; % calculate rotation matrix from angle and axis

%% Rotation axis and angles for a->b, b->c (fill in)

kab = [0; 0; 1]; %rotation axis from a to b 
thetaab = 3*pi/2; %rotation angle from a to b
kbc = [0; -1; 0]; % rotation axis from b to c
thetabc = pi/2; %rotation angle from b to c

Rab = R_func(kab, thetaab); % rotation matrix from a to b
Rbc = R_func(kbc, thetabc); % rotation matrix from b to c

%% rotation matrix, axis and angle from c->a (fill in) 
Rca = (Rab*Rbc).'; % rotation matrix from c to a

[thetaca, kca] = Shepperd(Rca);
thetaca = double(thetaca);
kca = double(kca);

stopAngle = thetaab+thetabc+thetaca;   % what angle to stop rotating (total angle)

%% Calculate rotation matrices (nothing to fill in)
n = 200; % number of discretization points
theta_t = linspace(0, 2*pi, n+1); % we rotate uintill 2pi, but will stop before
dtheta = theta_t(2) - theta_t(1); % angle increments

R_t1 = R_func(kab, dtheta); % small part of a->b rotation
R_t2 = R_func(kbc, dtheta); % small part of b->c rotation
R_t3 = R_func(kca, dtheta); % small part of c->a rotation

Rlist = cell(n+1, 1);
Rlist{1} = eye(3);

for i=(2:n+1)
    if (i <= n/4)
        Ri = Rlist{i-1}*R_t1;
    elseif (i > n/4) && (i <n/2)
        Ri = Rlist{i-1}*R_t2;
    else
        Ri = Rlist{i-1}*R_t3;
    end
    if (theta_t(i) >= stopAngle) % stopAngle, to stop rotating further 
        Ri = Rlist{i-1};
    end
    Rlist{i} = Ri;
end
%% Real-time animation (fill in) 
ScaleFrame = 5;   % Scaling factor for adjusting the frame size (cosmetic)
FS         = 15;  % Fontsize for text
SW         = 0.035; % Arrows size
time_display = 0; % initialise time_display
for i =(1:n+1)
    state_animate = Rlist{i}; % what is the 'state' that we animate? 
    p     = [5;5;5];  % Position of the single body
    
    %3D below this point
    figure(1);clf;hold on
    MakeFrame( zeros(3,1),eye(3),ScaleFrame,FS,SW,'a', 'color', 'k')
    MakeFrame( p,state_animate,ScaleFrame,FS,SW,'b', 'color', 'r')
    DrawRectangle(p,state_animate ,'color',[0.5,0.5,0.5]);
    FormatPicture([0;0;2],0.5*[73.8380   21.0967   30.1493])

    if time_display == 0
        display('Hit a key to start animation')
        pause
        tic
    end
    time_display = toc; %get the current clock time
end

