clc 
clear 

%calculating the values of lambda 

func = @(lambda) lambda*tan(lambda)-10 ;
lambdainit = [1,2,7,9];

for i = 1:length(lambdainit)
lambda(i)= fsolve(func,lambdainit(i));
end

% Part 1

x = linspace(0,1,100);

% here t = 0.05
theta1 = (4*sin(lambda(1))/(2*lambda(1)+sin(2*lambda(1))))*(cos(lambda(1)*x))*(exp(-(lambda(1)^2)*0.05));
theta2 = (4*sin(lambda(2))/(2*lambda(2)+sin(2*lambda(2))))*(cos(lambda(2)*x))*(exp(-(lambda(2)^2)*0.05));
theta3 = (4*sin(lambda(3))/(2*lambda(3)+sin(2*lambda(3))))*(cos(lambda(3)*x))*(exp(-(lambda(3)^2)*0.05)) + theta1 + theta2;

figure
plot(x,theta1)
hold on 
plot(x,theta3)
hold on

title("Theta vs X  for t = 0.05 ")
xlabel("x from 0 to 1")
ylabel("Theta")
legend("For N =1 ","For N = 3")

%% part 2

% plot of Theta vs x at N =1 and N=3 respectively  for t = 0.1
x1 = linspace(0,1,100);

% Here t = 0.1
theta1_01 = (4*sin(lambda(1))/(2*lambda(1)+sin(2*lambda(1))))*(cos(lambda(1)*x1))*(exp(-(lambda(1)^2)*0.1));
theta2_01 = (4*sin(lambda(2))/(2*lambda(2)+sin(2*lambda(2))))*(cos(lambda(2)*x1))*(exp(-(lambda(2)^2)*0.1));
theta3_01 = (4*sin(lambda(3))/(2*lambda(3)+sin(2*lambda(3))))*(cos(lambda(3)*x1))*(exp(-(lambda(3)^2)*0.1)) + theta1_01 + theta2_01;

figure
plot(x1,theta1_01)
hold on 
plot(x1,theta3_01)

title("Theta vs X  for t = 0.1 ")
xlabel("x from 0 to 1")
ylabel("Theta")
legend("For N =1 ","For N = 3")

% plot of Theta vs x at N =1 and N=3 respectively  for t = 0.2

% here t = 0.2
theta1_02 = (4*sin(lambda(1))/(2*lambda(1)+sin(2*lambda(1))))*(cos(lambda(1)*x))*(exp(-(lambda(1)^2)*0.2));
theta2_02 = (4*sin(lambda(2))/(2*lambda(2)+sin(2*lambda(2))))*(cos(lambda(2)*x))*(exp(-(lambda(2)^2)*0.2));
theta3_02 = (4*sin(lambda(3))/(2*lambda(3)+sin(2*lambda(3))))*(cos(lambda(3)*x))*(exp(-(lambda(3)^2)*0.2)) + theta1_02 + theta2_02;

figure
plot(x,theta1_02)
hold on 
plot(x,theta3_02)
hold on

title("Theta vs X  for t = 0.2 ")
xlabel("x from 0 to 1")
ylabel("Theta")
legend("For N =1 ","For N = 3")


% plot of Theta vs x at N =1 and N=3 respectively  for t = 1

% here t = 1
theta1_1 = (4*sin(lambda(1))/(2*lambda(1)+sin(2*lambda(1))))*(cos(lambda(1)*x))*(exp(-(lambda(1)^2)*1));
theta2_1 = (4*sin(lambda(2))/(2*lambda(2)+sin(2*lambda(2))))*(cos(lambda(2)*x))*(exp(-(lambda(2)^2)*1));
theta3_1 = (4*sin(lambda(3))/(2*lambda(3)+sin(2*lambda(3))))*(cos(lambda(3)*x))*(exp(-(lambda(3)^2)*1)) + theta1_1 + theta2_1;

figure
plot(x,theta1_1)
hold on 
plot(x,theta3_1)


title("Theta vs X  for t = 1 ")
xlabel("x from 0 to 1")
ylabel("Theta")
legend("For N =1 ","For N = 3")

% plot of Theta vs x at N =1 and N=3 respectively  for t = 10

theta1_10 = (4*sin(lambda(1))/(2*lambda(1)+sin(2*lambda(1))))*(cos(lambda(1)*x))*(exp(-(lambda(1)^2)*10));
theta2_10 = (4*sin(lambda(2))/(2*lambda(2)+sin(2*lambda(2))))*(cos(lambda(2)*x))*(exp(-(lambda(2)^2)*10));
theta3_10 = (4*sin(lambda(3))/(2*lambda(3)+sin(2*lambda(3))))*(cos(lambda(3)*x))*(exp(-(lambda(3)^2)*10)) + theta1_10 + theta2_10;

figure

plot(x,theta1_10)
hold on 
plot(x,theta3_10)


title("Theta vs X  for t = 10 ")
xlabel("x from 0 to 1")
ylabel("Theta")
legend("For N =1 ","For N = 3")

% Yes, spatial temperature profile merge as the time increases which can be
% clearly seen in the plots obtained. The plot after t = 0.2 merges.
%% part 3

% N = 3
% for t = 0-2
t = linspace(0,2,1000);
theta1_vary = (4*sin(lambda(1))/(2*lambda(1)+sin(2*lambda(1))))*(cos(lambda(1)*0))*(exp(-(lambda(1)^2)*t));
theta2_vary = (4*sin(lambda(2))/(2*lambda(2)+sin(2*lambda(2))))*(cos(lambda(2)*0))*(exp(-(lambda(2)^2)*t));
theta3_vary = (4*sin(lambda(3))/(2*lambda(3)+sin(2*lambda(3))))*(cos(lambda(3)*0))*(exp(-(lambda(3)^2)*t)) + theta1_vary + theta2_vary;

figure
plot(t,theta3_vary)
hold on 

% plotting Theta vs t for Biot number = 1 where t varies from 0 to 2


func = @(lambda_1) lambda_1*tan(lambda_1)-1 ;
lambdainit = [1,2,7,9];

for i = 1:length(lambdainit)
lambda_1(i)= fsolve(func,lambdainit(i));
end

t = linspace(0,2,1000);
Theta_1 = (4*sin(lambda_1(1))/(2*lambda_1(1)+sin(2*lambda_1(1))))*(cos(lambda_1(1)*0))*(exp(-(lambda_1(1)^2)*t));
Theta_2 = (4*sin(lambda_1(2))/(2*lambda_1(2)+sin(2*lambda_1(2))))*(cos(lambda_1(2)*0))*(exp(-(lambda_1(2)^2)*t));
Theta_3 = (4*sin(lambda_1(3))/(2*lambda_1(3)+sin(2*lambda_1(3))))*(cos(lambda_1(3)*0))*(exp(-(lambda_1(3)^2)*t)) + Theta_1 + Theta_2;


plot(t,Theta_3)
hold on

title("Theta vs t ")
xlabel("t from 0 to 2")
ylabel("Theta")
legend("For Bi = 10","For Bi = 1")
hold on

% With Bi = 10 decays faster.

%% part 4

%N = 3 

func = @(lambda_1) lambda_1*tan(lambda_1)-0.1 ;
lambdainit = [1,2,7,9];

for i = 1:length(lambdainit)
lambda_1(i)= fsolve(func,lambdainit(i));
end

t = linspace(0,10,1000);
Theta_1_new = (4*sin(lambda_1(1))/(2*lambda_1(1)+sin(2*lambda_1(1))))*(cos(lambda_1(1)*0))*(exp(-(lambda_1(1)^2)*t));
Theta_2_new = (4*sin(lambda_1(2))/(2*lambda_1(2)+sin(2*lambda_1(2))))*(cos(lambda_1(2)*0))*(exp(-(lambda_1(2)^2)*t));
Theta_3_new = (4*sin(lambda_1(3))/(2*lambda_1(3)+sin(2*lambda_1(3))))*(cos(lambda_1(3)*0))*(exp(-(lambda_1(3)^2)*t)) + Theta_1_new + Theta_2_new;

figure
plot(t,Theta_3)
hold on 

% plotting Theta vs t of a lumped solution for Bi = 0.1
% N = 3
% t = 0-2

theta_lumped = exp(-(0.1)*(t));

plot(t,theta_lumped)

title("Theta vs t x =0 and Bi = 0.1 ")
xlabel("variation of t from 0 to 2")
ylabel("Theta")
legend("Temperature profile ","Lumped solution")

