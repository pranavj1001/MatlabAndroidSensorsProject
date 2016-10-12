connector on
m = mobiledev;

m.AccelerationSensorEnabled = 1;
m.AngularVelocitySensorEnabled = 1;

m.Logging = 1;

disp('Acquiring Data')

pause(5)

m.Logging = 0;

[a,t] = accellog(m);
[av,tav] = angvellog(m);

plot(t,a)
figure;
plot(tav,av)

clear m

connector off