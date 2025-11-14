clc; clear; close all

% call to PLLT function

b = ;
a0_t = ;
a0_r = ;
c_t = ;
aero_t = ;
aero_r = ;
geo_t = ;
geo_r = ;

N = 1:100;

[e,c_L,c_Di] = PLLT(b,a0_t,a0_r,c_t,c_r,aero_t,aero_r,geo_t,geo_r,N);