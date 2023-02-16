clear all
close all
clc

% CASE 2

% Define your initial state, e.g. as:
% state = [position;
%          orientation;
%          velocity;
%          angular velocity];

skew = @(w) [0, -w(3), w(2); w(3), 0, -w(1); -w(2), w(1), 0];

% Satelite parameters
l = 0.5; % side length
m = l^3 * 1; % Mass = Volume x density
m0 = 0.1; % Point mass
rp = [l/2; l/2; l/2]; % Coordinates of corner
rc = (m0/(m + m0))*rp; % New center of mass

orbit_height = 36e6;
earth_radius = 6356e3;
% Satellite position in spherical coordinates
radial = orbit_height + earth_radius;
theta = 0;
phi = pi/2;

% From the 3D example
r = random('norm',0,1,[3,1]); % Random axis of rotation / angle
R = expm([   0,      -r(3),  +r(2);
             +r(3),     0,   -r(1);
             -r(2), +r(1),    0]);      % Rotation matrix describing the satellite orientation

J = (1/6)*m*l^2*eye(3) - m0*skew(rp)*skew(rp) - (m+m0)*skew(rc)*skew(rc); % Inertia matrix

% Define initial state
state = zeros(18,1);
state(1:3) = radial*[sin(theta)*cos(phi); sin(theta)*sin(phi); cos(theta)]; % Initial position (from spherical coordinates to cartesian)
state(4:12) = reshape(R,[1 9]); % Initial rotation
state(13:15) = [1 0 0]; % Initial velocity
state(16:18) = [1 0 0]; % Initial angular velocity

parameters = J;

time_final = 120; %Final time

% Visualization parameters
ScaleFrame = 5;   % Scaling factor for adjusting the frame size (cosmetic)
FS         = 15;  % Fontsize for text
SW         = 0.035; % Arrows size

% Simulate satellite dynamics
[time,statetraj] = ode45(@(t,x)SatelliteDynamics(t, x, parameters),[0,time_final],state);

% Here below is a template for a real-time animation
tic; % resets Matlab clock
time_display = 0; % time displayed
while time_display < time(end)
    time_animate = toc; % get the current clock time
    % Interpolate the simulation at the current clock time
    state_animate = interp1(time,statetraj,time_animate);

    figure(1);clf;hold on
    % Use the example from "Satellite3DExample.m" to display your satellite
    p = state_animate(1:3)'*1e-7; % Position scaled down to fit graph window
    R = reshape(state_animate(4:12), [3 3]);
    omega = state_animate(16:18)';
    MakeFrame(zeros(3,1),eye(3),ScaleFrame,FS,SW,'a', 'color', 'k')
    MakeFrame(p,R,ScaleFrame,FS,SW,'b', 'color', 'r')
    MakeArrow(p,R*omega,FS,SW,'$$\omega$$', 'color', [0,0.5,0])
    DrawRectangle(p,R ,'color',[0.5,0.5,0.5]);
    FormatPicture([0;0;2],0.5*[73.8380   21.0967   30.1493])

    if time_display == 0
        display('Hit a key to start animation')
        pause
        tic
    end
    time_display = toc; % get the current clock time
end
