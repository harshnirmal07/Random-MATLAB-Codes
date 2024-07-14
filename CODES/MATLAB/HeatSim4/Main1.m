% Define the Biot number and other parameters
Biot = 10;
NumberOfTerms = 3;
TimeValues = [0.05, 0.1, 1];
PositionValues = linspace(0, 1, 100);

% Define the initial guesses for eigenvalues
InitialGuessesForEigenvalues = linspace(0.1, 10, 100);

% Solve for eigenvalues using fsolve
Eigenvalues = zeros(1, NumberOfTerms);
SolverOptions = optimoptions('fsolve', 'Display', 'off');
for TermIndex = 1:NumberOfTerms
    EquationToSolve = @(Eigenvalue) Eigenvalue * tan(Eigenvalue) - Biot;
    Eigenvalues(TermIndex) = fsolve(EquationToSolve, InitialGuessesForEigenvalues(TermIndex), SolverOptions);
end

% Calculate and plot the solution for each time value

figure(1)
hold on

for TimeIndex = 1:length(TimeValues)
    CurrentTime = TimeValues(TimeIndex);
    TemperatureProfile = zeros(length(PositionValues), 1);
    for TermIndex = 1:NumberOfTerms
        CurrentEigenvalue = Eigenvalues(TermIndex);
        TemperatureProfile = TemperatureProfile + (4 * sin(CurrentEigenvalue) / (2 * CurrentEigenvalue + sin(2 * CurrentEigenvalue))) * cos(CurrentEigenvalue * PositionValues) * exp(-CurrentEigenvalue^2 * CurrentTime);
    end
    plot(PositionValues, TemperatureProfile);
end

title('Temperature Profile for Different Time Values')
xlabel('Position')
ylabel('Temperature')
legend('Time = 0.05', 'Time = 0.1', 'Time = 1');
grid on 

%% Change the Biot number and plot Temperature vs time at Position=0

BiotNumbers = linspace(1,10,10 );
TimeValues = linspace(0, 2, 100);

figure(2)
hold on

% Create an empty cell array for the legend
legendInfo = cell(length(BiotNumbers), 1);

for BiotIndex = 1:length(BiotNumbers)
    Biot = BiotNumbers(BiotIndex);
    TemperatureProfile = zeros(length(TimeValues), 1);
    for TimeIndex = 1:length(TimeValues)
        CurrentTime = TimeValues(TimeIndex);
        for TermIndex = 1:NumberOfTerms
            CurrentEigenvalue = Eigenvalues(TermIndex);
            TemperatureProfile(TimeIndex) = TemperatureProfile(TimeIndex) + (4 * sin(CurrentEigenvalue) / (2 * CurrentEigenvalue + sin(2 * CurrentEigenvalue))) * cos(CurrentEigenvalue * 0) * exp(-CurrentEigenvalue^2 * CurrentTime);
        end
    end
    plot(TimeValues, TemperatureProfile);
    % Add the Biot number to the legend
    legendInfo{BiotIndex} = ['Biot Number = ', num2str(Biot)];
end


title('Temperature Profile for Different Biot Numbers')
xlabel('Time')
ylabel('Temperature')
legend('legendInfo')
grid on
hold off

%% Compare the temporal profile for BiotNumber=0.1 with the lumped solution
Biot = 0.1;
LumpedSolution = exp(-Biot * TimeValues);

figure(3)
hold on
plot(TimeValues, LumpedSolution);

TemperatureProfile = zeros(length(TimeValues), 1);

for TimeIndex = 1:length(TimeValues)
    CurrentTime = TimeValues(TimeIndex);
    for TermIndex = 1:NumberOfTerms
        CurrentEigenvalue = Eigenvalues(TermIndex);
        TemperatureProfile(TimeIndex) = TemperatureProfile(TimeIndex) + (4 * sin(CurrentEigenvalue) / (2 * CurrentEigenvalue + sin(2 * CurrentEigenvalue))) * cos(CurrentEigenvalue * 0) * exp(-CurrentEigenvalue^2 * CurrentTime);
    end
end

plot(TimeValues, TemperatureProfile)

title('Comparison of Temporal Profiles for Biot Number=0.1')
xlabel('Time')
ylabel('Temperature')
legend('Lumped Solution', 'Series Solution')
grid on 
hold off





