clc; clear; close all;

% Air foil inputs
airfoils = {[0 0 12], [2 4 12], [4 4 12]}; 
alphas = -40:1:40;   % angle of attack range (deg)
c = 10;             % chord length
n = 100;            % number of panels per surface


%Plot Housekeeping
figure; hold on; grid on;
xlabel('\alpha (deg)')
ylabel('C_l')
title('Sectional Lift Coefficient vs Angle of Attack')
colors = lines(length(airfoils));
codestr = cellfun(@(x) sprintf('%d%d%02d', x(1), x(2), x(3)), airfoils, 'UniformOutput', false);
codestr = string(codestr);


for k = 1:length(airfoils)
    code = airfoils{k};
    % Generate geometry using NACA_gen
    [xU, yU, xL, yL] = NACA_gen(code, c, n);
    
    % Combine into one boundary array

            XB = zeros(1, length(xL) + length(xU)-1);
            XB(1:length(xU)) = flip(xU);
            XB(length(xU) : length(xL) + length(xU)-1) = xL;

            YB = zeros(1,length(yL) + length(yU)-1);
            YB(1:length(yU)) = flip(yU);
            YB(length(yL) : length(yL) + length(yU)-1) = yL;


    % Compute Cl vs Alpha
    CL_vals = zeros(size(alphas));
    for i = 1:length(alphas)
        CL_vals(i) = Vortex_Panel(XB, YB, alphas(i));
    end
    
    p = polyfit(alphas, CL_vals, 1);
    AoAL0(k) = -p(2)/p(1);   
    A0(k)    = p(1);         
    % Plot results
            subplot(2,2,k)
        plot(alphas, CL_vals, '-', 'Color', colors(k,:));
        codestr = cellfun(@(x) sprintf('%d%d%02d', x(1), x(2), x(3)), airfoils, 'UniformOutput', false);
        codestr = string(codestr);
        title("NACA "+ codestr(k))
        grid on;
        xlabel("alpha [deg]")
        ylabel("Cl")
end


%use thinairfoil theory 
[AlphaL0_thinair(1),A0_thinair(1)] =  thin_airfoil([0 0 12]);
[AlphaL0_thinair(2),A0_thinair(2)] = thin_airfoil([2 4 12]);
[AlphaL0_thinair(3),A0_thinair(3)] = thin_airfoil([4 4 12]);




airfoilNames = ["NACA 0012"; "NACA 2412"; "NACA 4412"];

% Experimental values from Abbott & von Doenhoff
alphaL0_exp = [-0.2; -2.0; -3.0];       % zero-lift angle (deg)
a0_exp      = [0.109; 0.110; 0.112];    % lift-curve slope (per deg)

% Build MATLAB table
ComparisonTable = table( ...
    airfoilNames, ...
    AoAL0(:), A0(:), ...                        % Vortex panel results
    AlphaL0_thinair(:), A0_thinair(:), ...      % Thin airfoil theory results
    alphaL0_exp(:), a0_exp(:), ...              % Experimental values
    'VariableNames', { ...
        'Airfoil', ...
        'alphaL0_Panel', 'a0_Panel', ...
        'alphaL0_ThinAirfoil', 'a0_ThinAirfoil', ...
        'alphaL0_Experimental', 'a0_Experimental' ...
    });

disp(ComparisonTable)

function [alphaL0_deg, a0_per_deg] = thin_airfoil(code)
m = (code(1))/100;
p = code(2)/10;     

N = 5000;
eps = 1e-9;
theta = linspace(eps, pi-eps, N);
x_over_c = 0.5*(1 - cos(theta));

% dyc/dx piecewise
dyc_dx = zeros(size(x_over_c));
if p > 0
    i1 = x_over_c < p;
    dyc_dx(i1) = 2*m/p^2 .* (p - x_over_c(i1));
    dyc_dx(~i1) = 2*m/(1-p)^2 .* (p - x_over_c(~i1));
end

% A0 and alpha_L=0
A0 = (1/pi) * trapz(theta, dyc_dx .* (1 - cos(theta)));
alphaL0_rad = A0/2;                
alphaL0_deg = alphaL0_rad * (180/pi);

alphas = linspace(-5, 15, 50);      
alphas_rad = alphas * pi/180;

Cl = 2*pi*(alphas_rad - alphaL0_rad);

pfit = polyfit(alphas, Cl, 1);
a0_per_deg = pfit(1);        

% Lift-curve slope in per degree
a0_per_deg = 2*pi * (pi/180); 
end



