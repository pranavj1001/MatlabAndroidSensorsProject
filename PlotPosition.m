% PlotPosition
% Plots GPS Position Data on Google Maps

% Requires plot_google_map function from MATLAB File Exchange
% http://www.mathworks.com/matlabcentral/fileexchange/27627-zoharby-plot-google-map

% Enable Connector
connector on

% Connect to device
m = mobiledev;

% Enable Sensor and Start Logging
m.PositionSensorEnabled=1;
m.Logging=1;

% Acquire 1 second of data
pause(1)
[lon,lat, t] = poslog(m);

if ~isempty(lon)
   load drivingAroundMathWorks.mat
end

plot(lon,lat,'.r','MarkerSize',20)
plot_google_map('MapType', 'satellite')

% Clean up
clear m
%connector off

