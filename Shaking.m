% Shaking
% Detects whether phone is shaking

% Enable Connector
connector on

% Connect to device
m = mobiledev;

% Enable Sensor and Start Logging
m.AngularVelocitySensorEnabled=1;
m.Logging=1;

% Run a loop, checking for orientation
for k = 1:200
    % Acquire 1 second of data
    pause(1)
    [av,t] = angvellog(m);
    discardlogs(m)
    
    if ~isempty(av)
        
        avm = mean(av);
        % Change vectors to scalars
        % Removes dependency on Orientation
        x = avm(:,1);
        y = avm(:,2);
        z = avm(:,3);
        mag = sqrt(sum(x.^2 + y.^2 + z.^2, 2));
        
        % Check Orientation and Display Results
        if mag > 0.5
            disp('Shaking')
        else
            disp('Idle')
        end
    end
end

% Clean up
clear m
connector off

