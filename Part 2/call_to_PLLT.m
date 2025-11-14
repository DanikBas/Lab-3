clc; clear; close all

% call to PLLT function

% values from part 3 - cessna
% b   = 36;         % span
% c_r = 5 + 4/12;     % root chord[ft]
% c_t = 3 + 7/12;     % tip chord[ft]


% %b = ;
% a0_t = ;
% a0_r = ;
% %c_t = ;
% aero_t = ;
% aero_r = ;
% geo_t = ;
% geo_r = ;
% 
% N = 1:100;

b = 100; 
a0_t = 6.3; 
a0_r = 6.5; 
c_t = 8; 
c_r = 10; 
aero_t = 0; 
aero_r = -2*pi/180; 
geo_t = 5*pi/180; 
geo_r = 7*pi/180; 
N = 5;

e = 0.9795;


c_L = 0.6674;


c_Di = 0.0130;

[e,c_L,c_Di] = PLLT(b,a0_t,a0_r,c_t,c_r,aero_t,aero_r,geo_t,geo_r,N);

