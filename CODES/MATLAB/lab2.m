%%Methanol Synthesis HarshNirmal_220431 LAB2
% Given data
molarFlowRate7 = 893.263;

% Mole fractions of streams 3 - 7
moleFractions = [
    0.176 0.243 0.744 0 0.002;
    0.53 0.752 0.027 0 0;
    0.147 0.004 0.188 0 0.987;
    0.147 0.001 0.041 1 0.011
];

% Coefficient matrix of Mass-Balance equations
massBalanceCoeffMatrix = [
    0.176 -0.243 -0.744 0;
    0.53 -0.752 -0.027 0;
    0.147 -0.004 -0.188 0;
    0.147 -0.001 -0.041 -1
];

% Constants w.r.t. to the Mass-Balance equations
constants = [moleFractions(1, 5) * molarFlowRate7; 0;moleFractions(3, 5)*molarFlowRate7 ;moleFractions(4, 5)*molarFlowRate7];

% Solve the mass balance equation
solution = linsolve(massBalanceCoeffMatrix, constants);


% Initialize arrays
methanolFlowRates = 500:1:1500;
numPoints = numel(methanolFlowRates);
resultantMoleFractions = zeros(4, numPoints);

% Calculate resultant mole fractions
for idx = 1:numPoints
    temp = [moleFractions(1, 5) * methanolFlowRates(idx); 0; methanolFlowRates(idx) * moleFractions(3, 5); methanolFlowRates(idx) * moleFractions(4, 5)];
    resultantMoleFractions(:, idx) = linsolve(massBalanceCoeffMatrix, temp);
end



% Define constants for cost equations
CF1 = 182100;
CF2 = 171200;
CF3 = 1725400;

% Base case flow rates
%Molar flow rates of streams 3,4a,5a
F3_base = solution(1);
F4a_base = solution(2);
F5a_base = solution(3);
F6_base= solution(4);

F4a_base;
F5a_base;
% Initialize arrays for cost calculation
costF1 = zeros(1, numPoints);
costF2 = zeros(1, numPoints);
costD1 = zeros(1, numPoints);

% Calculate costs for each flow rate
for idx = 1:numPoints
    costF1(idx) = CF1 * (resultantMoleFractions(1, idx) / F3_base) ^ 0.6;
    costF2(idx) = CF2 * ((resultantMoleFractions(1, idx) - resultantMoleFractions(2, idx)) / (F3_base - F4a_base)) ^ 0.6;
    costD1(idx) = CF3 * ((resultantMoleFractions(1, idx) - resultantMoleFractions(2, idx) - resultantMoleFractions(3, idx)) / (F3_base - F4a_base - F5a_base)) ^ 0.6;
end

% Calculate total capital cost
totalCapitalCost = costF1 + costF2 + costD1;

% Create a plot
figure;
plot(methanolFlowRates, totalCapitalCost, 'y');
xlabel('Methanol Flow Rate (kmol/hr)');
ylabel('Total Capital Cost of Separation Equipment ($)');
title('Total Capital Cost vs. Methanol Flow Rate');
legend('Total Capital Cost');
grid on;

% Display the figure
legend('Location', 'best');
