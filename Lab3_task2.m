clear; clc; close all;

alpha = 5;

panels_total = 4:2:200;

Cl = zeros(size(panels_total));

for i = 1:length(panels_total)

    panels = panels_total(i);
    points_per_surface = (panels/2) + 1;

    [xU, yU, xL, yL] = NACA_gen([0 0 12], 100, points_per_surface);
    x_b = [fliplr(xU), xL(2:end)];
    y_b = [fliplr(yU), yL(2:end)];
    % x_b = [xU, xL];
    % y_b = [yU, yL];

    

    Cl(i) = 1000*Vortex_Panel(x_b, y_b, alpha);
end


Panel99 = Find99Percent(panels_total, Cl);
Cl_final = Cl(end);
Cl_target = 0.99*Cl_final;

figure()
plot(panels_total, Cl)
hold on;
yline(Cl_target)
hold on;
xline(Panel99)
hold off;

%% One percent thing
function Cl99 = Find99Percent(panelsVec, Cl)
    panelsVec = panelsVec(1:length(Cl));
    Cl_final = Cl(end);
    Cl_target = 0.99 * Cl_final;

    idx = find(Cl >= Cl_target, 1, 'first');
    if ~isempty(idx)
        Cl99 = panelsVec(idx);
    else
        Cl99 = NaN;
    end
end
