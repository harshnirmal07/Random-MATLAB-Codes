
%% Q3

%If the processes in Q2 are carried out irreversibly but so as to accomplish exactly the same changes of states 

% Mechanically Reversible Adiabatic
% Since in this process is 80% efficient compared to actual work

W_irrev = W_adia/0.8;

Q_irrev = U_adia- W_irrev

P_irrev = (P1/T1)*(T2+(Cv/R)*(T2-T1)) %Adiabatic
V_irrev = (P1*(V1^gamma)/P_irrev)^(1/gamma)

% for irreversible cooling process
W_conP;

W_irrev1 = W_conP/0.8

U_irrev1 = U_conP

Q_irrev1 = U_irrev1 - W_irrev1

P_irrev2 = P_irrev % since it is at constant pressure
V_irrev2 = -(W_irrev1/P_irrev) + V_irrev

%Expanded isothermally

W_irrev2 = W_iso/0.8

Q_irrev2 = U_iso - W_irrev2




% Overall U=Q+W
Q_irOver = Q_irrev + Q_irrev1 + Q_irrev2

W_irOver = W_irrev + W_irrev1 + W_irrev2

% Adiabatic
figure(1)
x_0 = linspace(V1,V_irrev,100)
y_0 = P1*V1^(gamma)./x.^(gamma)
plot(x_0,y_0)
hold on


% const P
x_1 = linspace(V_irrev,V_irrev2,100)
y_1 = P2*ones(1,100);
plot(x_1,y_1)


%Isothermal
x_2 = V_irrev2*ones(1,100)
y_2 = linspace(P_irrev2,P1,100)
plot(x_2,y2)

x_3 = linspace(V_irrev2,V1,100)
y_3 = P1*ones(1,100)
hold on
plot(x_3,y_3)
ylabel('Pressure');
xlabel('Volume');
title('Pressure vs Volume curve of Irreversible');


