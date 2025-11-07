clear; clc; close all;

% want NACA 0018 and 2418

% inputs: NACA code, cord length, number of panels
[xU1, yU1, xL1, yL1] = NACA_gen([0 0 18] , 10, 100);

[xU2, yU2, xL2, yL2] = NACA_gen([2 4 18] , 10, 100);


figure(1)
hold on
plot(xU1,yU1)
plot(xL1,yL1)
ylim([-1 1])
hold off

figure(2)
hold on
plot(xU2,yU2)
plot(xL2,yL2)
ylim([-1 1])
hold off