clc; clear; close all;

%% Plot pounds of thrust vs airspeed
% Cessna 180 aircraft
W = 2500;           % weight [lbm]
altitude = 10000;   %[feet]
S = 174;            % Wing area [ft^2]
AR = 7.5;           % Aspect ratio
e = 0.8;            % Oswald efficiency factor
CD0 = 0.018;        % Zero-lift drag coefficient (wing only)
rho = 0.0023769;    % Air density [sl/ft^3]

%% Airspeed range
V = linspace(40, 200, 500);   % Airspeed [ft/s]

%% Drag components (wing only)
D0 = 0.5 * rho * V.^2 * S * CD0;                     % Parasitic drag
Di = (2 * W^2) ./ (rho * V.^2 * S * pi * e * AR);   % Induced drag

%% Total thrust required
T = D0 + Di;  % Total thrust required [lb]

%% Convert V to knots for plotting
V_knots = V / 1.68781;  % 1 knot = 1.68781 ft/s

%% Plot
figure;
plot(V_knots, T, 'LineWidth', 2)
grid on
xlabel('Airspeed [knots]')
ylabel('Thrust Required [lbf]')
title('Thrust Required for Steady, Level Flight (Cessna 180 Wing Only)')

% Optional: Mark minimum thrust required
[Tmin, idx_min] = min(T);
hold on
plot(V_knots(idx_min), Tmin, 'ro', 'MarkerFaceColor', 'r')
text(V_knots(idx_min)+2, Tmin, sprintf('Min T = %.0f lbf at %.0f knots', Tmin, V_knots(idx_min)))
