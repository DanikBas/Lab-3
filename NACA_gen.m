
function [xU1,yU1, xL1,yL1, xU2,yU2, xL2,yL2] = NACAgen(code, c, n)

% writing a NACA function
% n is number of panels 
% c is chord length

% OUTPUT: 

% x is position along the cordline MAYBE FIX THIS
% x = c/(n+1);
x = (c/n)+1;

% parts of inputted NACA code
m = (code(1)) / 100;   % max camber
p = (code(2)) / 10;    % location of max camber
t = (code(3)) / 100; % thickness ratio


% thickness
yt = 5 * t * (0.2969*sqrt(x/c) - 0.1260*(x/c) - 0.3516*(x/c).^2 + 0.2843*(x/c).^3 - 0.1015*(x/c).^4);


% mean camber line

yc1 = m*(x/p^2) * (2*p - (x/c));    % use for 0 <= x < p*c
yc2 = m*(c-x/(1-p)^2) * (1+ x/c -2*p);  % use for p*c <= x <= c

% maybe change this to @x
%yc = piecewise(0 <=x< p*c, yc1, p*c <=x<= c, yc2 );


% surface coords
% local angle xi (squiggle)
xi1 = atan( diff(yc1)/diff(x) );
xi2 = atan( diff(yc2)/diff(x) );

% upper x coordinates- split for position on chord
xU1 = x - yt*sin(xi1);
xU2 = x - yt*sin(xi2);

% lower x coordinates
xL1 = x + yt*sin(xi1);
xL2 = x + yt*sin(xi2);

% upper y coordinates - split for position on chord
yU1 = yc1 + yt*cos(xi1);
yU2 = yc2 + yt*cos(xi2);

% lower y coordinates 
yL1 = yc1 + yt*cos(xi1);
yL2 = yc2 + yt*cos(xi2);

end