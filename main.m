clear; clc; close all;

%% ~~~~~~~~~~ Task 2 ~~~~~~~~~~~
% ----Task 2.1-----
    % NACA 0012
    % Varriables           
    alpha = 5;

    numOfPanels = 1:30;
    c_l = 1:30;
    for i = 1:length(numOfPanels)
         % Get boundary Conditions
        [xU2, yU2, xL2, yL2] = NACA_gen([0 0 12] , 10, i);

            % x_b and y_b are the boundary coordinates starting at the trailing
            % edge and going clockwise 
            % the leading edge is zero zero 

            x_b = zeros(1, length(xL2) + length(xU2));
            x_b(1:length(xL2)) = xL2';
            x_b(length(xL2)+1 : length(xL2) + length(xU2)) = xU2;

            y_b = zeros(1,length(yL2) + length(yU2));
            y_b(1:length(yL2)) = yL2';
            y_b(length(yL2)+1 : length(yL2) + length(yU2)) = yU2;


        c_l(i) = Vortex_Panel(x_b, y_b, alpha);
    end
    % Plot c_l vs num_panels
    figure()
    sgtitle("Cl vs Number of Panels (5 degrees AoA)")
    plot(numOfPanels, c_l,'-o', LineWidth=1, color ='r')
    xlabel("Number of Panels")
    ylabel("Cl")


% ----Task 2.2------
    NACA = ["0006" "0012" "0018"];
    [c_l, alpha] = ComputeAndPlotC_lvsAlpha(NACA);
    alpha_L0 = interp1(c_l, alpha, 0, 'linear');
    



%% ~~~~~~~~~~~~ Task 3 ~~~~~~~~~~~~~~~
    NACA = ["0012" "2412" "4412"];
    [c_l, alpha] = ComputeAndPlotC_lvsAlpha(NACA);


%% Functions
function [c_l, alpha] = ComputeAndPlotC_lvsAlpha(NACA)
    figure()
    sgtitle("Cl vs Alpha (deg)")
    grid on
    for n = 1:length(NACA)
        code  = strToArray(NACA(n));
        % Get boundary Conditions
        [xU, yU, xL, yL] = NACA_gen(code , 1, 150);

            % x_b and y_b are the boundary coordinates starting at the trailing
            % edge and going clockwise 
            % the leading edge is zero zero 

            % x_b = zeros(1, length(xL2) + length(xU2));
            % x_b(1:length(xL2)) = xL2';
            % x_b(length(xL2)+1 : length(xL2) + length(xU2)) = xU2;
            % 
            % y_b = zeros(1,length(yL2) + length(yU2));
            % y_b(1:length(yL2)) = yL2';
            % y_b(length(yL2)+1 : length(yL2) + length(yU2)) = yU2;
            x_b = [fliplr(xU), xL(2:end)];
            y_b = [fliplr(yU), yL(2:end)];


        alpha = -20:20;
        % Calculate c_l
        c_l = -20:20;
        for i = 1:length(c_l)
            c_l(i) = Vortex_Panel(x_b, y_b, alpha(i));
        end

        % PLot c_l vs alpha
        subplot(1,3,n)
        c_l = c_l *100;
        plot(alpha, c_l,LineWidth=1.5)
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







