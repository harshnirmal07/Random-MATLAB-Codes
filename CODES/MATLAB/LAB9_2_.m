% Flow rates definition
flow1 = [2000 0 0 0];
flow2 = [0 4000 0 0];
flow3 = [4064 10266.1 14.8 3.1];
flow4 = [2844.8 6608.5 1233.9 1222.3];
flow5 = [2172.6 6595.8 15.5 3.3];
reactFlow = flow3 - flow1 - flow2;
flow6 = flow4 - flow5;

% Vaporization data
bpMethanol = 64.7; heatVapMethanol = 35.37;
bpWater = 100; heatVapWater = 40.656;

%% Stream 1 calculations
temp1 = 210;
enthalpyCO2_1 = calcEnth_CO2(25, temp1);
enthalpy1 = [enthalpyCO2_1 0 0 0];
heat1 = flow1 .* enthalpy1;

%% Stream 2 calculations
temp2 = 210;
enthalpyH2_2 = calcEnth_H2(25, temp2);
enthalpy2 = [0 enthalpyH2_2 0 0];
heat2 = flow2 .* enthalpy2;

%% Reactant Stream calculations
tempReact = 40;
enthalpyR_CO2 = calcEnth_CO2(25, tempReact);
enthalpyR_H2 = calcEnth_H2(25, tempReact);
enthalpyR_Methanol = calcEnth_Methanol(25, bpMethanol) + heatVapMethanol + calcEnth_Methanol(bpMethanol, tempReact);
enthalpyR_Water = calcEnth_Water(25, bpWater) + heatVapWater + calcEnth_Water(bpWater, tempReact);
enthalpyReact = [enthalpyR_CO2 enthalpyR_H2 enthalpyR_Methanol enthalpyR_Water];
heatReact = reactFlow .* enthalpyReact;

% Solving for temperature of stream 3
opt = optimset("Display","off");
temp3 = fsolve(@(temp3) sum(flow3 .* [calcEnth_CO2(25, temp3) calcEnth_H2(25, temp3) calcEnth_Methanol(25, bpMethanol) + heatVapMethanol + calcEnth_Methanol(bpMethanol, temp3) calcEnth_Water(25, bpWater) + heatVapWater + calcEnth_Water(bpWater, temp3)]) - sum(heat1, "all") - sum(heat2, "all") - sum(heatReact, "all"), 0, opt);

%% Cooling duty of C1 calculation
% Stream 4 calculations
temp4 = 210;
enthalpy4 = [calcEnth_CO2(25, temp4) calcEnth_H2(25, temp4) calcEnth_Methanol(25, bpMethanol) + heatVapMethanol + calcEnth_Methanol(bpMethanol, temp4) calcEnth_Water(25, bpWater) + heatVapWater + calcEnth_Water(bpWater, temp4)];
heat4 = flow4 .* enthalpy4;

% Stream 5 calculations
temp5 = 40; % Same as reactant stream
enthalpy5 = enthalpyReact;
heat5 = flow5 .* enthalpy5;

% Stream 6 calculations
temp6 = temp5; % Liquid phase
enthalpy6 = [calcEnth_CO2(25, temp6) calcEnth_H2(25, temp6) - 0.904 calcEnth_Methanol(25, temp6) calcEnth_Water(25, temp6)];
heat6 = flow6 .* enthalpy6;

% Cooling duty calculation
coolingDuty = (sum(heat5, "all") + sum(heat6, "all") - sum(heat4, "all")) / 3600;
fprintf("Cooling duty of C1: %0.2f Megawatts (heat loss if negative)", coolingDuty);

% Enthalpy calculation functions
%% CO2
function f = calcEnth_CO2(tStart, tEnd)
  func = @(T) 36.11e-3 + 4.233e-5*T - 2.887e-8*T.^2 + 7.464e-12*T.^3;
  f = integral(func, tStart, tEnd, 'ArrayValued', true);
end

%% H2
function f = calcEnth_H2(tStart, tEnd)
  func = @(T) 28.84e-3 + 7.65e-8*T + 0.3288e-8*T.^2 - 0.8698e-12*T.^3;
  f = integral(func, tStart, tEnd, 'ArrayValued', true);
end

%% Methanol
function f = calcEnth_Methanol(tStart, tEnd)
  if tStart < 65 && tEnd < 65
    func = @(T) 75.86e-3 + 16.83e-5*T;
  else
    func = @(T) 42.93e-3 + 8.301e-5*T - 1.87e-8*T.^2 - 8.03e-12*T.^3;
  end
  f = integral(func, tStart, tEnd, 'ArrayValued', true);
end

%% Water
function f = calcEnth_Water(tStart, tEnd)
  if tStart < 100 && tEnd < 100
    func = @(T) 75.4e-3;
  else
    func = @(T) 33.46e-3 + 0.688e-5*T + 0.7604e-8*T.^2 - 3.593e-12*T.^3;
  end
  f = integral(func, tStart, tEnd, 'ArrayValued', true);
end


