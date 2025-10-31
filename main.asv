clear
close all

%% ~~~~~~~~~~ Task 2 ~~~~~~~~~~~
% ----Task 2.1-----
    % NACA 0012
    % Varriables                WHAT ARE THE BOUNDARY COND.?
    x_b = 0 ;
    y_b = 0 ; 
    alpha = 5;

    c_l = Vortex_Panel(x_b, y_b, alpha);

    % Plot c_l vs num_panels

% ----Task 2.2------
    NACA = [0006 0012 0018];
    % Varriables                WHAT ARE THE BOUNDARY COND.?
    x_b = 0 ;
    y_b = 0 ; 
    
    for n = 1:3
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



