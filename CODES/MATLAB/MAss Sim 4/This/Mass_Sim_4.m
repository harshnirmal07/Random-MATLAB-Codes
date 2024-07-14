clc
clear all


% Define data
x_given = [0 0.02 0.04 0.06 0.08 0.10 0.20 0.30 0.40 0.50 0.60 0.70 0.80 0.90 0.95 1.0];
y_given = [0 0.134 0.23 0.304 0.365 0.418 0.579 0.665 0.729 0.779 0.825 0.87 0.915 0.958 0.979 1];

% Initial guess for parameters
init_params = [1 2 1];

% Define function for curve fitting
fit_func = @(params, x) (params(1).*x)./(1 + params(2).*x + params(3).*x.^2);

% Perform curve fitting
fit_params = lsqcurvefit(fit_func, init_params, x_given, y_given);

% Calculate fitted y values
y_fitted = (fit_params(1).*x_given)./(1 + fit_params(2).*x_given + fit_params(3).*x_given.^2);

% Plot fitted curve and original data
figure
plot(x_given, y_fitted)
hold on
plot(x_given, y_given, '*')
title('Figure 1: Fitted Curve and Tabulated Data');
xlabel('x');
ylabel('y');
legend('Fitted Curve', 'Tabulated Data');


% Define system parameters
z = 0.45;
F = 500;
q = 0.8;
xD = 0.97;
xW = 0.2;

side_rate = 50;
x_side_rate = 0.70;
q_s = 1;

% Calculate distillate and bottom product rates
D = (F*z - F*xW - side_rate*x_side_rate + side_rate*xW) / (xD - xW);
W = F - D - side_rate;

% Calculate feed line
x_feed_line = linspace(0.3, 0.5, 100);
y_feed_line = x_feed_line * (q / (q - 1)) - z / (q - 1);

% Plot equilibrium curve, feed line, and points
figure
plot(x_given, y_fitted)
hold on
plot(x_given, x_given)
plot(xD, xD, 'ro')
plot(xW, xW, 'ro')
plot(z, z, 'ro')
plot(x_side_rate, x_side_rate, 'ro')
plot(x_feed_line, y_feed_line,'-')


title('Figure 2: Fitted Equilibrium Curve and Points D, W, S, F');
xlabel('x');
ylabel('y');

legend('Fitted Curve', 'Points D, W, S, F', 'Feed Line', 'Side-stream Line', 'Pinch Point', 'Operating Lines');

% Calculate intersection point
y_intersect = (fit_params(1).*x_side_rate)./(1 + fit_params(2).*x_side_rate + fit_params(3).*x_side_rate.^2);

% Calculate minimum and actual reflux ratios
slope = (xD - y_intersect) / (xD - x_side_rate);
min_reflux_ratio = slope / (1 - slope);
actual_reflux_ratio = 2.5 * min_reflux_ratio;

% Calculate operating lines and plot
Vap_flow_1 = (actual_reflux_ratio + 1) * D;
Liq_flow_1 = actual_reflux_ratio * D;
x_val = linspace(0.97, 0.7, 10);
y_val = (Liq_flow_1 / Vap_flow_1) * x_val + xD / (actual_reflux_ratio + 1);
plot(x_val, y_val)

%% Line 2
x_val1 = linspace(0.2, 0.7, 100);
y_val1 = ((Liq_flow_1 - side_rate) / Vap_flow_1) * x_val1 + (xD * D + side_rate * x_side_rate) / Vap_flow_1;
plot(x_val1, y_val1)

%% Line 3
Liq_flow_3 = F * q + Liq_flow_1 - side_rate;
Vap_flow_3 = (q - 1) * F + Vap_flow_1;
y_val2 = (Liq_flow_3 / Vap_flow_3) * x_val1 - W * xW / Vap_flow_3;
plot(x_val1, y_val2)




% McCabe-Thiele construction



% % Define parameters for McCabe-Thiele construction



% Display results
fprintf('Minimum reflux ratio: %.2f\n', min_reflux_ratio);
fprintf('Actual reflux ratio: %.2f\n', actual_reflux_ratio);
fprintf('Pinch Point: %d\n', slope);
