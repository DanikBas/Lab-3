function  [e,c_L,c_Di] = PLLT(b,a0_t,a0_r,c_t,c_r,aero_t,aero_r,geo_t,geo_r,N)

% e is the span efficiency factor (to be computed and returned)
% c_L is the coefficient of lift (to be computed and returned)
% c_Di is the induced coefficient of drag (to be computed and reported)

% b is the span (in feet)
% a0_t is the cross-sectional lift slope at the tips (per radian)
% a0_r is the cross-sectional lift slope at the root (per radian)
% c_t is the chord at the tips (in feet), c_r is the chord at the root (in feet)
% aero_t is the zero-lift angle of attack at the tips (in radians)
% aero_r is the zero-lift angle of attack at the root (in radians)
% geo_t is the geometric angle of attack (geometric twist + α) at the tips (in radians)
% geo_r is the geometric angle of attack (geometric twist + α) at the root (in radians)
% N is the number of odd terms to include in the series expansion for circulation

% feet to meters
b = b * 0.3048;



end

