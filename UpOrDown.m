% UpOrDown
% Detects whether mobile device is Face Up or Face Down

% Enable Connector
connector on

% Connect to device
m = mobiledev;

% Enable Sensor and Start Logging
m.OrientationSensorEnabled=1;
m.Logging=1;

% Run a loop, checking for orientation
for k = 1:200
    % Acquire 1 second of data
    pause(1)
    [o,t] = orientlog(m);
    discardlogs(m)
    
    if ~isempty(o)
        % Check Orientation and Display Results
        z = mean(o(:,3));
        if z > -90 && z < 90
            disp('Up')
        else
            disp('Down')
        end
    end
end

% Clean up
clear m
connector off

