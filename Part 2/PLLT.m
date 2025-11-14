function  [e,c_L,c_Di, delta] = PLLT(b,a0_t,a0_r,c_t,c_r,aero_t,aero_r,geo_t,geo_r,N)

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

% Aspect ratio calculation
S = b * (c_r + c_t) / 2;   % trapezoidal area (ft^2)
AR = b^2 / S;

% Solve for Fourier coefficients A_n
        odd = (1:2:(2*N-1))';            % N odd integers
        theta = odd * pi / (2*N);        % collocation angles (Nx1)
        
        % spanwise coordinate from 0 (root) to 1 (tip)
        eta = (1 - cos(theta)) / 2;
        % Linear chord distribution
        c = c_r + (c_t - c_r) * eta;
    
        % Zero-lift angle (aerodynamic twist)
        a0L = aero_r + (aero_t - aero_r) * eta;
    
        % Geometric AoA (twist + global AoA)
        geo = geo_r + (geo_t - geo_r) * eta;
    
        % Section lift-curve slope a0(y)
        a0 = a0_r + (a0_t - a0_r) * eta;
    
        % Effective angle of attack
        alpha_eff = geo - a0L;

        % Build lifting-line system matrix B (size N×N)
        B = zeros(N, N);
        
        for i = 1:N
            for j = 1:N
                n = odd(j);  % odd Fourier index (1,3,5,...)
                B(i,j) = sin(n * theta(i)) * ...
                         ( a0(i)/(AR * (c(i)/c_r)) + n / sin(theta(i)) );
            end
        end

A = B \ alpha_eff;

% delta (induced drag factor)
delta =0;
for n = 2:N
    temp = n * (A(n)/A(1))^2;
    delta = delta + temp;

%% Outputs
e = 1 / (1+delta); 
c_L = A(1)*pi*AR;
c_Di = c_L^2 * (1+delta) / (pi* AR);


end