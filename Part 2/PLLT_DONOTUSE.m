function [taperRation,delta] = PLLT(AR, chord, GTA, camber, SLS)

% delta induced drag factor
% Taper ratio is c_t / c_r  

% AR is aspect ratio
% chord (taper)                 chord
% geometric twist angle         GTA
% camber (zero-lift alpha) aka aerodynamic twist    
% sectional lift slope          SLS


% Unpack inputs
c_r = chord(1);
c_t = chord(2);

twist_r = deg2rad(GTA(1));
twist_t = deg2rad(GTA(2));

alpha0_r = deg2rad(camber(1));
alpha0_t = deg2rad(camber(2));

a0_r = SLS(1);   % [1/rad]
a0_t = SLS(2);

% -------------------------------
% Output 1: taper ratio
taperRatio = c_t / c_r;

% -------------------------------
% Fourier series order for PLLT
N = 3;

% Collocation points
j = (1:N)';
theta = (2*j - 1) * pi/(2*N);

% Spanwise coordinate from 0 (root) to 1 (tip)
eta = (1 - cos(theta)) / 2;

% Linear spanwise distributions
c     = c_r     + (c_t     - c_r)     * eta;   % chord
twist = twist_r + (twist_t - twist_r) * eta;   % geometric twist
alpha0 = alpha0_r + (alpha0_t - alpha0_r) * eta; % zero-lift AoA
a0    = a0_r    + (a0_t    - a0_r)    * eta;   % sectional lift slope

% Effective AoA (global = 0 for PLLT)
alpha = 0;
alpha_eff = alpha - twist - alpha0;   % Nx1

% -------------------------------
% Build PLLT linear system
B = zeros(N,N);
for i = 1:N
    for n = 1:N
        B(i,n) = sin(n*theta(i)) * ...
                 ( a0(i)/(AR * (c(i)/c_r)) + n/sin(theta(i)) );
    end
end

% Solve for Fourier coefficients A_n
A = B \ alpha_eff;

% -------------------------------
% Compute induced-drag factor δ
n = (1:N)';
delta = ( sum( n .* A.^2 ) )/A(1)^2 - 1;




end

