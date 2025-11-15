function [e, c_L, c_Di, delta] = PLLT(b,a0_t,a0_r,c_t,c_r,aero_t,aero_r,geo_t,geo_r,N)

% --- Aspect Ratio (do NOT convert to meters – keep consistent units)
S = b * (c_r + c_t)/2;
AR = b^2 / S;

% --- Correct collocation points ---
theta = ( (1:N)' ) * pi/(2*N);

% --- Spanwise interpolation (eta = 0→root, 1→tip) ---
y  = (b/2) * cos(theta);        % positive root → tip
eta = y / (b/2);                % = cos(theta)

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
delta = sum( odd(2:end) .* (A(2:end)/A1).^2 );

% --- Outputs ---
e    = 1/(1 + delta);
c_L  = pi * AR * A1;
c_Di = c_L^2 * (1 + delta) / (pi * AR);

end
