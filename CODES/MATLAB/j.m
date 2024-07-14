% Coefficient Matrix
Coeff = [1 0 0 0 0 0 0 0;
         0.7783 -1 0 0 0 0 0 0;
         0 1 -1 -1 0 0 0 0;
         -0.5529 0 1 0 0 0 0 0;
         0 0 0 1 -1 -1 0 0;
         0 0 0 0 0 1 -1 -1;
         -0.2176 0 0 0 0 0 1 0;
         -0.10946 0 0 0 0 0 0 1];
     
% Right-hand side vector
Res = [6000; 0; 0; 3.103; 0; 0; -3.06469; -0.36469];

% Solve for stream molar flow rates
Sol = linsolve(Coeff, Res);

% Stream Molar Flow Rates
a3 = Sol(1);
A4 = [(1 - 33.25 / 100); (2 - 3 * 33.25 / 100); 33.25 / 100; 33.25 / 100] * a3;
a4 = Sol(2);
A5 = [A4(1:3) .* [97.2 / 100; 99.97 / 100; 2.35 / 100]; 3.103];
a5 = Sol(3);
A6 = A4 - A5;
a6 = Sol(4);
A8 = zeros(4, 1);
Ratio = [31.89; 0; 1.0125; 1.00265];

% Calculate A8
for i = 1:4
    if i == 2
        A8(i) = 0;
    else
        A8(i) = A6(i) / Ratio(i);
    end
end

a8 = Sol(6);
A7 = A6 - A8;
a7 = Sol(5);
A9 = [A8(1:3); 0];
a9 = Sol(7);
A10 = A8 - A9;
a10 = Sol(8);

% Masses of substances
m_CO2 = 44 * 2000;
m_H2 = 2 * 2 * 2000;
m_CH3OH = 32 * A9(3);

% CO2 and H2 cost ranges
Cost_CO2 = m_CO2 * linspace(0.025, 1, 10);
Cost_H2 = m_H2 * linspace(0.5, 2, 10);

% Capital recovery factor
Phi = 0.1;

% Power data
Power = [9.7, 0, 12;
         21.5, 0, 20.9;
         0, 0.28, 0;
         0, 0, 22.6;
         0, 0, 0;
         0, 0, 0;
         0, 0.8, 0;
         0, 15.7, 15.4];

% Calculate power costs
Power_costs = zeros(8, 3);
Power_costs(:, 1) = Power(:, 1) * 10^3 * 7884 * 0.072;
Power_costs(:, 2) = Power(:, 2) * 10^3 * 7884 * 2.5 * 3.6;
Power_costs(:, 3) = Power(:, 3) * 10^3 * 7884 * 0.212 * 3.6;

% Capital costs
Capital_costs = [14696200, 29418000, 1.53 * 10^7 * ((A4(1) * 44 + A4(2) * 2 + A4(3) * 32 + A4(4) * 18) / 54000)^0.65, 269600, 171300, 168100, 63000, 1507900];

% Calculate total annual cost (TAC)
Cop = sum(Power_costs(:));
Ccap = sum(Capital_costs);
TAC = Phi * Ccap + Cop;

% Calculate the cost of methanol production (CMethanol) in $/tonne
CMethanol = TAC * 1000 / m_CH3OH;

% Create the contour plot
[X, Y] = meshgrid(Cost_CO2, Cost_H2);
Cost_CH3OH = ((Phi * Ccap + Cop) * ones(10, 10) + X + Y) * 1000 / m_CH3OH;
contourf(X, Y, Cost_CH3OH', 50, 'LineStyle', 'none');
colorbar;
xlabel('CO2 Price ($/kg)');
ylabel('H2 Price ($/kg)');
title('Methanol Production Cost Contour Plot ($/tonne)');