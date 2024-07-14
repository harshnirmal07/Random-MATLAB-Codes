clc

clear all


%% Q2 Thermodynamics

R = 8.314
Cv = 3/2*R
Cp = 5/2*R
gamma = Cp/Cv

T1 = 70+273 % K
T2 = 150+273 % k
P1 = 1  % bar
%% Take Basis of 1mol n=1
% for adiabatic compression


Q_adia = 0;

U_adia = Cv*(T2-T1);
W_adia = U_adia;

H_adia = Cp*(T2-T1);

P2 = P1*(T2/T1)^((gamma)/(gamma-1))


V1 = R*T1/P1
V2 = R*T2/P2

%% for constant pressure

Q_conP = Cp*(T1-T2) % Joules
U_conP = Cv*(T1-T2)
H_conP = Q_conP;
W_conP = U_conP-Q_conP

V_consP = -(W_conP/P2) + V2


%% for Isothermal process

Q_iso = R*T1*log(P2/P1) % Joules

W_iso = -Q_iso;

U_iso = 0;




%% For complete process

Q_cyc = Q_adia + Q_iso + Q_conP;

W_cyc = W_iso + W_conP + W_adia

U_cyc = U_conP + U_iso + U_adia

H_cyc = H_adia + H_conP + 0



figure(1)
%Adiabatic
x = linspace(V1,V2,100)
y = P1*V1^(gamma)./x.^(gamma)
plot(x,y)
hold on


%Constant P
figure(2)
x1 = linspace(V2,V_consP,100)
y1 = P2*ones(1,100);
plot(x1,y1)

figure(3)
% Isothermal
x2 = linspace(V_consP,V1,100)
y2 = P2*V_consP./x2
plot(x2,y2)


figure(4)
plot(x,y);hold on
plot(x1,y1);hold on
plot(x2,y2);hold on
ylabel('Pressure');
xlabel('Volume');
title('Pressure vs Volume curve of the process');