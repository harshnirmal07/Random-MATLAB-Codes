% Load data for CH3OH and H2O
data_CH3OH = readmatrix('data_pvap.xlsx', 'Sheet', 'CH3OH');
data_H2O = readmatrix('data_pvap.xlsx', 'Sheet', 'H2O');

% Preprocess data for CH3OH and H2O
data_CH3OH(:, 2) = log(data_CH3OH(:, 2));
data_H2O(:, 2) = log(data_H2O(:, 2));

% Split data into training and testing sets
ch3oh_partition = cvpartition(length(data_CH3OH), 'HoldOut', 0.30);
h2o_partition = cvpartition(length(data_H2O), 'HoldOut', 0.30);

train_data_ch3oh = data_CH3OH(training(ch3oh_partition), :);
test_data_ch3oh = data_CH3OH(test(ch3oh_partition), :);

train_data_h2o = data_H2O(training(h2o_partition), :);
test_data_h2o = data_H2O(test(h2o_partition), :);

% Fit linear regression models for CH3OH and H2O
model_ch3oh = fitlm(train_data_ch3oh(:, 1), train_data_ch3oh(:, 2));
model_h2o = fitlm(train_data_h2o(:, 1), train_data_h2o(:, 2));

% Plot linear regression models
figure(1);
plot(model_ch3oh);
title('Linear Regression Model for CH3OH');

figure(2);
plot(model_h2o);
title('Linear Regression Model for H2O');

% Parameters and equations of state for molar volume
R = 8.314;  % Universal gas constant in J/(mol·K)
T = 210 + 273.15;  % Temperature in K
P = 78 * 1e5;  % Pressure in Pa

% Parameters for equations of state from Table 1
params_RK = [-0.5, 1, 0, 0.08664, 0.42748];
params_PR_CO2 = [1 + (0.37464 + 1.54226 * 0.225 - 0.26992 * 0.225^2) * (1 - (T / 304.15)^0.5)^2, 1 + sqrt(2), 1 - sqrt(2), 0.0778, 0.45724];
params_PR_H2 = [1 + (0.37464 + 1.54226 * (-0.22) - 0.26992 * (-0.22)^2) * (1 - (T / 33.18)^0.5)^2, 1 + sqrt(2), 1 - sqrt(2), 0.0778, 0.45724];

% Using fsolve to solve the RK and PR equations for molar volume
options = optimset('Display', 'off');  % Set display off for fsolve

% Redlich-Kwong (RK) for CO2
b_RK_CO2 = params_RK(4) * R * 304.15 / (params_RK(1) * 7.38 * 1e5);
V_RK_CO2 = fsolve(@(V) (R * T / P) + b_RK_CO2 - (params_RK(5) / (R * T * P * V)) + (b_RK_CO2 * params_RK(5) / (R * T * P * V)), R * T / P, options);

% Peng-Robinson (PR) for CO2
b_PR_CO2 = params_PR_CO2(4) * R * 304.15 / (params_PR_CO2(1) * 7.38 * 1e5);
V_PR_CO2 = fsolve(@(V) (R * T / P) + b_PR_CO2 - (params_PR_CO2(5) / (R * T * P * V)) + (b_PR_CO2 * params_PR_CO2(5) / (R * T * P * V)), R * T / P, options);

% Peng-Robinson (PR) for H2
b_PR_H2 = params_PR_H2(4) * R * 33.18 / (params_PR_H2(1) * 12.93 * 1e5);
V_PR_H2 = fsolve(@(V) (R * T / P) + b_PR_H2 - (params_PR_H2(5) / (R * T * P * V)) + (b_PR_H2 * params_PR_H2(5) / (R * T * P * V)), R * T / P, options);

% Plot actual vs. predicted ln(pvap) for CH3OH
y_pred_CH3OH = predict(model_ch3oh, test_data_ch3oh(:, 1));
figure(3);
scatter(test_data_ch3oh(:, 1), test_data_ch3oh(:, 2), 'b', 'DisplayName', 'Actual');
hold on;
plot(test_data_ch3oh(:, 1), y_pred_CH3OH, 'r', 'DisplayName', 'Predicted');
xlabel('ln(Temperature)');
ylabel('ln(pvap_CH3OH)');
legend('Location', 'best');
title('CH3OH: Predicted vs. Actual ln(pvap)');

% Plot actual vs. predicted ln(pvap) for H2O
y_pred_H2O = predict(model_h2o, test_data_h2o(:, 1));
figure(4);
scatter(test_data_h2o(:, 1), test_data_h2o(:, 2), 'b', 'DisplayName', 'Actual');
hold on;
plot(test_data_h2o(:, 1), y_pred_H2O, 'r', 'DisplayName', 'Predicted');
xlabel('ln(Temperature)');
ylabel('ln(pvap_H2O)');
legend('Location', 'best');
title('H2O: Predicted vs. Actual ln(pvap)');

%Calculated Values
disp('1. Parameters A and B for CH3OH using linear regression:');
disp('   A_CH3OH = ' + string(model_ch3oh.Coefficients.Estimate(2)));
disp('   B_CH3OH = ' + string(-model_ch3oh.Coefficients.Estimate(1)));

disp('2. Parameters A and B for H2O using linear regression:');
disp('   A_H2O = ' + string(model_h2o.Coefficients.Estimate(2)));
disp('   B_H2O = ' + string(-model_h2o.Coefficients.Estimate(1)));

disp('3. Root mean squared error (RMSE) for CH3OH:');
disp('   RMSE_CH3OH = ' + string(sqrt(model_ch3oh.MSE)));

disp('4. Root mean squared error (RMSE) for H2O:');
disp('   RMSE_H2O = ' + string(sqrt(model_h2o.MSE)));

disp('5. Molar volume of CO2 using Redlich-Kwong (RK) equation of state:');
disp('   V_RK_CO2 = ' + string(V_RK_CO2) + ' m^3/mol');

disp('6. Molar volume of CO2 using Peng-Robinson (PR) equation of state:');
disp('   V_PR_CO2 = ' + string(V_PR_CO2) + ' m^3/mol');

disp('7. Molar volume of H2 using Peng-Robinson (PR) equation of state:');
disp('   V_PR_H2 = ' + string(V_PR_H2) + ' m^3/mol');

