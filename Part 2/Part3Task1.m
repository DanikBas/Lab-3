%--------Task 1------------------
clear; clc; close all;

b   = 36;         % span
c_r = 5 + 4/12;     % root chord[ft]
c_t = 3 + 7/12;     % tip chord[ft]

% 2D airfoil data (from Part 2)
a0_r    = 0.1048;   % lift slope at root (per rad)
a0_t    = 0.1051;   % lift slope at tip (per rad)
aero_r  = 0; % root alpha_L=0 [rad]
aero_t  = deg2rad(-0.2499);  % tip alpha_L=0 [rad]

% PLLT settings
N = 10;                          

% Sweep tip geometric angle of attack (degrees)
alpha_tip_deg = -5:1:15;      
C_L_vec       = zeros(size(alpha_tip_deg));

for k = 1:length(alpha_tip_deg)
    geo_t = deg2rad(alpha_tip_deg(k));          % tip geometric AoA [rad]
    geo_r = deg2rad(alpha_tip_deg(k) + 2.0);    % root is +2 deg [rad]

    %PLLT
    [e, C_L_vec(k), C_Di] = PLLT(b, a0_t, a0_r, c_t, c_r, aero_t, aero_r, geo_t, geo_r, N);
end

% Plot C_L vs alpha_tip
figure;
plot(alpha_tip_deg, C_L_vec*100,'LineWidth',1.5);
grid on;
xlabel('\alpha_{tip} [deg]');
ylabel('C_L');
title('Cessna 180: C_L vs Tip Angle of Attack');

