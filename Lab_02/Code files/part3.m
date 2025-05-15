% WIMALASOORIYA G.H.N.P.D.
% 2022E039

% Define numerator and denominator
b = [1 0 0 0 4];  % Z^4 + 4
a = [4 0 0 0 1];  % 4Z^4 + 1

% Plot pole-zero map
figure;
zplane(b, a);
title('Pole-Zero Map of H(z)');
xlabel('Real Part');
ylabel('Imaginary Part');
grid on;

% Find zeros (roots of numerator)
zeros_H = roots(b);

% Find poles (roots of denominator)
poles_H = roots(a);

% Frequency response using freqz
[H, w] = freqz(b, a, 512);

% Magnitude Response
figure;
plot(w/pi, abs(H));
title('Magnitude Response of H(z)');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('|H(e^{j\omega})|');
grid on;

% Phase Response
figure;
plot(w/pi, angle(H));
title('Phase Response of H(z)');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Phase (radians)');
grid on;

