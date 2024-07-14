% Lab-6

% Constants for CH3OH
A_CH3OH = 24.858;
B_CH3OH = 4512.9;

% Constants for CO2
A_CO2 = 22.36;
B_CO2 = 1992.9;

% Constants for H2O
A_H2O = 24.724;
B_H2O = 4949.6;

% Pressure for H2
P_H2 = 1.44 * 1e9;

% Temperature
T = 483;
e = 2.718;

% Part A: P-x-y plot for binary mixture
x = 0:0.001:1;
n = size(x, 2);

P_CH3OH = exp(A_CH3OH - B_CH3OH / T);
P_CO2 = exp(A_CO2 - B_CO2 / T);

P_Total = zeros(1, n);
y = zeros(1, n);

for i = 1:n
    P_Total(i) = (P_CH3OH - P_CO2) * (x(i)) + P_CO2;
    y(i) = P_CH3OH * x(i) / (P_Total(i));
end

figure; % New figure for Part A
plot(x, P_Total, y, P_Total);
xlabel('Mole Fraction of CH3OH');
ylabel('Total Pressure');
title('P-x-y plot for binary mixture');

% Part B: T-x-y plot for binary mixture
y = 0:0.001:1;
n = size(y, 2);

P_Total = 78 * 1e5;  % Pressure in Nm^-2
Ti = zeros(n, 1);
xi = zeros(n, 1);
P_CH3OH = zeros(n, 1);

for i = 1:n
    Ti(i) = fzero(@(t) Txy(A_CH3OH, B_CH3OH, A_CO2, B_CO2, P_Total, y(i), t), 300);
    P_CH3OH(i) = exp(A_CH3OH - B_CH3OH / Ti(i));
    xi(i) = (P_Total * y(i)) / (P_CH3OH(i));
end

figure; % New figure for Part B
plot(y, Ti, xi, Ti);
xlabel('Mole Fraction of CH3OH');
ylabel('Temperature');
title('T-x-y plot for binary mixture');

% Part C
Molp = 40;
idxy = 0;
idxx = 0;

for i = 1:n
    if abs(y(i) - Molp / 100) < 1e-6
        idxy = i;
        Ti(idxy);
    end

    if abs(x(i) - Molp / 100) < 1e-6
        idxx = i;
        Ti(idxx);
    end
end

T = 483;
if T > Ti(idxy)
    disp("Superheated");
end

if T < Ti(idxx)
    disp("Subcooled");
end

if T > Ti(idxx) && T < Ti(idxy)
    disp("Two-Phase");
end

% Rachford-Rice Procedure
F = 100;
z = zeros(4, 1);
k = zeros(4, 1);

z(1) = 0.12;
z(2) = 0.12;
z(3) = 0.25;
z(4) = 0.51;

% Define temperature and pressure scales for contour mesh
TGRAD = 273.15:1:500;
PGRAD = 1e5:1e5:78 * 1e5;

CO2_R = zeros(size(PGRAD, 2), size(TGRAD, 2));
CH3OH_R = zeros(size(PGRAD, 2), size(TGRAD, 2));
H2_R = zeros(size(PGRAD, 2), size(TGRAD, 2));
H2O_R = zeros(size(PGRAD, 2), size(TGRAD, 2));

for i = 1:size(PGRAD, 2)
    for j = 1:size(TGRAD, 2)
        F = 100;
        bpP = (bpPeq(z, TGRAD(j)));
        dpP = (dpPeq(z, TGRAD(j)));

        if (PGRAD(i) > bpP)
            psi = 0;
        end

        if (PGRAD(i) < dpP)
            psi = 1;
        end

        if (dpP <= PGRAD(i))
            if (PGRAD(i) <= bpP)
                psi = RRP(z, TGRAD(j), PGRAD(i));
            end
        end

        V = psi * F;
        L = F - V;
        k(3) = exp(A_CO2 - B_CO2 / TGRAD(j)) / PGRAD(i);
        k(1) = exp(A_CH3OH - B_CH3OH / TGRAD(j)) / PGRAD(i);
        k(2) = exp(A_H2O - B_H2O / TGRAD(j)) / PGRAD(i);
        k(4) = P_H2 / PGRAD(i);

        for l = 1:4
            x(l) = z(l) / (1 + psi * (k(l) - 1));
            y(l) = k(l) * x(l);
        end

        CO2_R(i, j) = y(3) * V / (z(3) * F);
        CH3OH_R(i, j) = x(1) * L / (z(1) * F);
        H2O_R(i, j) = x(2) * L / (z(2) * F);
        H2_R(i, j) = y(4) * V / (z(4) * F);
    end
end

PGRAD = PGRAD * 1e-5;

% Contour Plotting for CH3OH Recovery
figure;
contourf(TGRAD, PGRAD, CH3OH_R, 20);
colorbar;
xlabel('Temperature (K)');
ylabel('Pressure (bar)');
title('R3_C_H_3_O_H');

% Contour Plotting for H2O Recovery
figure;
contourf(TGRAD, PGRAD, H2O_R, 20);
colorbar;
xlabel('Temperature (K)');
ylabel('Pressure (bar)');
title('R3_H_2_O');

% Contour Plotting for CO2 Recovery
figure;
contourf(TGRAD, PGRAD, CO2_R, 20);
colorbar;
xlabel('Temperature (K)');
ylabel('Pressure (bar)');
title('R2_C_O_2');

% Contour Plotting for H2 Recovery
figure;
contourf(TGRAD, PGRAD, H2_R, 20);
colorbar;
xlabel('Temperature (K)');
ylabel('Pressure (bar)');
title('R2_H_2');


function y1 = Txy(a1, b1, a2, b2, P, y, Ti)
  
    y1 = (P * y / (exp(a1 - b1 / Ti)) + P * (1 - y) / (exp(a2 - b2 / Ti))) - 1;
end

function psit = RRP(z, T, Ptotal)
    Ach3oh = 24.858;
    Bch3oh = 4512.9;
    Aco2 = 22.36;
    Bco2 = 1992.9;
    Ah2o = 24.724;
    Bh2o = 4949.6;
    Ph2 = 1.44 * 1e9;
  
    k(3) = exp(Aco2 - Bco2 / T) / Ptotal;
    k(1) = exp(Ach3oh - Bch3oh / T) / Ptotal;
    k(2) = exp(Ah2o - Bh2o / T) / Ptotal;
    k(4) = Ph2 / Ptotal;

    val = @(psi) z(1) * (1 - k(1)) / (1 + psi * (k(1) - 1)) + z(2) * (1 - k(2)) / (1 + psi * (k(2) - 1)) + z(3) * (1 - k(3)) / (1 + psi * (k(3) - 1)) + z(4) * (1 - k(4)) / (1 + psi * (k(4) - 1));
    psit = fzero(val, 0.75);
end

function val = dpPeq(z, T)
    ACH3OH = 24.858;
    BCH3OH = 4512.9;
    ACO2 = 22.36;
    BCO2 = 1992.9;
    AH2O = 24.724;
    BH2O = 4949.6;
    PH2 = 1.44 * 1e9;
        
    val = (z(3)) / (exp(ACO2 - BCO2 / T)) + (z(1)) / (exp(ACH3OH - BCH3OH / T)) + (z(2)) / (exp(AH2O - BH2O / T)) + (z(4)) / PH2;
    val = 1 / val;
end

function val = bpPeq(z, T)
    Ach3oh = 24.858;
    Bch3oh = 4512.9;
    Aco2 = 22.36;
    Bco2 = 1992.9;
    Ah2o = 24.724;
    Bh2o = 4949.6;
    Ph2 = 1.44 * 1e9;

    val = (exp(Aco2 - Bco2 / T)) * z(3) + (exp(Ach3oh - Bch3oh / T)) * z(1) + (exp(Ah2o - Bh2o / T)) * z(2) + (Ph2) * z(4);
end
