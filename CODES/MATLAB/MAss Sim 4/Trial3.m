% Given data
x = [0 0.02 0.04 0.06 0.08 0.10 0.20 0.30 0.40 0.50 0.60 0.70 0.80 0.90 0.95 1.0];
y = [0 0.134 0.23 0.304 0.365 0.418 0.579 0.665 0.729 0.779 0.825 0.87 0.915 0.958 0.979 1];

% Fit the x-y data to the functional form
ft = fittype('a*x/(1+b*x+c*x^2)', 'independent', 'x', 'dependent', 'y');
opts = fitoptions('Method', 'NonlinearLeastSquares');
opts.Display = 'Off';
opts.StartPoint = [0.5 0.5 0.5];
[fitted_curve, gof] = fit(x', y', ft, opts);

% Plot the fitted curve and the tabulated data
figure(1);
plot(fitted_curve, x, y);
title('Figure 1: Fitted Curve and Tabulated Data');
xlabel('x');
ylabel('y');
legend('Fitted Curve', 'Tabulated Data', 'Location', 'NorthWest');

% Perform an overall material balance to obtain the values of D and W
F = 500; % feed rate in kmol/hr
zF = 0.45; % mole fraction of methanol in the feed
xD = 0.97; % mole fraction of methanol in the distillate
xW = 0.02; % mole fraction of methanol in the bottom product
S = 50; % sidestream rate in kmol/hr
xs = 0.70; % mole fraction of methanol in the sidestream

D = (F*zF - S*xs) / (xD - xW); % distillate rate in kmol/hr
W = F - D - S; % bottom product rate in kmol/hr

% Plot the fitted equilibrium curve, locate the points D(xD, xD), W(xw, xw), S(xs, xs) and F(zF,zF,) on Figure 2
figure(2);
plot(fitted_curve, x, y);
hold on;
plot(xD, xD, 'ro');
text(xD, xD, 'D');
plot(xW, xW, 'ro');
text(xW, xW, 'W');
plot(xs, xs, 'ro');
text(xs, xs, 'S');
plot(zF, zF, 'ro');
text(zF, zF, 'F');
title('Figure 2: Fitted Equilibrium Curve and Points D, W, S, F');
xlabel('x');
ylabel('y');
legend('Fitted Curve', 'Points D, W, S, F', 'Location', 'NorthWest');

% Overall material balance
F = 500; % Total feed rate (kmol/hr)
xF = 0.45; % Mole fraction of methanol in feed
DF = F * xF; % methanol in distillate
W = F * (1 - xF); % methanol in bottoms
xB = 0.45; % Mole fraction of methanol in feed
yD = 0.97;
xWv = 0.02;

% Define points D, W, S, F
xD = 0.97; % Mole fraction of methanol in distillate
xW = 0.02; % Mole fraction of methanol in bottoms
xS = 0.70; % Mole fraction of methanol in sidestream
zF = 0.45; % Mole fraction of methanol in feed

% Plotting the points on the equilibrium curve
figure(2);
plot(x_fit, y_fit, '-');
hold on;
plot(xD, xD, 'ro', xW, xW, 'bo', xS, xS, 'go', zF, zF, 'ko');
xlabel('x (Mole fraction of methanol)');
ylabel('y (Mole fraction of methanol)');
title('McCabe-Thiele Construction');
legend('Fitted curve', 'D', 'W', 'S', 'F');

% Determine the equation of feed line
slope_feed = (xD - zF) / (xD - xF);
y_feed = slope_feed * x_fit + (zF - slope_feed * xF);

% Plotting the feed line
plot(x_fit, y_feed, '--');
legend('Fitted curve', 'D', 'W', 'S', 'F', 'Feed line');
hold off;

% Determine the equation of side-stream line
slope_side = (xS - xW) / (xS - xD);
y_side = slope_side * x_fit + (xW - slope_side * xD);

% Plotting the side-stream line
figure(2);
plot(x_fit, y_fit, '-', x_fit, y_side, '--');
hold on;
plot(xD, xD, 'ro', xW, xW, 'bo', xS, xS, 'go', zF, zF, 'ko');
xlabel('x (Mole fraction of methanol)');
ylabel('y (Mole fraction of methanol)');
title('McCabe-Thiele Construction');
legend('Fitted curve', 'Side-stream line', 'D', 'W', 'S', 'F');
hold off;

% Use the side-stream line to determine the pinch point of this system
pinch_x = (xW - zF) / (slope_feed - slope_side);
pinch_y = slope_feed * pinch_x + (zF - slope_feed * xF);

% Calculate minimum and actual reflux ratio
min_rr = abs((xW - xD) / (xD - xB));

actual_rr = 2.5 * (min_rr);

q = (xD - xB) / (yD - xWv); % Quality

% Operating lines in Section I, II, III
% Section I - Condenser, reflux drum and stages prior to sidestream removal stage
slope_op_I = actual_rr + 1;
y_op_I = slope_op_I * x_fit + pinch_y - slope_op_I * pinch_x;

% Section II - Sidestream stage and stages prior to feed stage
slope_op_II = (xD - xS) / (xD - pinch_x);
y_op_II = slope_op_II * x_fit + (xS - slope_op_II * xD);

% Section III - Feed stage and stages below along with reboiler
slope_op_III = (xD - xW) / (xD - zF);
y_op_III = slope_op_III * x_fit + (xW - slope_op_III * xD);

% Plotting the operating lines
figure(2);
plot(x_fit, y_fit, '-', x_fit, y_side, '--', x_fit, y_op_I, '-.', x_fit, y_op_II, ':', x_fit, y_op_III, '-');
hold on;
plot(xD, xD, 'ro', xW, xW, 'bo', xS, xS, 'go', zF, zF, 'ko');
xlabel('x (Mole fraction of methanol)');
ylabel('y (Mole fraction of methanol)');
title('McCabe-Thiele Construction');
legend('Fitted curve', 'Side-stream line', 'Operating line I', 'Operating line II', 'Operating line III', 'D', 'W', 'S', 'F');
hold off;


xR = 0.8;

% McCabe-Thiele construction to determine the number of ideal trays
% Locate feed tray and sidestream tray
% N = (min_rr + 1) * log((xD - xW) / ((xR - xW) * (q - 1))) / log(q);
% feed_tray = ceil(N);
% sidestream_tray = ceil((xD - (xW - (xD - xW) / (xD - xB))) / (slope_op_II - (xD - xW) / (xD - xB)));

% McCabe-Thiele construction to determine the number of ideal trays
% Locate feed tray and sidestream tray
% McCabe-Thiele construction to determine the number of ideal trays
% Locate feed tray and sidestream tray
% McCabe-Thiele construction to determine the number of ideal trays
% McCabe-Thiele construction
% Initial point: Feed (F)


