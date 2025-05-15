% WIMALASOORIYA G.H.N.P.D.
% 2022E039

% Define the coefficients of the numerator
b = [5 0 0 0 26 0 0 0 5];  % 5Z^8 + 26Z^4 + 5

% Define the denominator (just 1)
a = 1;

% Find the zeros
zeros_G = roots(b);

% Plot the pole-zero map (no poles)
figure;
zplane(b, a);
title('Pole-Zero Map of G(Z)');
xlabel('Real Part');
ylabel('Imaginary Part');
grid on;

% Display the zeros
disp('Zeros of G(Z):');
disp(zeros_G);

% Use fvtool to analyze the filter
fvtool(b, a);

