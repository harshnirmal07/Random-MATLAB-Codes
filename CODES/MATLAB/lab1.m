

%% Method 1: Using linsolve

% Coefficient matrix representing mole fractions of components (CO2, H2, CH3OH, H2O)
% in Streams 3, 4, 5, and 6
A = [0.176 0.243 0.744 0;
    0.53 0.752 0.027 0;
    0.147 0.004 0.188 0;
    0.147 0.001 0.041 1];

% Right-hand side vector representing mole fractions in Stream 7 multiplied by the total molar flow rate of Stream 7 (893.263 kmol)
b = [893.263 * 0.002;
    893.263 * 0;
    893.263 * 0.987;
    893.263 * 0.011];

% Solving the system of linear equations using linsolve

% The linsolve function in MATLAB is used to solve a system of linear equations.
% Here A is the coefficient matrix and B is the right-hand side vector. The function returns the solution vector X that satisfies AX = B 

Ans = linsolve(A, b);
Ans   % Display the solution vector U




%% Method 2: Using \


% Solve the system of linear equations using the backslash (\) operator
% The backslash(\) operator in MATLAB is used to solve a system of linear equations of the form Ax = B. It is used to calculate the left division between two matrices. 

Augment = A\b;
Augment

%% Validating the results using Gauss Elimination 

A=[0.176 0.243 0.744 0 ;
 0.53 0.752 0.027 0 ;
 0.147 0.004 0.188 0 ;
 0.147 0.001 0.041 1];
b=[893.263*0.002;
  893.263*0;
  893.263*0.987;
  893.263*0.011];
% A is the matrix for mole fractions of components (CO2,H2,CH3OH and H2O) in Stream 3,4,5 and 6
% B is the matrix for mole fractions of components in stream 7 multiplied with the total molar flow rate of stream 7 which is given to be 893.263kmol\

n=length(b);

% Forward elimination with partial pivoting
for k = 1:n-1
    % Find the row index with the largest absolute value in the column
    [~, max_row] = max(abs(A(k:n, k)));
    max_row = max_row + k - 1;  % Adjust the index to the global row
    
    % Swap rows in matrix A and vector b for partial pivoting
    A([k, max_row], :) = A([max_row, k], :);
    b([k, max_row]) = b([max_row, k]);
    
    % Loop through rows below the pivot (k)
    for i = k+1:n
        % Calculate the multiplier to eliminate A(i,k)
        m = A(i,k) / A(k,k);
        
        % Loop through columns to the right of the pivot (k)
        for j = k+1:n
            % Update the elements of the current row of A
            A(i,j) = A(i,j) - m * A(k,j);
        end
        
        % Update the elements of the right-hand side vector b
        b(i) = b(i) - m * b(k);
    end
end

% Backward substitution

% Calculate the last solution component
Sol(n) = b(n) / A(n,n);

% Loop through rows in reverse order
for i = n-1:-1:1
    % Initialize a sum with the right-hand side value
    Sum = b(i);
    
    % Loop through columns to the right of the pivot (i)
    for j = i+1:n
        % Subtract contributions from A and the solution vector g
        Sum = Sum - A(i,j) * Sol(j);
    end
    
    % Calculate the current solution component
    Sol(i) = Sum / A(i,i);
end
Sol %Solution vector
