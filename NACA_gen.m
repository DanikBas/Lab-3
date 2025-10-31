
function [x, y] = NACAgen(code, c, n)

% writing a NACA function
% n is number of panels 
% c is chord length

% x is position along the cordline MAYBE FIX THIS
x = c/(n+1);

% parts of inputted NACA code
m = (code(1)) / 100;   % max camber
p = (code(2)) / 10;    % location of max camber
t = (code(3)) / 100; % thickness ratio


% thickness
yt = 5 * t * (0.2969*sqrt(x/c) - 0.1260*(x/c) - 0.3516*(x/c).^2 + 0.2843*(x/c).^3 - 0.1015*(x/c).^4);


% mean camber line

yc1 = m*(x/p^2) * (2*p - (x/c));
yc2 = m*(c-x/(1-p)^2) * (1+ x/c -2*p);

% maybe change this @x
%yc = piecewise(0 <=x< p*c, yc1, p*c <=x<= c, yc2 );


% surface coords

xi = arctan( diff(yc)/diff(x) );

xU = x - yt*sin(xi);
xL = x + yt*sin(xi);

yU1 = yc1 + yt*cos(xi);
yU2 = yc2 + yt*cos(xi);

yL1 = yc1 + yt*cos(xi);
yL2 = yc2 + yt*cos(xi);

end