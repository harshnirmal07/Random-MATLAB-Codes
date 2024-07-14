% Given data
F_CO2_1 = 2000; % Molar flow rate of CO2 in Stream 1 (kmol/hr)
Conversion = 0.30; % Reactor conversion
T_Cooler = 40; % Temperature after cooling (°C)

% Calculate the molar flow rate of H2 in Stream 2
F_H2_2 = 2 * F_CO2_1;

% Calculate the molar flow rates of CH3OH and H2O in Stream 3
F_CH3OH_3 = F_CO2_1 * (1 - Conversion);
F_H2O_3 = F_CO2_1 * (1 - Conversion);

% Calculate the actual molar flow rates of CH3OH and H2O in Stream 3
Actual_F_CH3OH_3 = F_CH3OH_3;
Actual_F_H2O_3 = F_H2O_3;

% Calculate the molar flow rates of CH3OH and H2O in Stream 4
F_CH3OH_4 = Actual_F_CH3OH_3;
F_H2O_4 = Actual_F_H2O_3;

% Calculate the molar flow rate of H2 in Stream 5
F_H2_5 = F_H2_2 - 0;

% Calculate the molar flow rates of CH3OH and H2O in Stream 5
F_CH3OH_5 = F_CH3OH_4;
F_H2O_5 = F_H2O_4;

% Calculate the molar flow rates of CH3OH, H2O, and H2 in Stream 5P
F_CH3OH_5P = 0.95 * F_CH3OH_5; %Recycled CH3OH in Stream 5P
F_H2O_5P = 0.95 * F_H2O_5;     %Recycled H2O in Stream 5P
F_H2_5P = 0.95 * F_H2_5;       %Recycled H2 in Stream 5P

% Calculate the molar flow rates of CH3OH and H2O in Stream 5R
F_CH3OH_5R = 0.05 * F_CH3OH_5; %recycled fractions are calculated as a percentage of the        flow rates in Stream 5
 
F_H2O_5R = 0.05 * F_H2O_5;


% Calculate the molar flow rate of H2 in Stream 6
F_H2_6 = F_H2_2 - F_H2_5 - 0;

% Calculate the molar flow rates of CH3OH and H2O in Stream 6
F_CH3OH_6 = F_CH3OH_5R;
F_H2O_6 = F_H2O_5R;




% Display the results
fprintf('Stream 1 (CO2): %f kmol/hr\n', F_CO2_1);
fprintf('Stream 2 (H2): %f kmol/hr\n', F_H2_2);
fprintf('Stream 3 (CH3OH): %f kmol/hr\n', F_CH3OH_3);
fprintf('Stream 3 (H2O): %f kmol/hr\n', F_H2O_3);
fprintf('Stream 4 (CH3OH): %f kmol/hr\n', F_CH3OH_4);
fprintf('Stream 4 (H2O): %f kmol/hr\n', F_H2O_4);
fprintf('Stream 5 (CH3OH): %f kmol/hr\n', F_CH3OH_5);
fprintf('Stream 5 (H2O): %f kmol/hr\n', F_H2O_5);
fprintf('Stream 5 (H2): %f kmol/hr\n', F_H2_5);
fprintf('Stream 5P (CH3OH): %f kmol/hr\n', F_CH3OH_5P);
fprintf('Stream 5P (H2O): %f kmol/hr\n', F_H2O_5P);
fprintf('Stream 5P (H2): %f kmol/hr\n', F_H2_5P);
fprintf('Stream 5R (CH3OH): %f kmol/hr\n', F_CH3OH_5R);
fprintf('Stream 5R (H2O): %f kmol/hr\n', F_H2O_5R);
fprintf('Stream 5R (H2): 0 kmol/hr\n');
fprintf('Stream 6 (CH3OH): %f kmol/hr\n', F_CH3OH_6);
fprintf('Stream 6 (H2O): %f kmol/hr\n', F_H2O_6);
fprintf('Stream 6 (H2): %f kmol/hr\n', F_H2_6);



