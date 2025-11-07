clear; clc; close all;

%% ~~~~~~~~~~ Task 2 ~~~~~~~~~~~
% % ----Task 2.1-----
%     % NACA 0012
%     % Varriables           
%     x_b = 0 ;
%     y_b = 0 ; 
%     alpha = 5;
% 
%     c_l = Vortex_Panel(x_b, y_b, alpha);
% 
%     % Plot c_l vs num_panels

% ----Task 2.2------
    NACA = ["0006" "0012" "0018"];
    [c_l, alpha] = ComputeAndPlotC_lvsAlpha(NACA);



%% ~~~~~~~~~~~~ Task 3 ~~~~~~~~~~~~~~~
    NACA = ["0012" "2412" "4412"];
    [c_l, alpha] = ComputeAndPlotC_lvsAlpha(NACA);


%% Functions
function [c_l, alpha] = ComputeAndPlotC_lvsAlpha(NACA)

    for n = 1:length(NACA)
        % Get boundary Conditions
        [xU2, yU2, xL2, yL2] = NACA_gen([0 0 18] , 10, 10);

            % x_b and y_b are the boundary coordinates starting at the trailing
            % edge and going clockwise 
            % the leading edge is zero zero 

            x_b = zeros(1, length(xL2) + length(xU2));
            x_b(1:length(xL2)) = xL2';
            x_b(length(xL2)+1 : length(xL2) + length(xU2)) = xU2;

            y_b = zeros(1,length(yL2) + length(yU2));
            y_b(1:length(yL2)) = yL2';
            y_b(length(yL2)+1 : length(yL2) + length(yU2)) = yU2;


        alpha = linspace(-10,10,40);
        % Calculate c_l
        c_l = linspace(-10,10,40);
        for i = 1:length(c_l)
            c_l(i) = Vortex_Panel(x_b, y_b, alpha(i));
        end

        % PLot c_l vs alpha
        figure()
        hold on
        plot(alpha, c_l)
        hold off
        
    end




 end







