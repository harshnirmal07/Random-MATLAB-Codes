%% Plotting

x = [0 0.02 0.04 0.06 0.08 0.10 0.20 0.30 0.40 0.50 0.60 0.70 0.80 0.90 0.95 1.0];
y = [0 0.134 0.23 0.304 0.365 0.418 0.579 0.665 0.729 0.779 0.825 0.87 0.915 0.958 0.979 1];

% Fit the x-y data to the functional form
ft = fittype('a*x/(1+b*x+c*x^2)', 'independent', 'x', 'dependent', 'y');
opts = fitoptions('Method', 'NonlinearLeastSquares');
opts.StartPoint = [0.5 0.5 0.5];
[fitted_curve, gof] = fit(x', y', ft, opts);


% Plot the fitted curve and the tabulated data
figure(1);
plot(fitted_curve, x, y);
title('Figure 1: Fitted Curve and Tabulated Data');
xlabel('x');
ylabel('y');
legend('Fitted Curve', 'Tabulated Data');

% Perform an overall material balance to obtain the values of D and W
F = 500; % feed rate in kmol/hr
zF = 0.45; % mole fraction of methanol in the feed
xD = 0.97; % mole fraction of methanol in the distillate
xW = 0.02; % mole fraction of methanol in the bottom product
S = 50; % sidestream rate in kmol/hr
xs = 0.70; % mole fraction of methanol in the sidestream
q = 0.8;

D = (F*zF - F*xW - S*xs) / (xD - xW); % distillate rate in kmol/hr
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
legend('Fitted Curve', 'Points D, W, S, F');


% Determine the equation of the feed line and plot this line in the same figure

% Given data
zF = 0.45; % mole fraction of methanol in the feed
xF = zF; % assume the feed is on the equilibrium curve
yF = ( 7.9673.*xs)./(1+9.4109.*xs + (-2.4383).*xs.*xs);

% Calculate slope of feed line
m_feed = (xD - yF) / (xD - xs);


% Calculate intercept of feed line
b_feed = xD - m_feed * xD;

% Plot the feed line
x_feed_line = linspace(0, 1, 100);
y_feed_line = m_feed * x_feed_line + b_feed;
plot(x_feed_line, y_feed_line, 'g--', 'LineWidth', 2);
legend('Fitted Curve', 'Points D, W, S, F', 'Feed Line');

% Determine the equation of the side-stream line and plot this line in the same figure
% Given data
yS = xs; % assume the side-stream is on the equilibrium curve
xS = xs; % mole fraction of methanol in the sidestream

% Calculate slope of side-stream line
m_side_stream = (xD - yS) / (xD - xS);

% Calculate intercept of side-stream line
b_side_stream = yS - m_side_stream * xS;

% Plot the side-stream line
x_side_stream_line = linspace(0, 1, 100);
y_side_stream_line = m_side_stream * x_side_stream_line + b_side_stream;
plot(x_side_stream_line, y_side_stream_line, 'm--', 'LineWidth', 2);
legend('Fitted Curve', 'Points D, W, S, F', 'Feed Line', 'Side-stream Line');

%Calculate the pinch point of this system and from this calculate the minimum and actual reflux ratio
% Calculate pinch point
pinch_point_x = (b_side_stream - b_feed) / (m_feed - m_side_stream);
pinch_point_y = m_feed * pinch_point_x + b_feed;

% Plot the pinch point
plot(pinch_point_x, pinch_point_y, 'ko', 'MarkerSize', 10);
legend('Fitted Curve', 'Points D, W, S, F', 'Feed Line', 'Side-stream Line', 'Pinch Point', 'Location', 'NorthWest');

% Calculate minimum reflux ratio
minimum_reflux_ratio = m_feed/(1-m_feed);

% Calculate actual reflux ratio (given as 2.5 times the minimum)
actual_reflux_ratio = 2.5 * minimum_reflux_ratio;

% Calculate the actual liquid and vapour flow rates in Section I, and use them to obtain the operating line in this section.
% Calculate liquid and vapor flow rates in Section I
L_I = D*actual_reflux_ratio;
V_I = actual_reflux_ratio*D;

% Calculate liquid and vapor flow rates in Section II
L_II = S / (m_side_stream - 1);
V_II = L_II + S;

% Calculate liquid and vapor flow rates in Section III
L_III = W;
V_III = F;

% Determine operating lines in each section (slope = L/V ratio)
m_operating_line_I = L_I / (V_I - D);
m_operating_line_II = L_II / (V_II - S);
m_operating_line_III = L_III / (V_III - W);

% Plot operating lines in each section
x_operating_line_I = linspace(0, 1, 100);
y_operating_line_I = m_operating_line_I * x_operating_line_I;
plot(x_operating_line_I, y_operating_line_I, 'b-', 'LineWidth', 2);

x_operating_line_II = linspace(0, 1, 100);
y_operating_line_II = m_operating_line_II * x_operating_line_II + (1 - m_operating_line_II) * xS;
plot(x_operating_line_II, y_operating_line_II, 'c-', 'LineWidth', 2);

x_operating_line_III = linspace(0, 1, 100);
y_operating_line_III = m_operating_line_III * x_operating_line_III + (1 - m_operating_line_III) * xW;
plot(x_operating_line_III, y_operating_line_III, 'r-', 'LineWidth', 2);

legend('Fitted Curve', 'Points D, W, S, F', 'Feed Line', 'Side-stream Line', 'Pinch Point', 'Operating Lines');


%% Calculations for various sections
% Calculate liquid and vapor flow rates in Section I
L_I = D / actual_reflux_ratio;
V_I = L_I + D;

% Calculate liquid and vapor flow rates in Section II
L_II = S / (m_side_stream - 1);
V_II = L_II + S;

% Calculate liquid and vapor flow rates in Section III
L_III = W;
V_III = F;

% Determine operating lines in each section (slope = L/V ratio)
m_operating_line_I = L_I / (V_I - D);
m_operating_line_II = L_II / (V_II - S);
m_operating_line_III = L_III / (V_III - W);

% Plot operating lines in each section
x_operating_line_I = linspace(0, 1, 100);
y_operating_line_I = m_operating_line_I * x_operating_line_I;
plot(x_operating_line_I, y_operating_line_I, 'b-', 'LineWidth', 2);

x_operating_line_II = linspace(0, 1, 100);
y_operating_line_II = m_operating_line_II * x_operating_line_II + (1 - m_operating_line_II) * xS;
plot(x_operating_line_II, y_operating_line_II, 'c-', 'LineWidth', 2);

x_operating_line_III = linspace(0, 1, 100);
y_operating_line_III = m_operating_line_III * x_operating_line_III + (1 - m_operating_line_III) * xW;
plot(x_operating_line_III, y_operating_line_III, 'r-', 'LineWidth', 2);

legend('Fitted Curve', 'Points D, W, S, F', 'Feed Line', 'Side-stream Line', 'Pinch Point', 'Operating Lines');






