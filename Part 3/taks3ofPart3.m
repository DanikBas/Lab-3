% Part 3 - Task 3
% Plot total drag coeff, induced drag coeff, profile drag coeff vs. alpha

clc; clear; close all;


% Task 1
b   = 36;         % span
c_r = 5 + 4/12;     % root chord[ft]
c_t = 3 + 7/12;     % tip chord[ft]

% 2D airfoil data (from Part 2)
a0_r    = 0.1048 *180/pi;  % lift slope at root (per rad)
a0_t    = 0.1051 *180/pi;  % lift slope at tip (per rad)
aero_r  = deg2rad(-2);        % root alpha_L=0 [rad] 
aero_t  = 0;  % tip alpha_L=0 [rad]
S = b * (c_r + c_t) / 2;  % planform area [ft^2]

% PLLT settings
N = 40;                          

% Sweep tip geometric angle of attack (degrees)
alpha_tip_deg = linspace(-5,10,200); % GOOD
nA = length(alpha_tip_deg);

C_Di = zeros(1,nA); 
C_L_vec = zeros(1,nA); 

for k = 1:nA
     geo_t = deg2rad(alpha_tip_deg(k));           % tip AoA
     geo_r = deg2rad(alpha_tip_deg(k) + 2.0);     % root AoA with +2° twist

    % Call PLLT - ALL RADIAN INPUTS
    [e, C_L_vec(k), C_Di(k)] = PLLT_submission(b, a0_t, a0_r, c_t, c_r,aero_t, aero_r, geo_t, geo_r, N); % FIXED
end



%---------Task 2-----------------
alpha_exp = linspace(-10,6,9);
cl_exp_tip = linspace(-0.8,0.8,9);
cd_exp_tip = [0.018,0.0135,0.0115,0.0102,0.0098,0.0103,0.0115,0.014,0.018];

% % %Root NACA 2412
% % cl_exp_root = linspace(-0.8,1,9); 
% % cd_exp_root = [0.022,0.017,0.013,0.011,0.010,0.0099,0.010,0.011,0.0135];
% 
% %check experimental data by plotting
% %cl vs cd tip
% p_tip = polyfit(cl_exp_tip,cd_exp_tip,2);
% cl_fit = linspace( min(cl_exp_tip),max(cl_exp_tip),200);
% cd_fit = polyval(p_tip,cl_fit);
% 
% 
% % %cl vs cd root
% % p_root = polyfit(cl_exp_root,cd_exp_root,2);
% % x_fit_root = linspace( min(cl_exp_root),max(cl_exp_root),200);
% % y_fit_root = polyval(p_root,x_fit_root);
% 
% 
% %cl vs alpha tip
% p_tip2 = polyfit(alpha,cl_exp_tip,1);
% 
% % %cl vs alpha tip
% % p_root2 = polyfit(alpha,cl_exp_root,1);
% 
% alpha_model = linspace(-20,20,200);
% cl_model = polyval(p_tip2, alpha_tip_deg);  %FIXED      % estimated cl
% cd_model = polyval(p_tip, cl_model);            % cd(cl(alpha))
% %cl using fit to alpha


% Fit CL(alpha) -- alpha is in degrees
p_cl_alpha = polyfit(alpha_exp, cl_exp_tip, 1);

% Fit CD(CL)
p_cd_cl = polyfit(cl_exp_tip, cd_exp_tip, 2);

% Model CL at each alpha (in degrees) — OK to stay deg here
cl_model = polyval(p_cl_alpha, alpha_tip_deg);

% Model profile CD
cd_model = polyval(p_cd_cl, cl_model);



% ----------Task 3--------------

% total drag
% cd_model is profile drag
C_Dtot = C_Di + cd_model; % GOOD



% PLOT coeffs vs alpha (DEGREES)
figure; hold on

plot(alpha_tip_deg, C_Di);

plot(alpha_tip_deg, cd_model)

plot(alpha_tip_deg, C_Dtot)

xlabel('Angle of Attack (deg)')
ylabel('Drag Coefficient')
legend('Induced Drag','Profile Drag','Total Drag')
grid on
ylim([0 0.05])


figure
plot(alpha_tip_deg, C_Di);