%Authors: Finn Moore, Laney Rehkopf, Ben Adams, Daniil Baskakov


function [e, c_L, c_Di] = PLLT_Submission(b,a0_t,a0_r,c_t,c_r,aero_t,aero_r,geo_t,geo_r,N)
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


%Aspect Ratio
S = b * (c_r + c_t)/2;
AR = b^2 / S;


theta = ( (1:N)' ) * pi/(2*N);

% --- Spanwise interpolation (eta = 0→root, 1→tip) ---
y  = (b/2) * cos(theta);        % positive root → tip
eta = y / (b/2);                % = cos(theta)

% Linear spanwise distributions (at each collocation)
c_loc   = c_r   + (c_t   - c_r)   .* eta;
a0_loc  = a0_r  + (a0_t  - a0_r)  .* eta;
aero_loc = aero_r + (aero_t - aero_r).*eta;
geo_loc  = geo_r  + (geo_t  - geo_r) .*eta;

alpha_eff = geo_loc - a0_loc;

% --- Odd Fourier indices ---
odd = (1:2:(2*N-1))';

% --- Build M matrix ---
M = zeros(N,N);
for i = 1:N
    th = theta(i);
    for j = 1:N
        n = odd(j);
        term1 = (4*b) / ( a0_loc(i)*c_loc(i) ) * sin(n*th);
        term2 = n * sin(n*th) / sin(th);
        M(i,j) = term1 + term2;
    end
end

% --- Solve for A coefficients ---
A = M \ alpha_eff;
A1 = A(1);

% --- Induced drag factor delta ---
global delta
delta = sum( odd(2:end) .* (A(2:end)/A1).^2 );

% --- Outputs ---
e    = 1/(1 + delta);
c_L  = pi * AR * A1;
c_Di = c_L^2 * (1 + delta) / (pi * AR);

end
