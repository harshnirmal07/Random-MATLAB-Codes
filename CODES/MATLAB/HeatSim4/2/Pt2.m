clc 
clear 

m=0;
X = linspace(0,1,100);
T = linspace(0,1,100);
sol = pdepe(m,@pdefun,@icfun,@bcfun,X,T);

theta = sol(:,:,1);

figure(1)

surf(X,T,theta);
xlabel('tau');
ylabel('X');
zlabel('Theta');
title('Spatio-Temporal Temperature Profile');

%% Part 2

theta1 = linspace(0,1,100);
figure(2)


plot(theta1,calc_Theta(linspace(0,1,100),0.001))
hold on 
plot(theta1,calc_Theta(linspace(0,1,100),0.01))
hold on
plot(theta1,calc_Theta(linspace(0,1,100),0.1))
title("Theta vs X")
xlabel("X")
ylabel("Theta")
legend("t= 0.001","t=0.01","t=0.1")


function Theta = calc_Theta(x, t)
fun = @(lambda) lambda*tan(lambda)-10 ;
lambda0 = [1,2,7,9,11];

for i = 1:length(lambda0)
lambda(i)= fsolve(fun,lambda0(i));
end

Theta1 = (4*sin(lambda(1))/(2*lambda(1)+sin(2*lambda(1))))*(cos(lambda(1)*x))*(exp(-(lambda(1)^2)*t));
Theta2 = (4*sin(lambda(2))/(2*lambda(2)+sin(2*lambda(2))))*(cos(lambda(2)*x))*(exp(-(lambda(2)^2)*t));
Theta3 = (4*sin(lambda(3))/(2*lambda(3)+sin(2*lambda(3))))*(cos(lambda(3)*x))*(exp(-(lambda(3)^2)*t)) + Theta1 + Theta2;
Theta4 = (4*sin(lambda(4))/(2*lambda(4)+sin(2*lambda(4))))*(cos(lambda(4)*x))*(exp(-(lambda(4)^2)*t));
Theta5 = (4*sin(lambda(5))/(2*lambda(5)+sin(2*lambda(5))))*(cos(lambda(5)*x))*(exp(-(lambda(5)^2)*t)) + Theta3 + Theta4;
Theta = Theta5;
end