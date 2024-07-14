clc

% Define the known data
F1 = 2000; % Molar flow of stream 1 (kmol/h)
F2 = 4000; % Molar flow of stream 2 (kmol/h)
F3 = 14348; % Molar flow rate of stream 3 (kmol/h)
F4 = 11909.5; % Molar flow rate of stream 4 (kmol/h)
F5 = 8787.2; % Molar flow of stream 5 (kmol/h)
T1 = 210; % Temperature of stream 1 (oC)
T2 = 210; % Temperature of stream 2 (oC)
T4 = 210; % Temperature of stream 4 (oC)
T5 = 40; % Temperature of stream 5 (oC)
Q_C1 = 0; % Initialize cooling requirement of cooler C1 (kW)

% Stream temperatures in degrees Celsius
temperatures = [T1; T2; NaN; 210; 40]; % NaN for T3 which is to be calculated

% Initialize cooling requirement of cooler C1 (kW)
Q_C1 = 0;


% Call the enthalpy functions with the temperature range of interest
% Here Tmin and Tmax are taken from the stream temperatures T1 and T5
dh_H2 = enthalpy_H2(T5, T1);
dh_CO2 = enthalpy_CO2(T5, T1);
dh_CH3OH = enthalpy_CH3OH(T5, T1);
dh_H2O = enthalpy_H2O(T5, T1);

% Molar flow rates in kmol/h for each component in stream 2
% These will be used in conjunction with enthalpy changes for energy balance
F_CO2 = 0; % No CO2 in stream 2
F_H2 = F2; % All of stream 2 is H2
F_CH3OH = 0; % No CH3OH in stream 2
F_H2O = 0; % No H2O in stream 2


% Display the results
fprintf('Estimated temperature of stream 3: %.2f °C\n', T3);
fprintf('Cooling requirement of cooler C1: %.2f kW\n', Q_C1 / 1000); % Convert J/h to kW


% Functions for enthalpy calculation of each component
function dh_CO2 = enthalpy_CO2(Tmin,Tmax)
    fun1 = @(T) 36.11*10^(-3) + 4.23*10^(-5)*T - 2.88*10^(-8)*T.^2 + 7.46*10^(-12)*T.^3;
    dh_CO2 = integral(fun1,Tmin,Tmax) * 1000; % Convert from kJ/mol to J/mol
end

function dh_H2 = enthalpy_H2(Tmin,Tmax)
    fun = @(T) 28.84*10^(-3) + 0.00765*10^(-5)*T + 0.3288*10^(-8)*T.^2 - 0.8698*10^(-12)*T.^3;
    dh_H2 = integral(fun,Tmin,Tmax) * 1000; % Convert from kJ/mol to J/mol
end

function dh_H2O = enthalpy_H2O(Tmin,Tmax)
    fun = @(T) 33.46*10^(-3) + 0.6880*10^(-5)*T + 0.7604*10^(-8)*T.^2 - 3.593*10^(-12)*T.^3;
    dh_H2O = integral(fun,Tmin,Tmax) * 1000; % Convert from kJ/mol to J/mol
end

function dh_CH3OH = enthalpy_CH3OH(Tmin,Tmax)
    fun = @(T) 75.86*10^(-3) + 16.83*10^(-5)*T;
    dh_CH3OH = integral(fun,Tmin,Tmax) * 1000; % Convert from kJ/mol to J/mol
end


