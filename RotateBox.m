% RotateBox
% Rotates 3D box based on phone orientation

% Enable Connector
connector on
if exist('m', 'var')
    clear m
end

% Connect to device
m = mobiledev;

% Create a 3D box with multi-colored sides
X = [   0 1 1 0 0 0;
        1 1 0 0 1 1;
        1 1 0 0 1 1;
        0 1 1 0 0 0];
Y = [   0 0 1 1 0 0;
        0 1 1 0 0 0;
        0 1 1 0 1 1;
        0 0 1 1 1 1];
Z = [   0 0 0 0 0 1;
        0 0 0 0 0 1;
        1 1 1 1 0 1;
        1 1 1 1 0 1];
h = patch(4*X-2,8*Y-4,Z, 1:6);

% Set plot display
xlim([-5 5]);
ylim([-5 5]);
zlim([-5 5]);

% Enable Sensor and Start Logging Data
m.OrientationSensorEnabled=1;
m.Logging=1;

% Collect Data while phone is rotated
% pause(5);

pause(1)

% Read Data from Log
[o, t] = orientlog(m);

% Measure differences in rotations

% Rotate 3D Box in same fashion as phone
for k = 1:200
    set(h, 'XData', 4*X-2, 'YData', 8*Y-4, 'ZData', Z);
    % Read Data from Log
    [o, t] = orientlog(m);
    if ~isempty(o)
        discardlogs(m)
        rotate(h, [1 0 0], -o(1,2)); % pitch
        rotate(h, [0 1 0], o(1,3)); % roll
        rotate(h, [0 0 1], -o(1,1)+65); % azimuth
    end
    pause(1)
end

% Stop Logging
m.Logging=0;

% clean up
close all
clear m
connector off