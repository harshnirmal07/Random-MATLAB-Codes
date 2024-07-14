% Define the Biot number and other parameters
Bi = 10;
N = 3;
tau_values = [0.05, 0.1, 1];
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

% Calculate and plot the solution for each tau value
figure;
hold on;
for i = 1:length(tau_values)
    tau = tau_values(i);
    Theta = zeros(length(X), 1);
    for n = 1:N
        lambda = lambda_values(n);
        Theta = Theta + (4 * sin(lambda) / (2 * lambda + sin(2 * lambda))) * cos(lambda * X) * exp(-lambda^2 * tau);
    end
    plot(X, Theta);
end
title('Temperature Profile for Different Tau Values');
xlabel('X')
ylabel('Theta')
legend('Tau = 0.05', 'Tau = 0.1', 'Tau = 1');
grid on 
hold off

% Now let's change the Biot number and plot Theta vs tau at X=0
Bi_values = [10, 1];
tau_values = linspace(0, 2, 100);
figure;
hold on;
for i = 1:length(Bi_values)
    Bi = Bi_values(i);
    Theta = zeros(length(tau_values), 1);
    for j = 1:length(tau_values)
        tau = tau_values(j);
        for n = 1:N
            lambda = lambda_values(n);
            Theta(j) = Theta(j) + (4 * sin(lambda) / (2 * lambda + sin(2 * lambda))) * cos(lambda * 0) * exp(-lambda^2 * tau);
        end
    end
    plot(tau_values, Theta);
end
title('Temperature Profile for Different Biot Numbers');
xlabel('Tau')
ylabel('Theta')
legend('Bi = 10', 'Bi = 1');
grid on 
hold off

% Finally, let's compare the temporal profile for Bi=0.1 with the lumped solution
Bi = 0.1;
Theta_lumped = exp(-Bi * tau_values);
figure;
hold on;
plot(tau_values, Theta_lumped);
Theta = zeros(length(tau_values), 1);
for j = 1:length(tau_values)
    tau = tau_values(j);
    for n = 1:N
        lambda = lambda_values(n);
        Theta(j) = Theta(j) + (4 * sin(lambda) / (2 * lambda + sin(2 * lambda))) * cos(lambda * 0) * exp(-lambda^2 * tau);
    end
end
plot(tau_values, Theta);
title('Comparison of Temporal Profiles for Bi=0.1');
xlabel('Tau')
ylabel('Theta')
legend('Lumped Solution', 'Series Solution');
grid on
hold off


