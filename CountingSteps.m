% CountingSteps
% Counts Number of Steps from Acceleration Data

% Enable Connector
connector on

% Connect to device
m = mobiledev;

% Enable Sensor and Start Logging
m.AccelerationSensorEnabled=1;
m.Logging=1;

% Walk around.
% Changes in Acceleration Sensors will indicate steps
disp('Please Walk Around')
pause(10)

% Stop Acquiring Data & Disable Sensor
m.Logging=0;
m.AccelerationSensorEnabled=0;

% Read Log & Process Data
[a, t] = accellog(m);

% Change vectors to scalars
% Removes dependency on Orientation
x = a(:,1);
y = a(:,2);
z = a(:,3);
mag = sqrt(sum(x.^2 + y.^2 + z.^2, 2));

% Plot magnitude
subplot(3,1,1);
stem(t, mag);
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
title('Raw Magnitude')

% Remove effects of gravitity
magNoGrav = mag - mean(mag);

subplot(3,1,2);
stem(t, magNoGrav);
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
title('No Gravity')

% Find Peaks
amag = abs(magNoGrav);
subplot(3,1,3);
stem(t, amag);
xlabel('Time (s)');
ylabel('Acceleration Magnitude, No Gravity (m/s^2)');
title('Absolute Magnitude')

THR = 2;
n = 1;
peaks = [];
peaksi = [];
minMag = std(amag-1);
for k = 2:length(amag)-1
    if (amag(k) > minMag) && ...
            (amag(k) > THR*amag(k-1)) && ...
            (amag(k) > THR*amag(k+1))
        
        peaks(n) = amag(k);
        peaksi(n) = t(k);
        n = n + 1;
    end
end

if isempty(peaks)
    disp('No Steps')
    return
end

nSteps = length(peaks);
disp('Number of Steps:')
disp(nSteps)

% Plot markers at peaks
hold on;
plot(peaksi, peaks, 'r', 'Marker', 'v', 'LineStyle', 'none');
hold off;

% Clean up
clear m
connector off
