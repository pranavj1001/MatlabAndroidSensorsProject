% Compass
% Plots Magnetic Field Data as a vector

% Enable Connector
connector on

% Connect to device
m = mobiledev;

% Enable Sensor and Start Logging
m.MagneticSensorEnabled=1;
m.Logging=1;



for k = 1:200
    pause(1)
    [mf, t] = magfieldlog(m);
    mfa = mean(mf);
    if ~isempty(mf)
        quiver3(0,0,1,mfa(1), mfa(2), mfa(3));
        
        % Set plot display
        xlim([-90 90]);
        ylim([-90 90]);
        zlim([-90 90]);
        
        discardlogs(m)
    end
end

% Stop Acquiring Data & Disable Sensor
m.Logging=0;
m.MagneticSensorEnabled=0;

% Clean up
clear m
connector off

