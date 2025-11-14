clear; clc; close all;

alpha = 5;


% Task 2.1

panels_total = linspace(2,400,200);
% 4:2:200;


Cl = zeros(size(panels_total));

for i = 1:length(panels_total)

    panels = panels_total(i);
    points_per_surface = (panels/2) + 1;

    [xU, yU, xL, yL] = NACA_gen([0 0 12], 100, points_per_surface);
    x_b = [fliplr(xU), xL(2:end)];
    y_b = [fliplr(yU), yL(2:end)];
    % x_b = [xU, xL];
    % y_b = [yU, yL];

    

    Cl(i) = 1000*Vortex_Panel(x_b, y_b, alpha);
end

dos_panels_total = 2.*panels_total;


Panel99 = Find99Percent(dos_panels_total, Cl);
Cl_final = Cl(end);
Cl_target = 0.99*Cl_final;

figure()
plot(panels_total, Cl)
hold on;
yline(Cl_target)
hold on;
xline(Panel99)
hold off;

% Task 2.2

NACA = ["0006" "0012" "0018"];
[c_l, alpha] = ComputeAndPlotC_lvsAlpha(NACA);
alpha_L0 = interp1(c_l, alpha, 0, 'linear');






%% One percent thing
function Cl99 = Find99Percent(panelsVec, Cl)
    panelsVec = panelsVec(1:length(Cl));
    Cl_final = Cl(end);
    Cl_target = 0.99 * Cl_final;

    idx = find(Cl >= Cl_target, 1, 'first');
    if ~isempty(idx)
        Cl99 = panelsVec(idx);
    else
        Cl99 = NaN;
    end
end



% alpha thing
function [c_l, alpha] = ComputeAndPlotC_lvsAlpha(NACA)
    figure()
    sgtitle("Cl vs Alpha (deg)")
    grid on
    for n = 1:length(NACA)
        code  = strToArray(NACA(n));
        % Get boundary Conditions
        [xU, yU, xL, yL] = NACA_gen(code , 1, 150);

            x_b = [fliplr(xU), xL(2:end)];
            y_b = [fliplr(yU), yL(2:end)];


        alpha = -20:20;
        % Calculate c_l
        c_l = -20:20;
        for i = 1:length(c_l)
            c_l(i) = Vortex_Panel(x_b, y_b, alpha(i));
        end

        % PLot c_l vs alpha
        c_l = c_l *100;
        plot(alpha, c_l,LineWidth=1.5)
        hold on;
        grid on
        title("NACA " + NACA(n))
        xlabel("alpha [deg]")
        ylabel("Cl")
    end
end

function arr = strToArray(str)
    % Ensure input is a string or character array
    if ischar(str)
        str = string(str);
    end
    
    % Example rule: first two digits separate, last two combined
    if strlength(str) ~= 4
        error('Input string must have 4 characters.');
    end
    
    % Split and convert
    a = str2double(extractBetween(str, 1, 1));
    b = str2double(extractBetween(str, 2, 2));
    c = str2double(extractBetween(str, 3, 4));
    
    % Combine into array
    arr = [a b c];
end