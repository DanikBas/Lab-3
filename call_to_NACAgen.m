clear; clc; close all;

%% ~~~~~~~~~~~~ Task 1 ~~~~~~~~~~~~~~
% want NACA 0018 and 2418

% inputs: NACA code, cord length, number of panels
[xU1,yU1, xL1,yL1, xU2,yU2, xL2,yL2] = NACA_gen([0 0 18] , 10, 10);
                                           %code   %cord_line  %#ofPanels