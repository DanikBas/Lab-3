clear; clc; close all;

% want NACA 0018 and 2418

% inputs: NACA code, cord length, number of panels
[xU1, yU1, xL1, yL1, x_c1, y_c1] = NACA_gen([0 0 18] , 10, 100);

[xU2, yU2, xL2, yL2, x_c2, y_c2] = NACA_gen([2 4 18] , 10, 100);


figure(1)
hold on
plot(xU1,yU1)
plot(xL1,yL1)
ylim([-1 1])
title("NACA 0018")
plot(x_c1, y_c1, 'k--')
yline(0, 'g', LineWidth=.3)
hold off

figure(2)
hold on
plot(xU2,yU2)
plot(xL2,yL2)
ylim([-1 1])
title("NACA 2418")
plot(x_c2, y_c2, 'k--')
yline(0, 'g', LineWidth=.3)
hold off