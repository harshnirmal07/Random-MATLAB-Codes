% Define the Biot number and other parameters
Bi = 10;
N = 5;

tau_values = [0.001, 0.01, 0.1];
X = linspace(0, 1, 100);

% Define the initial guesses for lambda
lambda_initial_guesses = linspace(0.1, 10, 100);

% Solve for lambda using fsolve
lambda_values = zeros(1, N);
options = optimoptions('fsolve', 'Display', 'off');
for i = 1:N
    fun = @(lambda) lambda * tan(lambda) - Bi;
    lambda_values(i) = fsolve(fun, lambda_initial_guesses(i), options);
end

% Define the PDE system
m = 0;
x = linspace(0, 1, 100);
t = linspace(0, 0.1, 100);
sol = pdepe(m, @pdefun, @icfun, @bcfun, x, t);

% Plotting the solution

%% 1
figure(1)
plot(x,sol)
hold on
title('Spatio-Temporal Temperature Profiles')
xlabel('Position, X')
ylabel('Time, Tau')
zlabel('Temperature, Theta')

%% 2
figure(2)
surf(x , t , sol)
hold on
title('Spatio-Temporal Temperature Profiles')
xlabel('Position, X')
ylabel('Time, Tau')
zlabel('Temperature, Theta')
